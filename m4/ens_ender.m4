dnl Macro that checks for ender and sets several variables
dnl needed for Makefile_ender.mk

dnl ENS_ENDER(case)
dnl Check ender
dnl Defines ENS_BUILD_ENDER
dnl Defines 

AC_DEFUN([ENS_CHECK_ENDER],
[

dnl
dnl Check for the ender dirs
dnl

# Check where the ender data should be installed
PKG_CHECK_EXISTS([ender], [have_ender="yes"], [have_ender="no"])
if test "x${have_ender}" = "xyes"; then
   ENDER_DESCRIPTIONS_DIR=$($PKG_CONFIG --variable=descriptionsdir ender)
   ENDER_TOOLS_DIR=$($PKG_CONFIG --variable=pkgdatadir ender)/tools
   AC_SUBST([ENDER_DESCRIPTIONS_DIR])
   AC_SUBST([ENDER_TOOLS_DIR])
fi

dnl
dnl TODO Check for xsltproc and xmllint
dnl

dnl
dnl Set the automake conditionals, we need the doxygen
dnl to be enabled too
dnl

if test "x${ens_enable_doc}" = "xyes" -a "x${have_ender}" = "xyes"; then
  ens_enable_ender="yes"
else
  ens_enable_ender="no"
fi

AM_CONDITIONAL([ENS_BUILD_ENDER], [test "x${ens_enable_ender}" = "xyes"])

AS_IF([test "x${ens_enable_ender}" = "xyes"], [$1], [$2])

])

dnl End of ens_ender.m4
