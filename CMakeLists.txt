
#[[

  CMakeLists.txt

  This file is part of fizmo.

  ---

  Copyright (c) 2010-2023 Christoph Ender.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:
  1. Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
  2. Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimer in the
  documentation and/or other materials provided with the distribution.
  3. Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived
  from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

  ---



  This is libmonospaceif's main buildfile. […]

]]


cmake_minimum_required(VERSION 3.10)

include(ExternalProject)
include(FindPkgConfig)

project(libdrilbo
  LANGUAGES C
  HOMEPAGE_URL https://fizmo.spellbreaker.org
  DESCRIPTION "Drilbo Represents an Imaging Libary not only for Blorb Objects"
  VERSION 0.9.0)

ExternalProject_Add(locale_data_preparation
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/src/locales
  BINARY_DIR ${CMAKE_BINARY_DIR}/loacles_build
  CMAKE_ARGS
  ${GLOBAL_DEFAULT_ARGS}
  ${GLOBAL_THIRDPARTY_LIB_ARGS}
  BUILD_COMMAND make
  INSTALL_COMMAND cmake -E echo "Skipping install step."
  )

find_package(PkgConfig REQUIRED)
find_package(X11 REQUIRED)
pkg_check_modules(LIBFIZMO REQUIRED libfizmo>=0.8.0)
pkg_check_modules(LIBJPEG REQUIRED libjpeg)
pkg_check_modules(LIBPNG REQUIRED libpng)

include_directories(${LIBFIZMO_INCLUDE_DIRS})
link_directories(${LIBFIZMO_LIBDIR})

option(ENABLE_TRACING "Enable tracing" OFF)
if (ENABLE_TRACING)
  add_definitions(-DENABLE_TRACING)
endif()

option(ENABLE_DEBUGGER "Enable debugger" OFF)
if (ENABLE_DEBUGGER)
  add_definitions(-DENABLE_DEBUGGER)
endif()

option(FIZMO_DIST_VERSION "Set fizmo-dist version" OFF)
if (FIZMO_DIST_VERSION)
  add_definitions(-DFIZMO_DIST_VERSION=${FIZMO_DIST_VERSION})
endif()

set (MyCSources
  src/drilbo/drilbo-jpeg.c
  src/drilbo/drilbo-mg1.c
  src/drilbo/drilbo-png.c
  src/drilbo/drilbo-ppm.c
  src/drilbo/drilbo-x11.c
  src/drilbo/drilbo.c
  src/locales/libdrilbo_locales.c
  src/locales/locale_data.c
  src/locales/locale_data.h)

include_directories(${LIBJPEG_INCLUDE_DIRS} ${LIBPNG_INCLUDE_DIRS} ${X11_INCLUDE_DIR})
add_library(drilbo ${MyCSources})
#target_link_directories(${PROJECT_NAME} PUBLIC ${LIBJPEG_LIBDIR} ${LIBPNG_LIBDIR})


#install(TARGETS libmonospaceif)
# PUBLIC_HEADER cannot be used for TARGETS fizmo, since it doesn't keep
# the directory tree and installs all *.h flat into "include/". So:

install(DIRECTORY "${PROJECT_SOURCE_DIR}/src/" # source directory
  DESTINATION "include" # target directory
  FILES_MATCHING # install only matched files
  PATTERN "*.h" # select header files
)

install(TARGETS drilbo)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.pc
  DESTINATION "lib/pkgconfig")

set(pc_libs_private)
set(pc_req_private)
configure_file(src/libdrilbo.pc.in libdrilbo.pc @ONLY)

