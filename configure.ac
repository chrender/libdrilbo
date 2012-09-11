
AC_ARG_ENABLE([tracing],
 [AS_HELP_STRING([--enable-tracing],
   [enable tracelog for debugging])],
 [],
 [enable_tracing=no])

#AC_ARG_WITH([dev-build-prefix],
# [AS_HELP_STRING([--with-dev-build-prefix],
#   [Specify directory install development files to])],
# []
# [with_dev_build_prefix=])

m4_include(config-flags.m4)

AC_INIT([libdrilbo], [0.2.3])

libdrilbo_reqs="libfizmo >= 0.7.4"
libdrilbo_nonpkg_cflags=""
libdrilbo_nonpkg_libs=""

PKG_CHECK_MODULES([libfizmo], [libfizmo >= 0.7.4])

m4_include(config-libs.m4)

AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AC_PROG_RANLIB
AM_PROG_AR

#AS_IF([test "x$with_dev_build_prefix" == "x"],
# [with_dev_build_prefix="$DESTDIR$prefix"])
#AC_SUBST([DEV_BUILD_PREFIX], $with_dev_build_prefix)
AC_SUBST([DEV_BUILD_PREFIX], "$DESTDIR$prefix")

AC_SUBST([LIBDRILBO_REQS], $libdrilbo_reqs)
AC_SUBST([LIBDRILBO_NONPKG_CFLAGS], $libdrilbo_nonpkg_cflags)
AC_SUBST([LIBDRILBO_NONPKG_LIBS], $libdrilbo_nonpkg_libs)

AM_CONDITIONAL([ENABLE_TRACING],
                [test "$enable_tracing" = "yes"])

m4_include(config-conds.m4)

AC_CONFIG_FILES([Makefile src/drilbo/Makefile])
AC_OUTPUT

