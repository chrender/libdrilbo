
CC = gcc
AR = ar
override CFLAGS += -Wall -Wextra

prefix = /opt/local
destprefix = $(DESTDIR)$(prefix)
bindir = $(destprefix)/bin
datarootdir = $(destprefix)/share
mandir = $(datarootdir)/man
localedir = $(datarootdir)/fizmo/locales


# -----
# General settings:
ENABLE_OPTIMIZATION = 1
#ENABLE_TRACING = 1
#ENABLE_GDB_SYMBOLS = 1
# -----


# -----
# Settings for drilbo:
DRILBO_ENABLE_X11 = 1
DRILBO_ENABLE_JPG = 1
DRILBO_ENABLE_PNG = 1

# In case X11/Xext, libpng and/or libjpeg may be found using pkg-config,
# using the following lines will make fizmo locate the required files
# automatically:
DRILBO_PKG_REQS = x11, libpng #,libjpeg
DRILBO_PKG_X11_CFLAGS = $(shell pkg-config --cflags x11)
DRILBO_PKG_X11_LIBS = $(shell pkg-config --libs x11)
#DRILBO_PKG_LIBJPEG_CFLAGS = $(shell pkg-config --cflags libjpg)
#DRILBO_PKG_LIBJPEG_LIBS = $(shell pkg-config --libs libjpeg)
DRILBO_PKG_LIBPNG_CFLAGS = $(shell pkg-config --cflags libpng)
DRILBO_PKG_LIBPNG_LIBS = $(shell pkg-config --libs libpng)

# In case one or more packages are not localizable using pkg-config, you
# have to provide the required flags below:
DRILBO_NONPKG_X11_CFLAGS =
DRILBO_NONPKG_X11_LIBS =
DRILBO_NONPKG_LIBJPEG_CFLAGS = -I/opt/local/include
DRILBO_NONPKG_LIBJPEG_LIBS = -L/opt/local/lib -ljpeg
DRILBO_NONPKG_LIBPNG_CFLAGS =
DRILBO_NONPKG_LIBPNG_LIBS =
# -----

