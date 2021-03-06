#!/bin/bash
# check ib and gpfs status.

echo "please input gpfs server's ip address:"
read gpfs_server
echo "You entered: $gpfs_server"

#gpfs_server=172.17.0.37
ping $gpfs_server -c 1 -W 1 2>&1 > /dev/null
if [ $? == 0 ]
 then 
   printf "ib network can ping gpfs server.\n"
   ps -ef|grep mmfsd|grep -v grep 2>&1 > /dev/null
   if [ $? == 0 ]
      then
        printf "gpfs has been start up.\n"
      else
      #stop iptables service
        service iptable stop 2>&1 > /dev/null 
        /usr/lpp/mmfs/bin/mmstartup
        if [ $? == 0 ]
          then
            printf "gpfs has been start up.\n"
          else
            ssh 10.10.10.102 /usr/lpp/mmfs/bin/mmlscluster|grep c865bc02fb08|grep -v grep 2>&1 > /dev/null 
            if [ $? == 0 ]
              then 
                /usr/lpp/mmfs/bin/mmsdrrestore -p $gpfs_server
                if [ $? == 0 ]
                   then
                     /usr/lpp/mmfs/bin/mmstartup
                     if [ $? == 0 ]
                       then
                         printf "gpfs has been start up.\n"
                       else 
                         printf "ERROR: gpfs is not started.\n"
                     fi
                   else
                     printf "ERROR:mmsdrrestore failed.\n"
                fi
               else
                 printf "ERROR: the node is not in the gpfs cluster, use mmaddnode to add it,then run this script again.\n"
             fi
        fi
   fi  
 else 
   printf "ERROR: ib network has problem!\n"
   #printf "Check /etc/sysconfig/network-scripts/ifcfg*ib* config files!\n"
 fi
 
