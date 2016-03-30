# hello-world-
first try                                                                  
check if the time is synced between storage node and the computer nodes                                                     

check node firmware version
   rinv bladenode firm
check if ib set up correctly
check how many ib ports are ping on the node
check if gpfs is start up on the node
check cuda is installed successfully.
     1.nvidia-smi
     2.simple cuda cases can run

check if ib in computer nodes can ping UFM ib port, (FCA manager).
checking for 64-bit DMA enabled adapters: ( only for power7)

Check the log messages(dmesg), looking for the message "Using 64-bit direct DMA at offset".
If this message appears in the logs, then the adapter is placed in the correct PCIe slot, and the device driver has the feature support, as follows:

dmesg | grep 64-bit
mlx4_core 0004:01:00.0: Using 64-bit direct DMA at offset 10000000000000
mlx4_core 0004:01:00.0: Using 64-bit direct DMA at offset 10000000000000
be2net 0007:01:00.0: Using 64-bit direct DMA at offset 10000000000000

In the case above, both mlx4_core and be2net device drivers are using the 64-bit DMA feature.
Hence, the adapters at PCI slots 0004:01:00.0 and 0007:01:00.0 are taking advantage of the 64-bit DMA feature.
If the adapter does not support 64-bit DMA, the adapter can use only the default 2GB window.
