dnl Macro that checks for ender and sets several variables
dnl needed for Makefile_ender.mk

dnl ENS_ENDER(case)
dnl Check ender
dnl Defines ENS_BUILD_ENDER
dnl Defines 

AC_DEFUN([ENS_ENDER],
[

# Check where the ender data should be installed
PKG_CHECK_EXISTS([ender], [have_ender="yes"], [have_ender="no"])
if test "x${have_ender}" = "xyes"; then
   ENDER_DATADIR=$($PKG_CONFIG --variable=descriptionsdir ender)
   AC_SUBST([ENDER_DESCRIPTIONS_DIR])
fi

])

dnl End of ens_ender.m4
