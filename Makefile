
.PHONY : all install clean distclean

include config.mk

all: src/drilbo/libdrilbo.a

install: src/drilbo/libdrilbo.a
	mkdir -p $(INSTALL_PREFIX)/lib/fizmo
	cp src/drilbo/libdrilbo.a $(INSTALL_PREFIX)/lib/fizmo
	mkdir -p $(INSTALL_PREFIX)/include/fizmo/drilbo
	cp src/drilbo/*.h $(INSTALL_PREFIX)/include/fizmo/drilbo
	mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	  cp src/locales/$$l/* $(INSTALL_PREFIX)/share/fizmo/locales/$$l; \
	done

clean::
	cd src/drilbo ; make clean

distclean:: clean
	cd src/drilbo ; make distclean

src/drilbo/libdrilbo.a::
	cd src/drilbo ; make

