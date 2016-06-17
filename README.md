# qemu-lite-tools
scripts and configurations for qemu-lite

## Usage

1. Get guest image:
    * Download from https://download.clearlinux.org/releases/8800/clear/clear-8800-kvm.img.xz
    * Align image size to multiple of 0x200000:

        dd if=/dev/zero of=clear-8800-kvm.img oflag=append conv=notrunc bs=4096 count=256

      Explanation:
        dd if=/dev/zero of=$DISK_IMG oflag=append conv=notrunc bs=4096 count=$APPEND_BLOCKS
        where APPEND_BLOCKS = (round_up(current_disk_image_size_in_bytes, 0x200000)
                              - current_disk_image_size_in_bytes) / 4096

      This is needed to use nvdimm as the disk backend.

2. configure QEMU with qemu-config.sh, make && make install

3. configure/build Linux with linux-config-4.5.0

4. ./qemu-run.sh
