function alert() {
  cmd=$@

  # Hide 'printAndRun' from being shown in notification
  if [[ $1 == "printAndRun" ]]; then
    cmd_as_array=("${(s/ /)cmd}")
    # Remove first argument
    cmd=$cmd_as_array[2,-1]
  fi

  # Execution
  eval "$@"
  exitstatus="$?"

  # Notification
  if [[ $exitstatus = "0" ]]; then
    notify_success $cmd $exitstatus
  else
    notify_failure $cmd $exitstatus
  fi
  return $exitstatus
}

function notify_success() {
  /usr/bin/notify-send -i "terminal" "Success" "$1"
  /usr/bin/beep -l 100 -f 500 -n -l 50 -f 1000
}

function notify_failure() {
  /usr/bin/notify-send -i "error" "Error: $2" "$1"
  /usr/bin/beep -l 100 -f 10 -r 2
}