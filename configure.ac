
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
libdrilbo_nonpkg_cflags=""
libdrilbo_nonpkg_libs=""

PKG_CHECK_MODULES([libfizmo], [libfizmo >= 0.7.4])

AS_IF([test "x$enable_x11" != "xno"], [
  PKG_CHECK_MODULES([x11], [x11])
  AS_IF([test "x$libdrilbo_reqs" != "x"], [
          libdrilbo_reqs+=", "
  ])
  libdrilbo_reqs+="x11"
])

AS_IF([test "x$enable_jpeg" != "xno"], [
  PKG_CHECK_MODULES(
    [jpeg],
    [jpeg],
    [AS_IF([test "x$libdrilbo_reqs" != "x"], [
      libdrilbo_reqs+=", "
     ])
     libdrilbo_reqs+="jpeg" ],
    [for dir in $JPEG_INCLUDE_DIR /usr/include /usr/local/include /opt/local/include ; do
       AC_MSG_CHECKING(for $dir/jpeglib.h)
       if [ test -e $dir/jpeglib.h ]; then
         AC_MSG_RESULT(yes)
         jpeglib_h_dir=$dir
         break
       else
         AC_MSG_RESULT(no)
       fi
     done
     if [ test "x$jpeglib_h_dir" == "x"] ; then
       echo "Could not find libjpeg.h."
       echo "Try setting the location in the JPEG_INCLUDE_DIR variable."
       exit
     fi
     libdrilbo_nonpkg_cflags+="-I$jpeglib_h_dir"

     LIBS_OLD=$LIBS
     LIBS="-ljpeg"
     for dir in $JPEG_LIB_DIR /usr/lib /usr/local/lib /opt/local/lib ; do
       AC_MSG_CHECKING(for libjpeg in $dir)
       LDFLAGS="-L$dir"
       AC_TRY_LINK(
         [#include <stdio.h>
          #include "$jpeglib_h_dir/jpeglib.h"],
         [struct jpeg_decompress_struct cinfo;
          jpeg_create_decompress(&cinfo);],
         [AC_MSG_RESULT(yes)
          jpeglib_l_dir=$dir
          break],
         [AC_MSG_RESULT(no)])
     done
     if [ test "x$jpeglib_l_dir" == "x"] ; then
       echo "Could not find libjpeg."
       echo "Try setting the location in the JPEG_LIB_DIR variable."
       exit
     fi
     LIBS=$LIBS_OLD
     libdrilbo_nonpkg_libs="-L$jpeglib_l_dir -ljpeg"
    ])
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
AC_SUBST([LIBDRILBO_NONPKG_CFLAGS], $libdrilbo_nonpkg_cflags)
AC_SUBST([LIBDRILBO_NONPKG_LIBS], $libdrilbo_nonpkg_libs)

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

