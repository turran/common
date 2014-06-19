dnl ENS_CHECK_NEKO([ACTION-IF-FOUND], [ACTION-IF-NOT])
AC_DEFUN([ENS_CHECK_NEKO],
[
NEKO_LIBS=
AC_CHECK_LIB(neko, neko_val_callEx,
             [AC_CHECK_HEADERS(neko.h neko_vm.h, have_neko="yes", have_neko="no") ],
             [have_neko="no"])
AC_CHECK_PROG(have_neko_bin, nekoc, yes, no)
if test "x$have_neko" = "xyes" && test "x$have_neko_bin" = "xyes"; then
        NEKO_LIBS=-lneko
        m4_ifvaln([$1],[$1])dnl
else
	AC_MSG_RESULT("Neko not found")
        m4_ifvaln([$2],[$2])dnl
fi
AC_SUBST(NEKO_LIBS)
])
