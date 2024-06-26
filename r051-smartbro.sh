#!/bin/sh
wget http://raw.github.com/freekonek/freekonek.github.io/main/r051-smartbro-8bands.bin -O /tmp/a.bin > /dev/null 2>&1
firmware2=$(cat /proc/mtd | grep firmware2 | awk '{print $1}')
echo "Checking hash!"
hash=$(md5sum /tmp/a.bin | awk '{print $1}')
echo "$hash = 11fb740b00504cac987a4cdb1de1c27f"
if [ $hash == '11fb740b00504cac987a4cdb1de1c27f' ]
then
echo "Same!"
echo "Installing Bands 1 3 5  8 28 38 40  and 41..."
echo "Installing Band and PCI locking features..."
echo "Installing Change IMEI and Openline features..."
echo "Firmware upgrading on process..."
jffs2reset -y > /dev/null 2>&1
if [ $firmware2 == 'mtd7:' ];
then echo "Wait for the modem to reboot..."
mtd -r write /tmp/a.bin /dev/mtd4
exit
fi
echo "Wait for the modem to reboot..."
mtd -r write /tmp/a.bin /dev/mtd5
exit
else
echo "Not same!" 
fi
