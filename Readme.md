## This is a tiny experimental Boot loader which loads C kernel int 64 bit

### Quick links
* [References](#References)
* [Requirements](#Requirements)
* [Running the Kernel](#Running-the-Kernel)
* [How does it boot](#How-does-it-boot-?)


### References

The following guides were used in the development of this bootloader. 

* Os-dev book: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
    * The above book was used to reach till booting into 32 bit protected mode.
* https://os.phil-opp.com/entering-longmode/
    * This was later used to switch to 64 bit mode with paging enabled
* https://pdos.csail.mit.edu/6.828/2005/readings/i386/s05_01.htm
    * This link was also very useful in understanding how segmentation works in 32 bit protected mode. (Although, 64 bit uses paging and is mainstrean, this was still interesting)


### Requirements

#### Install nasm - x86 Assembly code compiler
```
sudo apt update
sudo apt install nasm
```

#### Install qemu - x86 CPU emulator
```
sudo apt-get install qemu
```
### Running the kernel
```
make
make run
# deleting built files
make clean
```

This should start the qemu emulator and you should be able to see, "Changed from 32 bit to 64 bit! Boot is now complete ..." on the qemu emulator terminal. You can change the letter 'C' to something else in kernel.c and re-compile it again and run. This time the 'C' in "Changed" will be the new letter you assigned in the C file.

### How does it boot ?
The bootable image has two parts - x86 assembly and C (kernel.c). ```boot.asm``` loads the subsequent sectors which inculde assembly code beyond the BIOS loaded 512 bytes and the C kernel into the memory. After this point, ```boot_main.asm``` is invoked and the execution continues from there. It first switches into 32 bit protected mode and then into 64 bit long mode and invokes C kernel. The C kernel then changes the first letter of the video memory which is used to print to the screen
