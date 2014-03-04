


   **Version 0.2.6 — March 3, 2014**

 - Adapted to automake v1.14 “subdir-objects” option.
 - Fixed “AC_CONFIG_AUX_DIR” invocation.
 - Added “clean-dev” build target for better cleanup of installed development files, which helps debian packaging.

---


   **Version 0.2.5 — June 5, 2013**

 - Renamed “install-locales” to “install-data” build target.
 - Adapted to new reachar function names in the file system interface.

---


   **Version 0.2.4 — December 27, 2012**

 - Minor fix for libdrilbo build target.

---


   **Version 0.2.3 — September 17, 2012**

 - Adapted to new autoconf/automake build process.

---


   **Version 0.2.2 — March 9, 2012**

 - Fixed missing $(DESTDIR) variable – should already have been present since version 0.2.1.

---


   **Version 0.2.1 — November 6, 2011**

 - Fixed missing “override” statments for CFLAGS in Makefiles.
 - Fixed $(DESTDIR) evaluation in config.[default|macports].mk.
 - Adapted Makefiles and configuration to use standard GNU Makefile variables instead of INSTALL_PATH and FIZMO_BIN_DIR.
 - Removed “drilbo-x11.c” requirement for “Xatom.h”.

---


   **Version 0.2.0 — September 18, 2011**

 - The “drilbo” library – “Drilbo Represents an Imaging Libary not only for Blorb Objects” – is supposed to handle fizmo's graphical related tasks. It makes fizmo's version 0.6 requirement for GTK obsolete, it directly uses libjpg and libpng to load images and provides its own Xlib implementation for X11 output (curentrly only supporting TrueColor).
 - Implemented support for reading jpeg, png and MG1 graphics, the latter one using code from Mark Howell's pix2gif tool from the ztools package.
 - Implemented output of jpeg (RGB, Grayscale and JCS_YCbCr) and ppm files in the P6 variant (usually only useful for debugging, P3 variant available, see code).
 - Implemented output to X11 displays though xlib, truecolor only.
 - Added support for bilinear scaling.
 - Implemented a “z_image” type which holds all the data and metadata for images. A z_image may contain either an RGB or a grayscale file with a depth of 8 bit per pixel.


