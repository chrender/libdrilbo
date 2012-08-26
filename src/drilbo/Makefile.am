
AM_CFLAGS = $(libfizmo_CFLAGS) $(x11_CFLAGS) $(png_CFLAGS) $(jpeg_CFLAGS)
AM_CPPFLAGS =
LDADD = $(libfizmo_LIBS) $(x11_LIBS) $(png_LIBS) $(jpeg_LIBS)

localedir = $(datarootdir)/fizmo/locales

noinst_LIBRARIES = libdrilbo.a
libdrilbo_a_SOURCES = ../locales/libdrilbo_locales.c drilbo.c \
 drilbo-mg1.c drilbo-ppm.o

if ENABLE_TRACING
AM_CFLAGS += -DENABLE_TRACING=
endif

if ENABLE_JPEG
AM_CFLAGS += -DDRILBO_ENABLE_JPG=
libdrilbo_a_SOURCES += drilbo-jpeg.c
endif

if ENABLE_PNG
AM_CFLAGS += -DDRILBO_ENABLE_PNG=
libdrilbo_a_SOURCES += drilbo-png.c
endif

if ENABLE_X11
AM_CFLAGS += -DDRILBO_ENABLE_X11=
libdrilbo_a_SOURCES += drilbo-x11.c
endif

