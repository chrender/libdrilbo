
# This is included from fizmo-dist and not required by libfizmo's own
# configuration. It nevertheless needs to be maintained so fizmo-dist
# will still work.
#
# The $build_prefix, $build_prefix_cflags and $build_prefix_libs are
# pre-defined by fizmo-dist.

AC_SUBST([libdrilbo_CFLAGS], "-I$build_prefix_cflags $libx11_CFLAGS $libjpeg_CFLAGS $libjpeg_nonpkg_cflags $libpng_CFLAGS")
AC_SUBST([libdrilbo_LIBS], "-L$build_prefix_libs -ldrilbo -lpthread $libx11_LIBS $libjpeg_LIBS $libjpeg_nonpkg_libs $libpng_LIBS")

