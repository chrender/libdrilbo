
AS_IF([test "x$enable_x11" != "xno"], [
  PKG_CHECK_MODULES(
    [libx11],
    [x11],
    [AS_IF([test "x$libdrilbo_reqs" != "x"], [
       libdrilbo_reqs+=", "
     ])
     libdrilbo_reqs+="x11"])
])

AS_IF([test "x$enable_jpeg" != "xno"], [
  PKG_CHECK_MODULES(
    [libjpeg],
    [libjpeg],
    [AS_IF([test "x$libdrilbo_reqs" != "x"], [
       libdrilbo_reqs+=", "
     ])
     libdrilbo_reqs+="libjpeg"],
    [for dir in $with_jpeg_includedir /usr/include /usr/local/include /opt/local/include ; do
       AC_MSG_CHECKING(for jpeglib.h in $dir)
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
       echo "Try setting the location using --with-jpeg-includedir."
       exit
     fi
     libjpeg_nonpkg_cflags+="-I$jpeglib_h_dir"
     libjpeg_CFLAGS="-I$jpeglib_h_dir"

     CFLAGS_SAVED=$CFLAGS
     LIBS_SAVED=$LIBS
     LDFLAGS_SAVED=$LDFLAGS
     LIBS="-ljpeg"
     for dir in $with_jpeg_libdir /usr/lib /usr/local/lib /opt/local/lib ; do
       AC_MSG_CHECKING(for libjpeg in $dir)
       LDFLAGS="-L$dir"
       AC_LINK_IFELSE(
        [AC_LANG_PROGRAM(
         [[#include <stdio.h>
           #include "$jpeglib_h_dir/jpeglib.h"]],
         [[struct jpeg_decompress_struct cinfo;
           jpeg_create_decompress(&cinfo);]])],
         [AC_MSG_RESULT(yes)
          jpeglib_l_dir=$dir
          break],
         [AC_MSG_RESULT(no)])
     done
     if [ test "x$jpeglib_l_dir" == "x"] ; then
       echo "Could not find libjpeg."
       echo "Try setting the location using --with-jpeg-libdir."
       exit
     fi
     LIBS=$LIBS_SAVED
     LDFLAGS=$LDFLAGS_SAVED
     CFLAGS=$CFLAGS_SAVED
     libjpeg_nonpkg_libs="-L$jpeglib_l_dir -ljpeg"
     libjpeg_LIBS="-L$jpeglib_l_dir -ljpeg"
    ])
])

AS_IF([test "x$enable_png" != "xno"], [
  PKG_CHECK_MODULES(
    [libpng],
    [libpng >= 1.2],
    [AS_IF([test "x$libdrilbo_reqs" != "x"], [
       libdrilbo_reqs+=", "
     ])
     libdrilbo_reqs+="libpng >= 1.2"])
])

