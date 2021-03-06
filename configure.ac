
# configure.ac
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


AC_ARG_ENABLE([tracing],
 [AS_HELP_STRING([--enable-tracing],
   [enable tracelog for debugging])],
 [],
 [enable_tracing=no])

m4_include(config-flags.m4)

AC_INIT(
 [libdrilbo],
 [0.2.12],
 fizmo@spellbreaker.org,
 libdrilbo)

AC_CONFIG_AUX_DIR([.])

libdrilbo_reqs="libfizmo >= 0.7.15"
libdrilbo_nonpkg_cflags=""
libdrilbo_nonpkg_libs=""

PKG_CHECK_MODULES([libfizmo], [libfizmo >= 0.7.15])

m4_include(config-libs.m4)

AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AC_PROG_RANLIB
AM_PROG_AR

AM_CONDITIONAL([FIZMO_DIST_BUILD], [test "x" = ""])

AC_SUBST([LIBDRILBO_REQS], $libdrilbo_reqs)
AC_SUBST([LIBX11_NONPKG_CFLAGS], $libx11_nonpkg_cflags)
AC_SUBST([LIBX11_NONPKG_LIBS], $libx11_nonpkg_libs)
AC_SUBST([LIBJPEG_NONPKG_CFLAGS], $libjpeg_nonpkg_cflags)
AC_SUBST([LIBJPEG_NONPKG_LIBS], $libjpeg_nonpkg_libs)
AC_SUBST([LIBPNG_NONPKG_CFLAGS], $libpng_nonpkg_cflags)
AC_SUBST([LIBPNG_NONPKG_LIBS], $libpng_nonpkg_libs)

AM_CONDITIONAL([ENABLE_TRACING],
                [test "$enable_tracing" = "yes"])

m4_include(config-conds.m4)

AC_CONFIG_FILES([Makefile src/drilbo/Makefile])
AC_OUTPUT

