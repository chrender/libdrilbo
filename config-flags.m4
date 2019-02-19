
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

AC_ARG_WITH([jpeg-includedir],
 [AS_HELP_STRING([--with-jpeg-includedir],
         [Specify include directory to use for libjpeg])],
 [AC_SUBST([with_jpeg_includedir],
  [$( echo $(cd $(dirname "$with_jpeg_includedir") && pwd -P)/$(basename "$with_jpeg_includedir") )])],
 [with_jpeg_includedir=])

AC_ARG_WITH([jpeg-libdir],
 [AS_HELP_STRING([--with-jpeg-libdir],
         [Specify library directory for libjpeg])],
 [AC_SUBST([with_jpeg_libdir],
  [$( echo $(cd $(dirname "$with_jpeg_libdir") && pwd -P)/$(basename "$with_jpeg_libdir") )])],
 [with_jpeg_libdir=])

AC_ARG_ENABLE([png],
 [AS_HELP_STRING([--disable-png],
                 [disable PNG support])],
 [],
 [enable_png=yes])

