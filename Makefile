
.PHONY : all install clean distclean

include config.mk

PKG_DIR = $(INSTALL_PREFIX)/lib/pkgconfig
PKGFILE = $(PKG_DIR)/libdrilbo.pc


all: libdrilbo.a

libdrilbo.a: src/drilbo/libdrilbo.a
	mv src/drilbo/libdrilbo.a .

install: src/drilbo/libdrilbo.a
	mkdir -p $(INSTALL_PREFIX)/lib/fizmo
	cp src/drilbo/libdrilbo.a $(INSTALL_PREFIX)/lib/fizmo
	mkdir -p $(INSTALL_PREFIX)/include/fizmo/drilbo
	cp src/drilbo/*.h $(INSTALL_PREFIX)/include/fizmo/drilbo
	mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	  cp src/locales/$$l/*.txt $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	done
	mkdir -p $(PKG_DIR)
	echo 'prefix=$(INSTALL_PREFIX)' >$(PKGFILE)
	echo 'exec_prefix=$${prefix}' >>$(PKGFILE)
	echo 'libdir=$${exec_prefix}/lib/fizmo' >>$(PKGFILE)
	echo 'includedir=$${prefix}/include/fizmo' >>$(PKGFILE)
	echo >>$(PKGFILE)
	echo 'Name: libdrilbo' >>$(PKGFILE)
	echo 'Description: libdrilbo' >>$(PKGFILE)
	echo 'Version: 0.2.0-b2' >>$(PKGFILE)
ifeq ($(DRILBO_PKG_REQS),)
	echo 'Requires: libfizmo >= 0.7 ' >>$(PKGFILE)
else
	echo 'Requires: libfizmo >= 0.7, $(DRILBO_PKG_REQS) ' >>$(PKGFILE)
endif
	echo 'Requires.private:' >>$(PKGFILE)
	echo 'Cflags: -I$(INSTALL_PREFIX)/include/fizmo $(DRILBO_NONPKG_X11_CFLAGS) $(DRILBO_NONPKG_LIBJPEG_CFLAGS) $(DRILBO_NONPKG_LIBPNG_CFLAGS) ' >>$(PKGFILE)
	echo 'Libs: -L$(INSTALL_PREFIX)/lib/fizmo -ldrilbo $(DRILBO_NONPKG_X11_LIBS) $(DRILBO_NONPKG_LIBJPEG_LIBS) $(DRILBO_NONPKG_LIBPNG_LIBS)'  >>$(PKGFILE)
	echo >>$(PKGFILE)

clean::
	cd src/drilbo ; make clean

distclean:: clean
	rm -f libdrilbo.a
	cd src/drilbo ; make distclean

src/drilbo/libdrilbo.a::
	cd src/drilbo ; make

