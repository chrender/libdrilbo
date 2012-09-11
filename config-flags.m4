
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

