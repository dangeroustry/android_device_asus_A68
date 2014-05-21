#!/system/bin/sh
# created by ray2_lin@asus.com

FILES=""
FOLDERS="/data/media/asus_log/ASDF"

# logcat & radio
cd /data/logcat_log
for x in logcat logcat-radio logcat-events
do
	stop $x
	mv $x.txt $x.txt.0
	start $x
	FILES+="/data/logcat_log/$x.txt.* "
done

# event log
cd /data/media/asus_log
mv ASUSEvtlog.txt ASUSEvtlog_now.txt

# slow & anr log & modem log
#TIME=`date +%Y-%m-%d-%H-%M`
for x in `ls /data/media/asus_log/ASUSEvtlog_*.txt /data/log/*.txt /data/anr/*.txt /data/log/RAMDump?/reason.log`; do
	FILES+="$x "
done

# decide the log file name
PRODUCT=`getprop ro.build.product`
VERSION=`getprop ro.build.version.incremental | busybox awk -F "-" '{ print $2}'` 
SKU=`getprop ro.product.name | busybox awk -F "_" '{ print $1}'`
IMEI=`dumpsys iphonesubinfo | busybox grep "Device ID" | busybox awk '{ print $4 }'`
TIME=`date +%y%m%d%H%M%S`
REASON=0
if [ $1 ]; then
	REASON=$1
fi
OUTFILE=$PRODUCT-$VERSION-$SKU-$IMEI-$TIME-$REASON

# add meta info file & screenshots
cd /data/media/ASUS/LogUploader
for x in `ls info.txt screenshot.*`; do
	FILES+="$x "
done

# dumpsys
mkdir -p dumpsys
for x in alarm power battery; do
	dumpsys $x > dumpsys/$x.txt
	FILES+="dumpsys/$x.txt "
done

# show some info
echo "Packing the following files to $OUTFILE.tar.gz ..."
echo "$FILES"
# start packing logs and delete backuped files
busybox tar cfz $OUTFILE.tar.gz $FILES $FOLDERS /data/data/com.asus.loguploader/log.txt

chown system.system $OUTFILE.tar.gz
chmod 666 $OUTFILE.tar.gz

rm $FILES
rm -r $FOLDERS

am broadcast -a "com.asus.packlogs.completed"
 
echo "Done"
 
