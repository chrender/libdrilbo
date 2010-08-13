
include ../../config.mk

ifneq ($(ENABLE_GDB_SYMBOLS),)
override CFLAGS += -g
endif

ifneq ($(ENABLE_OPTIMIZATION),)
override CFLAGS += -O2
endif

ifneq ($(ENABLE_TRACING),)
override CFLAGS += -DENABLE_TRACING=
endif

DRILBO_LIB_DIRS = -L$(FIZMO_LIB_DIR)/fizmo
DRILBO_INC_DIRS =
DRILBO_LIBS = -lfizmo
DRILBO_LIB_OBJECTS = drilbo.o drilbo-mg1.o drilbo-ppm.o ../locales/libdrilbo_locales.o
DRILBO_TEST_FLAGS =


ifneq ($(DRILBO_ENABLE_X11),)
  ifneq ($(X11_LIB_DIR),)
   DRILBO_LIB_DIRS += -L$(X11_LIB_DIR)
  endif

  ifneq ($(X11_INC_DIR),)
   DRILBO_INC_DIRS += -I$(X11_INC_DIR)
  endif

  DRILBO_INC_DIRS += -I$(FIZMO_INC_DIR)
  DRILBO_LIBS += -lX11 -lXext -lpthread
  DRILBO_TEST_FLAGS += -DTEST_X11
  DRILBO_LIB_OBJECTS += drilbo-x11.o
endif # DRILBO_ENABLE_X11


ifneq ($(DRILBO_ENABLE_JPG),)
  ifneq ($(LIBJPG_LIB_DIR),)
   DRILBO_LIB_DIRS += -L$(LIBJPG_LIB_DIR)
  endif

  ifneq ($(LIBJPG_INC_DIR),)
   DRILBO_INC_DIRS += -I$(LIBJPG_INC_DIR)
  endif

  DRILBO_LIBS += -ljpeg
  DRILBO_TEST_FLAGS += -DTEST_JPEG
  DRILBO_LIB_OBJECTS += drilbo-jpeg.o
endif # DRILBO_ENABLE_JPG


ifneq ($(DRILBO_ENABLE_PNG),)
  ifneq ($(LIBPNG_LIB_DIR),)
   DRILBO_LIB_DIRS += -L$(LIBPNG_LIB_DIR)
  endif

  ifneq ($(LIBPNG_INC_DIR),)
   DRILBO_INC_DIRS += -I$(LIBPNG_INC_DIR)
  endif

  DRILBO_LIBS += -lpng
  DRILBO_TEST_FLAGS += -DTEST_PNG
  DRILBO_LIB_OBJECTS += drilbo-png.o
endif # DRILBO_ENABLE_PNG



all: libdrilbo.a

test: drilbo-test
	./drilbo-test

../locales/libdrilbo_locales.o::
	cd ../locales ; make libdrilbo_locales.o

libdrilbo.a: $(DRILBO_LIB_OBJECTS)
	$(AR) rcs libdrilbo.a $(DRILBO_LIB_OBJECTS)

drilbo.o: drilbo.h drilbo.c
	$(CC) $(CFLAGS) $(DRILBO_INC_DIRS) -c drilbo.c

drilbo-ppm.o: drilbo-ppm.h drilbo-ppm.c
	$(CC) $(CFLAGS) $(DRILBO_INC_DIRS) -c drilbo-ppm.c

drilbo-mg1.o: drilbo-mg1.h drilbo-mg1.c
	$(CC) $(CFLAGS) -c drilbo-mg1.c

drilbo-jpeg.o:drilbo.h drilbo-jpeg.h drilbo-jpeg.c
	$(CC) $(CFLAGS) $(DRILBO_INC_DIRS) -c drilbo-jpeg.c

drilbo-png.o: drilbo.h drilbo-png.h drilbo-png.c
	$(CC) $(CFLAGS) $(DRILBO_INC_DIRS) -c drilbo-png.c

drilbo-x11.o: drilbo-x11.h drilbo-x11.c
	$(CC) $(CFLAGS) $(DRILBO_INC_DIRS) -c drilbo-x11.c

drilbo-test: libdrilbo.a drilbo-test.o
	$(CC) $(CFLAGS) drilbo.o drilbo-test.o -L. -ldrilbo $(DRILBO_LIB_DIRS) $(DRILBO_LIBS) -o drilbo-test

drilbo-test.o: drilbo-test.c libdrilbo.a
	$(CC) $(CFLAGS) $(DRILBO_TEST_FLAGS) $(DRILBO_INC_DIRS) -c drilbo-test.c

clean:
	rm -f *.o ad-RGB.jpg ad-YCbCr.jpg ad-Grayscale.jpg shogun.ppm tracelog.txt

distclean: clean
	rm -f libdrilbo.a

