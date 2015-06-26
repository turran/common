dnl Macro for checking for some binary
dnl Usage: ENS_BIN([name, default-path])

AC_DEFUN([ENS_BIN],
[

m4_pushdef([UP], m4_toupper([$1]))
m4_pushdef([DOWN], m4_tolower([$1]))

[]DOWN="$2"

_efl_with_binary=""
_efl_binary_define="no"

AC_ARG_WITH([[]DOWN],
   [AS_HELP_STRING([--with-[]DOWN=PATH], [specify a specific path to ]DOWN[ @<:@default=]$2[@:>@])],
   [
    []DOWN="${withval}"
   ], [])
])

