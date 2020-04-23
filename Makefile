all: os-image

kernel_load.o: kernel_load.asm
	nasm $< -f elf64 -o $@

kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

boot_main.bin: boot_main.asm
	nasm $< -f bin -o $@

kernel.bin: kernel_load.o kernel.o
	ld -o $@ -Ttext 0x8200 $^ --oformat binary

os-image: boot.bin boot_main.bin kernel.bin
	ls -l $^
	cat $^ > os-image; dd if=/dev/zero bs=1 count=10240 >> os-image

clean:
	rm -rf *.o *.bin *.dis os-image 

run:
	qemu-system-x86_64 os-image