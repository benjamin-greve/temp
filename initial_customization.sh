#!/bin/sh

HOSTNAME=$(hostname)
if [ "$HOSTNAME" = ubuntu1804 ]
then
   echo "CUSTOMIZING..."
#change IP
   sudo sshpass -p '#' scp -o StrictHostKeyChecking=no trendmicro@192.168.17.151:/home/trendmicro/productcloud/ubuntu1804/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml
   sudo netplan apply
   sudo sshpass -p '#' ssh trendmicro@192.168.17.151 "rm -rf /home/trendmicro/productcloud/ubuntu1804/50-cloud-init.yaml"
#change hostname


   sudo sshpass -p '#' scp -o StrictHostKeyChecking=no trendmicro@192.168.17.151:/home/trendmicro/productcloud/ubuntu1804/customization_hostname.sh /home/trendmicro/customization_hostname.sh
   sudo sshpass -p '#' ssh trendmicro@192.168.17.151 "rm -rf /home/trendmicro/productcloud/ubuntu1804/customization_hostname.sh"


   sudo sed -i '/preserve_hostname: false/c\preserve_hostname: true' /etc/cloud/cloud.cfg
   . /home/trendmicro/customization_hostname.sh
   sudo hostnamectl set-hostname $dst_hostname
   sudo rm -f /etc/hostname
   sudo echo "$dst_hostname" >> /etc/hostname
   sudo rm -f /home/trendmicro/customization_hostname.sh 

   sudo reboot
   

else 
   echo "NO CUSTOMIZING"
fi
