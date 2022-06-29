nasm bootloader.asm -f bin -o boot.bin 

nasm ExtendedProgram.asm -f elf64 -o ExtendedProgram.o

wsl /usr/local/x86_64elfgcc/bin/x86_64-elf-gcc -ffreestanding -mno-red-zone -m64 "Kernel.cpp" -o "Kernel.o" -nostartfiles

wsl x86_64-elf-ld -o kernel.tmp -Ttext 0x7e00 ExtendedProgram.o Kernel.o

objcopy -O binary kernel.tmp kernel.bin 

copy /b boot.bin+kernel.bin bootloader.bin

qemu-system-x86_64 bootloader.bin

pause