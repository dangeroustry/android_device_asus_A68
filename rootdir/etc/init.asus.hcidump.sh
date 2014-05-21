#!/system/bin/sh
LOG_TAG="save-hcidump"
LOG_NAME="${0}:"

hcidump_pid=""

loge ()
{
  /system/bin/log -t $LOG_TAG -p e "$LOG_NAME $@"
}

logi ()
{
  /system/bin/log -t $LOG_TAG -p i "$LOG_NAME $@"
}

failed ()
{
  loge "$1: exit code $2"
  exit $2
}

start_hcidump ()
{
      is_logcat_log_dir_exist=`ls /data/logcat_log/`
      if busybox test "$is_logcat_log_dir_exist"; then
          logi "sdcard logcat_log dir already exist"
      else
          logi "create data logcat_log dir"
          mkdir /data/logcat_log/
      fi

      #move hcidump.bin.1 to hcidump.bin.2, hcidump.bin to hcidump.bin.1
      is_hcidump1_exist=`ls /data/logcat_log/hcidump.bin.1`
      if busybox test "$is_hcidump1_exist"; then
          logi "hcidump1 exists - copy to hcidump2"
          cp /data/locat_log/hcidump.bin.1 /data/logcat_log/hcidump.bin.2
      fi

      is_hcidump_exist=`ls /data/logcat_log/hcidump.bin`
      if busybox test "$is_hcidump_exist"; then
          logi "hcidump exists - copy to hcidump1"
          cp /data/logcat_log/hcidump.bin /data/logcat_log/hcidump.bin.1
          rm /data/logcat_log/hcidump.bin
      fi

      /system/xbin/hcidump -Xtw /data/logcat_log/hcidump.bin &
      hcidump_pid=$!
      logi "start_hcidump: pid = $hcidump_pid"
}

kill_hcidump ()
{
  logi "kill_hcidump: pid = $hcidump_pid"
  ## careful not to kill zero or null!
  kill -TERM $hcidump_pid
  # this shell doesn't exit now -- wait returns for normal exit
}

# init does SIGTERM on ctl.stop for service
trap "kill_hcidump" TERM INT

#fix BLUETOOTH_ENABLE to 1
BLUETOOTH_ENABLE="1"

case $BLUETOOTH_ENABLE in
    1)
        logi "try to start hcidump"
        start_hcidump

        wait $hcidump_pid
        logi "hcidump stopped"
     ;;
     *)
        logi "bluetooth not enabled"
        failed "bluetooth not enabled" -1
     ;;
esac

exit 0
