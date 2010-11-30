
.PHONY : all install clean distclean

include config.mk


DRILBO_LIB_DIRS = -L$(FIZMO_LIB_DIR)/fizmo
DRILBO_INC_DIRS =
DRILBO_LIBS =


ifneq ($(DRILBO_ENABLE_X11),)
ifneq ($(X11_LIB_DIR),)
DRILBO_LIB_DIRS += -L$(X11_LIB_DIR)
endif

ifneq ($(X11_INC_DIR),)
DRILBO_INC_DIRS += -I$(X11_INC_DIR)
endif

DRILBO_INC_DIRS += -I$(FIZMO_INC_DIR)
DRILBO_LIBS += -lX11 -lXext -lpthread
endif # DRILBO_ENABLE_X11


ifneq ($(DRILBO_ENABLE_JPG),)
ifneq ($(LIBJPG_LIB_DIR),)
DRILBO_LIB_DIRS += -L$(LIBJPG_LIB_DIR)
endif

ifneq ($(LIBJPG_INC_DIR),)
DRILBO_INC_DIRS += -I$(LIBJPG_INC_DIR)
endif

DRILBO_LIBS += -ljpeg
endif # DRILBO_ENABLE_JPG


ifneq ($(DRILBO_ENABLE_PNG),)
ifneq ($(LIBPNG_LIB_DIR),)
DRILBO_LIB_DIRS += -L$(LIBPNG_LIB_DIR)
endif

ifneq ($(LIBPNG_INC_DIR),)
DRILBO_INC_DIRS += -I$(LIBPNG_INC_DIR)
endif

DRILBO_LIBS += -lpng
endif # DRILBO_ENABLE_PNG



all: src/drilbo/libdrilbo.a libdrilbo.mk

install: src/drilbo/libdrilbo.a libdrilbo.mk
	mkdir -p $(INSTALL_PREFIX)/lib/fizmo
	cp src/drilbo/libdrilbo.a $(INSTALL_PREFIX)/lib/fizmo
	mkdir -p $(INSTALL_PREFIX)/include/fizmo/drilbo
	cp src/drilbo/*.h $(INSTALL_PREFIX)/include/fizmo/drilbo
	cp libdrilbo.mk $(INSTALL_PREFIX)/include/fizmo
	mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	  cp src/locales/$$l/*.txt $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	done

libdrilbo.mk::
	echo > libdrilbo.mk
	echo DRILBO_LIB_DIRS = $(DRILBO_LIB_DIRS) >> libdrilbo.mk
	echo DRILBO_INC_DIRS = $(DRILBO_INC_DIRS) >> libdrilbo.mk
	echo DRILBO_LIBS = $(DRILBO_LIBS) >> libdrilbo.mk
	echo >> libdrilbo.mk

clean::
	cd src/drilbo ; make clean

distclean:: clean
	rm -f libdrilbo.mk
	cd src/drilbo ; make distclean

src/drilbo/libdrilbo.a::
	cd src/drilbo ; make

