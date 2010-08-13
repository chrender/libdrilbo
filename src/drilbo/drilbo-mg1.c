
/* drilbo-mg1.c
 *
 * This file is part of fizmo.
 *
 * Copyright (c) 2009-2010 Christoph Ender.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#ifndef drilbo_mg1_c_INCLUDED
#define drilbo_mg1_c_INCLUDED

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

#include "drilbo-mg1.h"

#define CODE_SIZE 8
#define CODE_TABLE_SIZE 4096
#define MAX_BIT 512 /* Must be less than or equal to CODE_TABLE_SIZE */
#define PREFIX 0
#define PIXEL 1


struct mg1_header
{
  uint8_t part;
  uint8_t flags;
  //uint16_t unknown1;
  uint16_t nof_images;
  //uint16_t unknown2;
  uint8_t dir_size;
  //uint8_t unknown3;
  uint16_t checksum;
  //uint16_t unknown4;
  uint16_t version;
};

struct mg1_image_entry
{
  uint16_t number;
  uint16_t width;
  uint16_t height;
  uint16_t flags;
  uint32_t data_addr;
  uint32_t cm_addr;
};

struct mg1_color {
  uint8_t red;
  uint8_t green;
  uint8_t blue;
};

struct mg1_colormap {
  uint8_t nof_colors;
  struct mg1_color colors[16];
};

// The colormap data for the default EGA color palette was taken from
// http://en.wikipedia.org/wiki/Enhanced_Graphics_Adapter.
static uint8_t ega_colormap[16][3] =
{
  {   0,  0,  0 },
  {   0,  0,170 },
  {   0,170,  0 },
  {   0,170,170 },
  { 170,  0,  0 },
  { 170,  0,170 },
  { 170, 85,  0 }, // -> This is { 170,170, 0 } in pix2gif (?).
  { 170,170,170 },
  {  85, 85, 85 },
  {  85, 85,255 },
  {  85,255, 85 },
  {  85,255,255 },
  { 255, 85, 85 },
  { 255, 85,255 },
  { 255,255, 85 },
  { 255,255,255 }
};

static short mask[16] = { 
  0x0000, 0x0001, 0x0003, 0x0007,
  0x000f, 0x001f, 0x003f, 0x007f,
  0x00ff, 0x01ff, 0x03ff, 0x07ff,
  0x0fff, 0x1fff, 0x3fff, 0x7fff
};

typedef struct compress_s {
  short next_code;
  short slen;
  short sptr;
  short tlen;
  short tptr;
} compress_t;

static short code_table[CODE_TABLE_SIZE][2];
static unsigned char buffer[CODE_TABLE_SIZE];

static FILE *mg1_file = NULL;
static struct mg1_header header;
static struct mg1_image_entry *mg1_image_entries = NULL;


