#! /bin/sh
qemu-system-arm -M versatilepb -kernel output/images/zImage -drive file=output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -serial mon:stdio -net nic,model=smc91c111 -net user -nographic
