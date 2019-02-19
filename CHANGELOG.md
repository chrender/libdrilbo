


   **Version 0.2.12 — Febuary 19, 2019**

 - Fixed potential compile errors due to relative paths in autoconf parameters.
 - Replaced obsolete AC\_TRY\_LINK with AC\_LINK\_IFELSE.
 - Fixed underscores in markdown files.
 - Updated tiny-xml-doc-tools.

---


   **Version 0.2.11 — September 3, 2017**

 - Fix superfluous libraries and includes during install when using $DESTDIR, addressing github issue #21.
 - Added missing contributor phrasing to BSD-3 clause. The resulting license now exactly matches the wording used on Github and so also makes the license detection work.

---


   **Version 0.2.10 — April 8, 2017**

 - Fixed drilbo to correctly ignore drilbo-x11.c when configured with “--disable-x11”.
 - Adapted to replacement of en\_US locale with en\_GB from libfizmo.

---


   **Version 0.2.9 — October 8, 2016**

 - Improved build system for separate library and interface builds.

---


   **Version 0.2.8 — August 31, 2015**

 - Use tiny-xml-doc-tools for documentation.

---


   **Version 0.2.7 — October 9, 2015**

 - Minor changes to autoconf for better comtability to fizmo-dist-0.7.10.

---


   **Version 0.2.6 — March 19, 2014**

 - Adapted to automake v1.14 “subdir-objects” option.
 - Fixed “AC\_CONFIG\_AUX\_DIR” invocation.
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
 - Adapted Makefiles and configuration to use standard GNU Makefile variables instead of INSTALL\_PATH and FIZMO\_BIN\_DIR.
 - Removed “drilbo-x11.c” requirement for “Xatom.h”.

---


   **Version 0.2.0 — September 18, 2011**

 - The “drilbo” library – “Drilbo Represents an Imaging Libary not only for Blorb Objects” – is supposed to handle fizmo's graphical related tasks. It makes fizmo's version 0.6 requirement for GTK obsolete, it directly uses libjpg and libpng to load images and provides its own Xlib implementation for X11 output (curentrly only supporting TrueColor).
 - Implemented support for reading jpeg, png and MG1 graphics, the latter one using code from Mark Howell's pix2gif tool from the ztools package.
 - Implemented output of jpeg (RGB, Grayscale and JCS\_YCbCr) and ppm files in the P6 variant (usually only useful for debugging, P3 variant available, see code).
 - Implemented output to X11 displays though xlib, truecolor only.
 - Added support for bilinear scaling.
 - Implemented a “z\_image” type which holds all the data and metadata for images. A z\_image may contain either an RGB or a grayscale file with a depth of 8 bit per pixel.


