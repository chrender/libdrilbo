
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
    [for dir in $with_jpeg_includedir /usr/include /usr/local/include /opt/local/include ; do
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
       echo "Try setting the location using --with-jpeg-libdir."
       exit
     fi
     libdrilbo_nonpkg_cflags+="-I$jpeglib_h_dir"

     LIBS_SAVED=$LIBS
     LDFLAGS_SAVED=$LDFLAGS
     LIBS="-ljpeg"
     for dir in $with_jpeg_libdir /usr/lib /usr/local/lib /opt/local/lib ; do
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
       echo "Try setting the location using --with-jpeg-libdir."
       exit
     fi
     LIBS=$LIBS_SAVED
     LDFLAGS=$LDFLAGS_SAVED
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

