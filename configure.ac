
AC_ARG_ENABLE([tracing],
 [AS_HELP_STRING([--enable-tracing],
                 [enable tracelog for debugging])],
 [],
 [enable_tracing=no])

AC_ARG_ENABLE([x11],
 [AS_HELP_STRING([--disable-x11],
                 [disable X11 support])],
 [],
 [enable_x11=yes])

AC_ARG_ENABLE([jpeg],
 [AS_HELP_STRING([--disable-jpeg],
                 [disable JPEG support])],
 [],
 [enable_jpeg=yes])

AC_ARG_ENABLE([png],
 [AS_HELP_STRING([--disable-png],
                 [disable PNG support])],
 [],
 [enable_png=yes])


AC_INIT([libdrilbo], [0.2.3])

libdrilbo_reqs="libfizmo >= 0.7.4"
PKG_CHECK_MODULES([libfizmo], [libfizmo >= 0.7.4])
AS_IF([test "x$enable_x11" != "xno"], [
  PKG_CHECK_MODULES([x11], [x11])
  AS_IF([test "x$libdrilbo_reqs" != "x"], [
          libdrilbo_reqs+=", "
  ])
  libdrilbo_reqs+="x11"
])
AS_IF([test "x$enable_jpeg" != "xno"], [
  PKG_CHECK_MODULES([jpeg], [jpeg])
# AS_IF([test "x$libdrilbo_reqs" != "x"], [
#         libdrilbo_reqs+=", "
# ])
# libdrilbo_reqs+="jpeg"
])
AS_IF([test "x$enable_png" != "xno"], [
  PKG_CHECK_MODULES([png], [libpng >= 1.2])
  AS_IF([test "x$libdrilbo_reqs" != "x"], [
          libdrilbo_reqs+=", "
  ])
  libdrilbo_reqs+="libpng >= 1.2"
])

AC_CONFIG_AUX_DIR([.])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AC_PROG_RANLIB
AM_PROG_AR

AM_CONDITIONAL([FIZMO_BUILD_PREFIX_EMPTY], [test "$fizmo_build_prefix" = ""])

AC_SUBST([LIBDRILBO_REQS], $libdrilbo_reqs)

AM_CONDITIONAL([ENABLE_TRACING],
                [test "$enable_tracing" = "yes"])

AM_CONDITIONAL([ENABLE_X11],
                [test "$enable_x11" != "no"])

AM_CONDITIONAL([ENABLE_JPEG],
                [test "$enable_jpeg" != "no"])

AM_CONDITIONAL([ENABLE_PNG],
                [test "$enable_png" != "no"])

AC_CONFIG_FILES([Makefile src/drilbo/Makefile])
AC_OUTPUT

