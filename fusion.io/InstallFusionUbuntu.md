Basic Setup of fusion.io Card.
This might be relevant in setup together with GPU or other low latency high workload devices. Eg for training neural networks or advanced out of memory analytics.

##Setup

1. Go to https://link.sandisk.com/commercialsupport.html and download the drivers and utils etc. Bascically the following scripts are an summary of the description in the manual. I recommend reading the manual

2. Install the drivers:


    sudo apt-get install gcc fakeroot build-essential debhelper linux-headers-$(uname -r) rsync
    cd Software_Source
    tar xzvf iomemory-vsl<version>-1.0.tar.gz
    cd iomemory-vsl<version>-1.0/
    dpkg-buildpackage
    cd ../../Utilities
    sudo dpkg -i *.deb # install the required packages
    cd ..
    sudo dpkg -i *.deb # not the source one
    # install the driver
    sudo modprobe -r iomemory-vsl4
    sudo modprobe iomemory-vsl4
    sudo fio-status # everything right? double check in case with dmesg or syslog

3. Format the Device
Note: You may also consider using raid options or creating partitions ... Here we simply setup an ext4 fs
    sudo mkfs.ext4 /dev/fioa # format the dev with ext4
4. Mount the device
4.1 check if you need to add fio to fstab or read manual for driver auto attach options

#uninstall:
read the manual its recommended to uninstall all the drivers before updating....
