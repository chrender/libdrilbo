
# Makefile.am
#
# This file is part of fizmo.
#
# Copyright (c) 2009-2012 Christoph Ender.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(libfizmo_CFLAGS) $(libx11_CFLAGS) $(libpng_CFLAGS) $(libjpeg_CFLAGS) -fPIC
AM_CPPFLAGS =
LDADD = $(libfizmo_LIBS) $(libx11_LIBS) $(libpng_LIBS) $(libjpeg_LIBS)

localedir = $(datarootdir)/fizmo/locales

noinst_LIBRARIES = libdrilbo.a
libdrilbo_a_SOURCES = ../locales/libdrilbo_locales.c drilbo.c \
 drilbo-mg1.c drilbo-ppm.o

if ENABLE_TRACING
AM_CFLAGS += -DENABLE_TRACING=
endif

if ENABLE_JPEG
AM_CFLAGS += -DENABLE_JPG=
libdrilbo_a_SOURCES += drilbo-jpeg.c
endif

if ENABLE_PNG
AM_CFLAGS += -DENABLE_PNG=
libdrilbo_a_SOURCES += drilbo-png.c
endif

if ENABLE_X11
AM_CFLAGS += -DENABLE_X11=
libdrilbo_a_SOURCES += drilbo-x11.c
endif

