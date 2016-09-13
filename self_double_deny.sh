#
# deny to run self double
# usage: . /full/path/to/no_self_double.sh
#
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
export scriptname=$0
calc_pid() {
 procname=`
  echo ${scriptname} |
   sed -r s/[^a-z0-9]/_/Ig
 `
 pid="/var/tmp/${procname}.pid"
 echo ${pid}
}
cleanup() {
 rm -f `calc_pid`
}
pid=`calc_pid`
kill -0 `tail -1 ${pid} 2>/dev/null` >/dev/null 2>&1 &&
 echo pid [${pid}] is already running. exiting... >&2 &&
 exit 1
echo $$ >${pid} && trap cleanup HUP INT QUIT ABRT KILL TERM STOP EXIT