static int read_byte(FILE *in, uint8_t *byte)
{
  int data;

  if ((data = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  *byte = (uint8_t)data;

  return 0;
}


static int read_word(FILE *in, uint16_t *word)
{
  int lower, upper;

  if ((lower = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  if ((upper = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  *word = (lower & 0xff) | ((upper & 0xff) << 8);

  return 0;
}


static int read_24bit(FILE *in, uint32_t *data)
{
  int lower, middle, upper;

  if ((upper = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  if ((middle = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  if ((lower = fgetc(in)) == EOF)
  { fclose(in); return -1; }

  *data = (lower & 0xff) | ((middle & 0xff) << 8) | ((upper & 0xff) << 16);

  return 0;
}


int end_mg1_graphics()
{
  if (mg1_file != NULL)
    fclose(mg1_file);

  if (mg1_image_entries != NULL)
    free(mg1_image_entries);

  return 0;
}


int init_mg1_graphics(char *mg1_filename)
{
  int image_index;
  struct mg1_image_entry *image;

  if ((mg1_file = fopen(mg1_filename, "r")) == NULL)
    return -1;

  if ((read_byte(mg1_file, &header.part)) == -1)
    return -1;

  if ((read_byte(mg1_file, &header.flags)) == -1)
    return -1;

  if (fseek(mg1_file, 2, SEEK_CUR) == -1)
  { fclose(mg1_file); return -1; }

  if ((read_word(mg1_file, &header.nof_images)) == -1)
    return -1;

  if (fseek(mg1_file, 2, SEEK_CUR) == -1)
  { fclose(mg1_file); return -1; }

  if ((read_byte(mg1_file, &header.dir_size)) == -1)
    return -1;

  if (fseek(mg1_file, 1, SEEK_CUR) == -1)
  { fclose(mg1_file); return -1; }

  if ((read_word(mg1_file, &header.checksum)) == -1)
    return -1;

  if (fseek(mg1_file, 2, SEEK_CUR) == -1)
  { fclose(mg1_file); return -1; }

  if ((read_word(mg1_file, &header.version)) == -1)
    return -1;

  if ((mg1_image_entries
        = malloc(sizeof(struct mg1_image_entry) * header.nof_images)) == NULL)
  { fclose(mg1_file); return -1; }

  for (image_index=0; image_index<header.nof_images; image_index++)
  {
    image = &(mg1_image_entries[image_index]);

    if ((read_word(mg1_file, &image->number)) == -1)
    { free(mg1_image_entries); return -1; }

    if ((read_word(mg1_file, &image->width)) == -1)
    { free(mg1_image_entries); return -1; }

    if ((read_word(mg1_file, &image->height)) == -1)
    { free(mg1_image_entries); return -1; }

    if ((read_word(mg1_file, &image->flags)) == -1)
    { free(mg1_image_entries); return -1; }

    if ((read_24bit(mg1_file, &image->data_addr)) == -1)
    { free(mg1_image_entries); return -1; }

    if (header.dir_size == 14)
    {
      if ((read_24bit(mg1_file, &image->cm_addr)) == -1)
      { free(mg1_image_entries); return -1; }
    }
    else
      image->cm_addr = 0;
  }

  return 0;
}


uint16_t get_number_of_mg1_images()
{
  return mg1_file == NULL ? : header.nof_images;
}


uint16_t *get_all_picture_numbers()
{
  uint16_t *result;
  int image_index;

  if (mg1_file == NULL)
    return NULL;

  if ((result = (uint16_t*)malloc(sizeof(uint16_t) * header.nof_images))
      == NULL)
    return NULL;

  for (image_index = 0; image_index < header.nof_images; image_index++)
  {
    result[image_index] = mg1_image_entries[image_index].number;
  }

  return result;
}


static int get_image_index_from_number(int picture_number)
{
  int image_index;

  if (mg1_file == NULL)
    return -1;

  for (image_index = 0; image_index < header.nof_images; image_index++)
  {
    if (mg1_image_entries[image_index].number == picture_number)
      return image_index;
  }

  return -1;
}


static short read_code(FILE *fp, compress_t *comp, unsigned char *code_buffer)
{
  short code, bsize, tlen, tptr;

  code = 0;
  tlen = comp->tlen;
  tptr = 0;

  while (tlen)
  {
    if (comp->slen == 0)
    {
      if ((comp->slen = fread(code_buffer, 1, MAX_BIT, fp)) == 0)
      {
        perror("fread");
        exit (EXIT_FAILURE);
      }
      comp->slen *= 8;
      comp->sptr = 0;
    }

    bsize = ((comp->sptr + 8) & ~7) - comp->sptr;
    bsize = (tlen > bsize) ? bsize : tlen;
    code |= (((unsigned int) code_buffer[comp->sptr >> 3] >> (comp->sptr & 7)) & mask[bsize]) << tptr;

    tlen -= bsize;
    tptr += bsize;
    comp->slen -= bsize;
    comp->sptr += bsize;
  }

  if ((comp->next_code == mask[comp->tlen]) && (comp->tlen < 12))
    comp->tlen++;

  return (code);
}


z_image *get_picture(int picture_number)
{
  int image_index;
  struct mg1_colormap colormap;
  struct mg1_image_entry *image;
  int i;
  uint8_t *image_data, *img_data_ptr;
  short code, old = 0, first, clear_code;
  compress_t comp;
  unsigned char code_buffer[CODE_TABLE_SIZE];
  int pixel;
  z_image *result;

  image_index = get_image_index_from_number(picture_number);

  if (image_index < 0)
    return NULL;

  image = &mg1_image_entries[image_index];

  for (i = 0; i < 16; i++)
  {
    colormap.colors[i].red = ega_colormap[i][0];
    colormap.colors[i].green = ega_colormap[i][1];
    colormap.colors[i].blue = ega_colormap[i][2];
  }

  if (image->cm_addr != 0)
  {
    if (fseek(mg1_file, image->cm_addr, SEEK_SET) != 0)
      return NULL;

    if (read_byte(mg1_file, &colormap.nof_colors) == -1)
      return NULL;

    // Fix for some buggy _Arthur_ pictures.
    if (colormap.nof_colors > 14)
      colormap.nof_colors = 14;

    colormap.nof_colors += 2;

    for (i=2; i<colormap.nof_colors; i++)
    {
      if (read_byte(mg1_file, &colormap.colors[i].red) == -1)
        return NULL;
      if (read_byte(mg1_file, &colormap.colors[i].green) == -1)
        return NULL;
      if (read_byte(mg1_file, &colormap.colors[i].blue) == -1)
        return NULL;
    }
  }

  if (image->flags & 1)
  {
    colormap.colors[image->flags >> 12].red = 0;
    colormap.colors[image->flags >> 12].green = 0;
    colormap.colors[image->flags >> 12].blue = 0;

    //printf("Transparent color exists.");
  }

  if (fseek(mg1_file, image->data_addr, SEEK_SET) != 0)
    return NULL;

  if ((image_data = (uint8_t*)malloc(image->width * image->height * 3)) == NULL)
    return NULL;

  img_data_ptr = image_data;

  clear_code = 1 << CODE_SIZE;
  comp.next_code = clear_code + 2;
  comp.slen = 0;
  comp.sptr = 0;
  comp.tlen = CODE_SIZE + 1;
  comp.tptr = 0;

  for (i = 0; i < CODE_TABLE_SIZE; i++)
  {
    code_table[i][PREFIX] = CODE_TABLE_SIZE;
    code_table[i][PIXEL] = i;
  }

  for (;;)
  {
    if ((code = read_code (mg1_file, &comp, code_buffer)) == (clear_code + 1))
      break;

    if (code == clear_code)
    {
      comp.tlen = CODE_SIZE + 1;
      comp.next_code = clear_code + 2;
      code = read_code (mg1_file, &comp, code_buffer);
    }
    else
    {
      first = (code == comp.next_code) ? old : code;

      while (code_table[first][PREFIX] != CODE_TABLE_SIZE)
        first = code_table[first][PREFIX];

      code_table[comp.next_code][PREFIX] = old;
      code_table[comp.next_code++][PIXEL] = code_table[first][PIXEL];
    }
    old = code;

    i = 0;
    do
      buffer[i++] = (unsigned char) code_table[code][PIXEL];
    while ((code = code_table[code][PREFIX]) != CODE_TABLE_SIZE);

    do
    {
      pixel = buffer[--i];
      *(img_data_ptr++) = colormap.colors[pixel].red;
      *(img_data_ptr++) = colormap.colors[pixel].green;
      *(img_data_ptr++) = colormap.colors[pixel].blue;
    }
    while (i > 0);
  }

  if ((result = (z_image*)malloc(sizeof(z_image))) == NULL)
  { free(image_data); return NULL; }

  result->bits_per_sample = 8;
  result->width = image->width;
  result->height = image->height;
  result->image_type = DRILBO_IMAGE_TYPE_RGB;
  result->data = image_data;

  return result;
}

#endif /* drilbo_mg1_c_INCLUDED */

