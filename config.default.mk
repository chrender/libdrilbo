
CC = gcc
AR = ar
CFLAGS = -Wall -Wextra

ifneq ($(DESTDIR),)
INSTALL_PREFIX = $(DESTDIR)
else
#INSTALL_PREFIX = /usr/local
INSTALL_PREFIX = $(HOME)/opt/fizmo
endif


# General:
ENABLE_OPTIMIZATION = 1
ENABLE_TRACING = 1
#ENABLE_GDB_SYMBOLS = 1


# drilbo:
DRILBO_PKG_REQS = x11, xext, libpng

DRILBO_ENABLE_X11 = 1
DRILBO_PKG_X11_CFLAGS = $(shell pkg-config --cflags x11) $(shell pkg-config --cflags xext)
DRILBO_PKG_X11_LIBS = $(shell pkg-config --libs x11) $(shell pkg-config --libs xext)
DRILBO_NONPKG_X11_CFLAGS =
DRILBO_NONPKG_X11_LIBS =

DRILBO_ENABLE_JPG = 1
DRILBO_PKG_LIBJPEG_CFLAGS =
DRILBO_PKG_LIBJPEG_LIBS =
DRILBO_NONPKG_LIBJPEG_CFLAGS = -I/opt/local/include
DRILBO_NONPKG_LIBJPEG_LIBS = -L/opt/local/lib -ljpeg

DRILBO_ENABLE_PNG = 1
DRILBO_PKG_LIBPNG_CFLAGS = $(shell pkg-config --cflags libpng)
DRILBO_PKG_LIBPNG_LIBS = $(shell pkg-config --libs libpng)
DRILBO_NONPKG_LIBPNG_CFLAGS =
DRILBO_NONPKG_LIBPNG_LIBS =

