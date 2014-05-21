#!/system/bin/sh
# Copyright (c) 2011-2012, Code Aurora Forum. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of Code Aurora Forum, Inc. nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

# Check for images and set up symlinks
cd /firmware/image

# Get the list of files in /firmware/image
# for which sym links have to be created

fwfiles=`ls modem* q6* wcnss* dsps* tzapps* gss*`
modem_fwfiles=`ls modem_fw.mdt`

# Check if the links with similar names
# have been created in /system/etc/firmware

cd /system/etc/firmware
linksNeeded=0
fixModemFirmware=0

# For everyfile in fwfiles check if
# the corresponding file exists
for fwfile in $fwfiles; do

   # if (condition) does not seem to work
   # with the android shell. Therefore
   # make do with case statements instead.
   # if a file named $fwfile is present
   # no need to create links. If the file
   # with the name $fwfile is not present
   # need to create links.

   case `ls $fwfile` in
      $fwfile)
         continue;;
      *)
         # file with $fwfile does not exist
         # need to create links
         linksNeeded=1
         break;;
   esac

done

case `ls $modem_fwfiles` in
   $modem_fwfiles)
      break;;
   *)
      # file with $fwfile does not exist
      # need to rename the right set of firmware based on chip version
      fixModemFirmware=1
      break;;
esac

case $linksNeeded in
   1)
      cd /firmware/image

      # Check if need to select modem firmware and do rename in first boot
      case $fixModemFirmware in
      1)
        # Check chip version
        case `cat /sys/devices/system/soc/soc0/version 2>/dev/null` in
          "1.0" | "1.1")
            for file in modem_f1.* ; do
              newname=modem_fw.${file##*.}
              ln -s /firmware/image/$file /system/etc/firmware/$newname 2>/dev/null
            done
            break;;

          *)
            for file in modem_f2.* ; do
              newname=modem_fw.${file##*.}
              ln -s /firmware/image/$file /system/etc/firmware/$newname 2>/dev/null
            done
         esac;;

      *)
        # Nothing to do.
        break;;
      esac

      case `ls modem.mdt 2>/dev/null` in
         modem.mdt)
            for imgfile in modem*; do
               ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
            done
            break;;
        *)
            # trying to log here but nothing will be logged since it is
            # early in the boot process. Is there a way to log this message?
            log -p w -t PIL 8960 device but no modem image found;;
      esac

#Bruno++
      #case `ls q6.mdt 2>/dev/null` in
      #   q6.mdt)
      #      for imgfile in q6*; do
      #         ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
      #      done
      #      break;;
      #   *)
      #      log -p w -t PIL 8960 device but no q6 image found;;
      #esac
#Bruno++

      #case `ls wcnss.mdt 2>/dev/null` in
      #   wcnss.mdt)
      #      for imgfile in wcnss*; do
      #         ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
      #      done
      #      break;;
      #   *)
      #      log -p w -t PIL 8960 device but no wcnss image found;;
      #esac

      case `ls dsps.mdt 2>/dev/null` in
         dsps.mdt)
            for imgfile in dsps*; do
               ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
            done
            break;;
         *)
            log -p w -t PIL 8960 device but no dsps image found;;
      esac

      #case `ls tzapps.mdt 2>/dev/null` in
      #   tzapps.mdt)
      #      for imgfile in tzapps*; do
      #         ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
      #      done
      #      break;;
      #   *)
      #      log -p w -t PIL 8960 device but no tzapps image found;;
      #esac

      case `ls gss.mdt 2>/dev/null` in
         gss.mdt)
            for imgfile in gss*; do
               ln -s /firmware/image/$imgfile /system/etc/firmware/$imgfile 2>/dev/null
            done
            break;;
         *)
            log -p w -t No gss image found;;
      esac

      break;;

   *)
      # Nothing to do. No links needed
      break;;
esac

#Lenter+++
tzapps_0=`cat /sys/module/qseecom/parameters/tzapps_0`
tzapps_1=`cat /sys/module/qseecom/parameters/tzapps_1`
tzapps_2=`cat /sys/module/qseecom/parameters/tzapps_2`
tzapps_3=`cat /sys/module/qseecom/parameters/tzapps_3`
tzapps_m=`cat /sys/module/qseecom/parameters/tzapps_m`
ln -s /system/etc/firmware/tzapps/$tzapps_0 /system/etc/firmware/tzapps.b00
ln -s /system/etc/firmware/tzapps/$tzapps_1 /system/etc/firmware/tzapps.b01
ln -s /system/etc/firmware/tzapps/$tzapps_2 /system/etc/firmware/tzapps.b02
ln -s /system/etc/firmware/tzapps/$tzapps_3 /system/etc/firmware/tzapps.b03
ln -s /system/etc/firmware/tzapps/$tzapps_m /system/etc/firmware/tzapps.mdt
vidc_0=`cat /sys/module/vidc/parameters/vidc_0`
vidc_1=`cat /sys/module/vidc/parameters/vidc_1`
vidc_2=`cat /sys/module/vidc/parameters/vidc_2`
vidc_3=`cat /sys/module/vidc/parameters/vidc_3`
vidc_m=`cat /sys/module/vidc/parameters/vidc_m`
ln -s /system/etc/firmware/vidc/$vidc_0 /system/etc/firmware/vidc.b00
ln -s /system/etc/firmware/vidc/$vidc_1 /system/etc/firmware/vidc.b01
ln -s /system/etc/firmware/vidc/$vidc_2 /system/etc/firmware/vidc.b02
ln -s /system/etc/firmware/vidc/$vidc_3 /system/etc/firmware/vidc.b03
ln -s /system/etc/firmware/vidc/$vidc_m /system/etc/firmware/vidc.mdt
#Lenter---

#Bruno++
if [ "/system/etc/firmware/q6.b00" -ef "/firmware/image/q6.b00" ]; then
    rm /system/etc/firmware/q6.*
fi
q6_0=`cat /sys/module/pil_q6v4/parameters/q6_0`
q6_1=`cat /sys/module/pil_q6v4/parameters/q6_1`
q6_3=`cat /sys/module/pil_q6v4/parameters/q6_3`
q6_4=`cat /sys/module/pil_q6v4/parameters/q6_4`
q6_5=`cat /sys/module/pil_q6v4/parameters/q6_5`
q6_6=`cat /sys/module/pil_q6v4/parameters/q6_6`
q6_m=`cat /sys/module/pil_q6v4/parameters/q6_m`
ln -s /system/etc/firmware/aDSP/$q6_0 /system/etc/firmware/q6.b00
ln -s /system/etc/firmware/aDSP/$q6_1 /system/etc/firmware/q6.b01
ln -s /system/etc/firmware/aDSP/$q6_3 /system/etc/firmware/q6.b03
ln -s /system/etc/firmware/aDSP/$q6_4 /system/etc/firmware/q6.b04
ln -s /system/etc/firmware/aDSP/$q6_5 /system/etc/firmware/q6.b05
ln -s /system/etc/firmware/aDSP/$q6_6 /system/etc/firmware/q6.b06
ln -s /system/etc/firmware/aDSP/$q6_m /system/etc/firmware/q6.mdt
#Bruno++

cd /

