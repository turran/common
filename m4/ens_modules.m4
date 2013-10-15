

dnl use: ENS_CHECK_DEP_JPG(want_static[, ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])

AC_DEFUN([ENS_CHECK_DEP_JPG],
[

JPG_LIBS=""
JPG_CFLAGS=""

LIBS_save="${LIBS}"
LIBS="${LIBS} -ljpeg"
AC_LINK_IFELSE(
   [AC_LANG_PROGRAM(
       [[
#include <stdio.h>
#include <stdlib.h>
#include <jpeglib.h>
       ]],
       [[
struct jpeg_decompress_struct cinfo;

jpeg_create_decompress(&cinfo);
       ]])],
   [
    have_dep="yes"
    requirements_libs="-ljpeg"
    JPG_LIBS="-ljpeg"
    JPG_CFLAGS=""
   ],
   [have_dep="no"])
LIBS="${LIBS_save}"

AC_ARG_VAR([JPG_CFLAGS], [preprocessor flags for images backend])
AC_SUBST([JPG_CFLAGS])
AC_ARG_VAR([JPG_LIBS], [linker flags for images backend])
AC_SUBST([JPG_LIBS])

if test "x$1" = "xstatic" ; then
   requirements_enesim_libs="${requirements_libs} ${requirements_enesim_libs}"
fi

AS_IF([test "x$have_dep" = "xyes"], [$2], [$3])

])

dnl use: ENS_CHECK_DEP_PNG(want_static[, ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])

AC_DEFUN([ENS_CHECK_DEP_PNG],
[

requirement_pc=""

PKG_CHECK_EXISTS([libpng >= 0.22],
   [
    have_dep="yes"
    requirements_pc="libpng >= 0.22"
   ],
   [have_dep="no"])

if ! test "x${requirements_pc}" = "x" ; then
   PKG_CHECK_MODULES([PNG],
      [${requirements_pc}],
      [],
      [])
fi

if test "x$1" = "xstatic" ; then
   requirements_enesim_pc="${requirements_pc} ${requirements_enesim_pc}"
fi

AS_IF([test "x$have_dep" = "xyes"], [$2], [$3])

])

dnl use: ENS_CHECK_DEP_RAW(want_static[, ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])

AC_DEFUN([ENS_CHECK_DEP_RAW],
[

have_dep="yes"

AS_IF([test "x$have_dep" = "xyes"], [$2], [$3])

])


dnl use: ENS_MODULE(module, want_module)

AC_DEFUN([ENS_MODULE],
[

m4_pushdef([UP], m4_toupper([$1]))
m4_pushdef([DOWN], m4_tolower([$1]))

want_module="$2"
build_module="yes"
build_module_[]DOWN="no"
build_static_module_[]DOWN="no"

AC_ARG_ENABLE([module-[]DOWN],
   [AS_HELP_STRING([--enable-module-[]DOWN]@<:@=ARG@:>@, [enable $1 module: yes, no, static [default=$2]])],
   [
    if test "x${enableval}" = "xyes" ; then
       want_module="yes"
    else
       if test "x${enableval}" = "xstatic" ; then
          want_module="static"
       else
          want_module="no"
       fi
    fi
   ])

AC_MSG_CHECKING([whether to enable $1 module])
AC_MSG_RESULT([${want_module}])

if test "x${want_module}" = "xyes" || test "x${want_module}" = "xstatic" ; then
   m4_default([ENS_CHECK_DEP_]m4_defn([UP]))(${want_module}, [have_module="yes"], [have_module="no"])
fi

if test "x${want_module}" = "xno" || test "x${have_module}" = "xno" ; then
   build_module="no"
fi

AC_MSG_CHECKING([whether $1 module will be built])
AC_MSG_RESULT([${build_module}])

if test "x${build_module}" = "xyes" ; then
   if test "x${want_module}" = "xstatic" ; then
      build_module_[]DOWN="static"
      build_static_module_[]DOWN="yes"
   else
      build_module_[]DOWN="yes"
   fi
fi

if test "x${build_module_[]DOWN}" = "xyes" ; then
   AC_DEFINE(BUILD_MODULE_[]UP, [1], [UP Module Support])
fi

AM_CONDITIONAL(BUILD_MODULE_[]UP, [test "x${build_module_[]DOWN}" = "xyes"])

if test "x${build_static_module_[]DOWN}" = "xyes" ; then
   AC_DEFINE(BUILD_STATIC_MODULE_[]UP, [1], [Build $1 module inside the library])
fi

AM_CONDITIONAL(BUILD_STATIC_MODULE_[]UP, [test "x${build_static_module_[]DOWN}" = "xyes"])

m4_popdef([UP])
m4_popdef([DOWN])

])

dnl End of ens_modules.m4
