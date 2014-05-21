#!/system/bin/sh
#This version for A80 only
#[Setup log & env]
log_head='ASDF'
action_log='/dev/console'		#set /dev/null to turn off log
log_root='/data/media/asus_log/ASDF'	#Abnormal Shutdown Data Files
trigger_log="$log_root/Total_Recall.txt"
trigger_old="$log_root.old/Total_Recall.txt"
log_dir="$log_root/ASDF"
log_old="$log_root.old/ASDF"
max_log=20

android_boot=`getprop sys.boot_completed`

android_reboot_prop='debug.asus.android_reboot'
android_reboot=`getprop $android_reboot_prop`

act_prop='persist.radio.check_asdf'
act_code=`getprop $act_prop`
chk_result="/dev/asdf_result.html"
#	[1	]	[2 abc	]	[3 def	]
#	[4 ghi	]	[5 jkl	]	[6 mno	]
#	[7 pqrs	]	[8 tuv	]	[9 wxyz	]
#	[* +	]	[0 ﹇	]	[# ⇧	]
# asdf => 2733

if [ ".$android_reboot" == "." ]; then
	if [ -e $log_root ]; then
		echo "$log_head: found log_root=$log_root" > $action_log
	else
		echo "$log_head: creating log_root=$log_root" > $action_log
		mkdir $log_root
	fi
fi

if [ ".$act_code" == ".2733" ]; then
	setprop $act_prop ''	#reset property
	echo "$log_head: print ASDF result...." > $action_log
	echo "<html><body><pre>" > $chk_result
	if [ -e $trigger_log ]; then
		cat $trigger_log >> $chk_result
	else
		echo "no result!!" >> $chk_result
	fi
	echo "</pre></body></html>" >> $chk_result
	chmod 644 $chk_result
	input keyevent 82
	am force-stop com.android.htmlviewer
	am start -n com.android.htmlviewer/com.android.htmlviewer.HTMLViewerActivity -d file://$chk_result
elif [ ".$android_boot" == ".1" ]; then
	if [ ".$android_reboot" == "." ]; then
		setprop $android_reboot_prop 0
		echo "$log_head: 1st boot_completed...." > $action_log
		#Check if there is an abnormal shutdown occured
		fcount=0
		for fname in /data/log/ASUSSlowg* /data/log/LastShutdown* /data/log/rtb* /data/log/rpm*
		do
			if [ -e $fname ]; then
				fcount=$(($fcount+1))
			fi
		done
		echo "==========>ASDF count: $fcount" > $action_log

		if [ $fcount -gt 0 ]; then
			echo "$log_head: <$(date +%F_%T)>Abnormal shutdown logs found!" > $action_log

			#ASDF rotation
			if [ -e $log_dir.1 ]; then
				echo "$log_head: Start rotating log_dir!" > $action_log
				mv $log_root $log_root.old
				mkdir $log_root
				mv $trigger_old $trigger_log
				i=$(($max_log-1))
				while [ $i -gt 0 ]; do
					if [ -e $log_old.$i ]; then
						echo "$log_head: rotate log_dir.$i to log_dir.$(($i+1))" > $action_log
						mv $log_old.$i $log_dir.$(($i+1))
					fi
					i=$(($i-1))
				done
				rm -r $log_root.old

			fi

			#create new ASDF
			echo "$log_head: Creating new log_dir" > $action_log
			mkdir $log_dir.1

			#backup ASDF
			echo "$log_head: Backup log files...." > $action_log

			fcount=0
			cd /data/log
			for fname in ASUSSlowg* LastShutdown* rtb* rpm*
			do
				if [ -e $fname ]; then
					echo "$log_head: $PWD/$fname found!" > $action_log
					cat $fname > $log_dir.1/$fname
					rm $fname
					fcount=$(($fcount+1))
				fi
			done

			cd /data/anr
			for fname in traces*
			do
				if [ -e $fname ]; then
					echo "$log_head: $PWD/$fname found!" > $action_log
					cat $fname > $log_dir.1/$fname
					rm $fname
					fcount=$(($fcount+1))
				fi
			done


			for fname in /data/media/asus_log/ASUSEvtlog*
			do
				if [ -e $fname ]; then
					echo "$log_head: $fname found!" > $action_log
					mv $fname $log_dir.1
					fcount=$(($fcount+1))
				fi
			done
			echo "$log_head: <$(date +%F_%T)>Job done!" > $action_log

			echo "$(date +%F_%T)> backup $fcount log(s)" >> $trigger_log

		fi
	else
		android_reboot=$(($android_reboot+1))
		setprop $android_reboot_prop $android_reboot
		echo "$log_head: Android restart....($android_reboot)" > $action_log
		echo "$(date +%F_%T)> Android restart!($android_reboot)" >> $trigger_log
	fi
fi



