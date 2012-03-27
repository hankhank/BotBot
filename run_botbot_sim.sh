#! /bin/sh
qemu-system-arm -M versatilepb -kernel output/images/zImage -drive file=output/images/rootfs.ext2,if=scsi -drive file=sda2.img,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -serial mon:stdio -net nic,model=smc91c111 -net user -nographic -redir tcp:50080::80 -redir tcp:50022::22 -redir tcp:59091::9091 -usb
