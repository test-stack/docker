#!/bin/sh
KIBANA_EXEC="/opt/kibana/bin/kibana"
LOG_FILE="/var/log/kibana/.log"
PID_FILE="/var/run/kibna.pid"
PID_DIR="$APP_DIR/pid"
LOG_DIR="$APP_DIR/log"

USAGE="Usage: $0 {start|stop|restart|status} [--force]"
FORCE_OP=false

start_it() {
    mkdir -p "$PID_DIR"
    mkdir -p "$LOG_DIR"
    sleep 10
    echo "Starting Kibana..."
    $KIBANA_EXEC 1>"$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    echo "Kibana started with pid $!"
}

pid_file_exists() {
[ -f "$PID_FILE" ]
}
get_pid() {
echo "$(cat "$PID_FILE")"
}
is_running() {
PID=$(get_pid)
! [ -z "$(ps aux | awk '{print $2}' | grep "^$PID$")" ]
}

remove_pid_file() {
echo "Removing pid file"
rm -f "$PID_FILE"
}

start_app() {
if pid_file_exists
then
if is_running
then
PID=$(get_pid)
echo "Kibana already running with pid $PID"
exit 1
else
echo "Kibana stopped, but pid file exists"
if [ $FORCE_OP = true ]
then
echo "Forcing start anyways"
remove_pid_file
start_it
fi
fi
else
start_it
fi
}


stop_process() {
PID=$(get_pid)
echo "Killing process $PID"
kill $PID
}

stop_app() {
if pid_file_exists
then
if is_running
then
echo "Stopping kibana ..."
stop_process
remove_pid_file
echo "Kibana stopped"
else
echo "Kibana already stopped, but pid file exists"
if [ $FORCE_OP = true ]
then
echo "Forcing stop anyways ..."
remove_pid_file
echo "Kibana stopped"
else
exit 1
fi
fi
else
echo "Kibana already stopped, pid file does not exist"
exit 1
fi
}


status_app() {
if pid_file_exists
then
if is_running
then
PID=$(get_pid)
echo "Kibana running with pid $PID"
else
echo "Kibana stopped, but pid file exists"
fi
else
echo "Kibana stopped"
fi
}


case "$2" in
--force)
FORCE_OP=true
;;
"")
;;
*)
echo $USAGE
exit 1
;;
esac
case "$1" in
start)
start_app
;;
stop)
stop_app
;;
restart)
stop_app
start_app
;;
status)
status_app
;;
*)
echo $USAGE
exit 1
;;
esac
