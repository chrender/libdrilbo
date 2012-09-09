
AUTOMAKE_OPTIONS = -Wno-override

localedir = $(datarootdir)/fizmo/locales

if FIZMO_BUILD_PREFIX_EMPTY
  fizmo_build_prefix=$(DESTDIR)$(prefix)
endif

PKG_DIR = $(fizmo_build_prefix)/lib/pkgconfig
PKGFILE = $(PKG_DIR)/libdrilbo.pc

SUBDIRS = src/drilbo .
noinst_LIBRARIES = libdrilbo.a

libdrilbo.a:
	mv src/drilbo/libdrilbo.a .

install-dev:: libdrilbo.a
	mkdir -p "$(fizmo_build_prefix)"/lib/fizmo
	cp libdrilbo.a "$(fizmo_build_prefix)"/lib/fizmo
	mkdir -p "$(fizmo_build_prefix)"/include/fizmo/drilbo
	cp src/drilbo/*.h "$(fizmo_build_prefix)"/include/fizmo/drilbo
	mkdir -p "$(PKG_DIR)"
	echo 'prefix=$(fizmo_build_prefix)' >"$(PKGFILE)"
	echo 'exec_prefix=$${prefix}' >>"$(PKGFILE)"
	echo 'libdir=$${exec_prefix}/lib/fizmo' >>"$(PKGFILE)"
	echo 'includedir=$${prefix}/include/fizmo' >>"$(PKGFILE)"
	echo >>"$(PKGFILE)"
	echo 'Name: libdrilbo' >>"$(PKGFILE)"
	echo 'Description: libdrilbo' >>"$(PKGFILE)"
	echo 'Version: 0.2.3' >>"$(PKGFILE)"
	echo 'Requires: $(LIBDRILBO_REQS)' >>"$(PKGFILE)"
	echo 'Requires.private:' >>"$(PKGFILE)"
	echo 'Cflags: -I$(fizmo_build_prefix)/include/fizmo $(LIBDRILBO_NONPKG_CFLAGS) ' >>"$(PKGFILE)"
	echo 'Libs: -L$(fizmo_build_prefix)/lib/fizmo -ldrilbo -lpthread $(LIBDRILBO_NONPKG_LIBS)'  >>"$(PKGFILE)"
	echo >>"$(PKGFILE)"

install-locales::
	mkdir -p "$(DESTDIR)$(localedir)"
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p "$(DESTDIR)$(localedir)/$$l" ; \
	  cp src/locales/$$l/*.txt "$(DESTDIR)$(localedir)/$$l" ; \
	done

