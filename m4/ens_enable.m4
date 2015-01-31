dnl Usage: ENS_ENABLE_ARG([name, description, default-enabled])

AC_DEFUN([ENS_ENABLE_ARG],
[

want_$1="$3"
AC_ARG_ENABLE([$1],
   [AS_HELP_STRING([m4_if([$3], [no], [--enable-$1],[$3], [yes], [--disable-$1], [unknown])],
   [$2])],
   [
    if test "x$enableval" = "xyes" ; then
       want_$1="yes"
    else
       want_$1="no"
    fi
   ],
   [want_$1="yes"])
])
