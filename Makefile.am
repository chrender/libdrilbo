
# Makefile.am
#
# This file is part of fizmo.
#
# Copyright (c) 2009-2017 Christoph Ender.
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


AUTOMAKE_OPTIONS = -Wno-override

localedir = $(datarootdir)/fizmo/locales

if FIZMO_DIST_BUILD
  dev_prefix=$(FIZMO_DIST_BUILD_PREFIX)
  pkg_prefix=$(FIZMO_DIST_BUILD_PREFIX)
else
  dev_prefix=$(DESTDIR)/$(prefix)
  pkg_prefix=$(prefix)
endif

pkg_dir = $(dev_prefix)/lib/pkgconfig
pkgfile = $(pkg_dir)/libdrilbo.pc

SUBDIRS = src/drilbo .
noinst_LIBRARIES = libdrilbo.a

libdrilbo.a::
	cd src/drilbo ; make
	mv src/drilbo/libdrilbo.a .

install-dev:: libdrilbo.a
	mkdir -p "$(dev_prefix)"/lib/fizmo
	cp libdrilbo.a "$(dev_prefix)"/lib/fizmo
	mkdir -p "$(dev_prefix)"/include/fizmo/drilbo
	cp src/drilbo/*.h "$(dev_prefix)"/include/fizmo/drilbo
	mkdir -p "$(pkg_dir)"
	echo 'prefix=$(pkg_prefix)' >"$(pkgfile)"
	echo 'exec_prefix=$${prefix}' >>"$(pkgfile)"
	echo 'libdir=$${exec_prefix}/lib/fizmo' >>"$(pkgfile)"
	echo 'includedir=$${prefix}/include/fizmo' >>"$(pkgfile)"
	echo >>"$(pkgfile)"
	echo 'Name: libdrilbo' >>"$(pkgfile)"
	echo 'Description: libdrilbo' >>"$(pkgfile)"
	echo 'Version: 0.2.12' >>"$(pkgfile)"
	echo 'Requires: $(LIBDRILBO_REQS)' >>"$(pkgfile)"
	echo 'Requires.private:' >>"$(pkgfile)"
	echo 'Cflags: -I$(pkg_prefix)/include/fizmo' >>"$(pkgfile)"
	echo 'Libs: -L$(pkg_prefix)/lib/fizmo -ldrilbo -lpthread $(LIBX11_NONPKG_LIBS) $(LIBJPEG_NONPKG_LIBS) $(LIBPNG_NONPKG_LIBS)' >>"$(pkgfile)"
	echo 'Libs.private:' >>"$(pkgfile)"
	echo >>"$(pkgfile)"

install-data-local::
	mkdir -p "$(DESTDIR)$(localedir)"
	for l in `cd src/locales ; ls -d ??_??`; \
	do \
	  mkdir -p "$(DESTDIR)$(localedir)/$$l" ; \
	  cp src/locales/$$l/*.txt "$(DESTDIR)$(localedir)/$$l" ; \
	done

# About "-rmdir": make ignores errors of commands which are prefixed with
# a - sign. rmdir may fail in clean-dev in case other libs have installed
# development files, or in case clean-dev has been run before.
clean-dev::
	-rm "$(dev_prefix)/lib/fizmo/libdrilbo.a"
	-rmdir "$(dev_prefix)/lib/fizmo"
	rm -rf "$(dev_prefix)/include/fizmo/drilbo"
	-rmdir "$(dev_prefix)/include/fizmo"
	-rm "$(pkgfile)"

