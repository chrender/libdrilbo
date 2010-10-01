
# Please read "INSTALL.txt" before modifying these values.

CC = gcc
AR = ar
CFLAGS = -Wall -Wextra

ifneq ($(DESTDIR),)
INSTALL_PREFIX = $(DESTDIR)
else
INSTALL_PREFIX = /usr/local
endif
INSTALL_PREFIX = /Users/chrender/opt/fizmo

FIZMO_INC_DIR = $(INSTALL_PREFIX)/include
FIZMO_LIB_DIR = $(INSTALL_PREFIX)/lib

DEFAULT_PREFIX = /opt/local
DEFAULT_LIB_PREFIX = $(DEFAULT_PREFIX)/lib
DEFAULT_INC_PREFIX = $(DEFAULT_PREFIX)/include

DRILBO_ENABLE_X11 = 1
X11_LIB_DIR = $(DEFAULT_PREFIX)/lib/X11

DRILBO_ENABLE_JPG = 1
LIBJPG_LIB_DIR = $(DEFAULT_LIB_PREFIX)
LIBJPG_INC_DIR = $(DEFAULT_INC_PREFIX)

DRILBO_ENABLE_PNG = 1
LIBPNG_LIB_DIR = $(DEFAULT_LIB_PREFIX)
LIBPNG_INC_DIR = $(DEFAULT_INC_PREFIX)

# This adds an -O2 flag (usually okay):
ENABLE_OPTIMIZATION = 1

# Debug-Flags:

# Uncomment to fill your harddisk _very_ fast:
ENABLE_TRACING = 1

# Add GDB symbols, only useful for debuggong:
#ENABLE_GDB_SYMBOLS = 1

