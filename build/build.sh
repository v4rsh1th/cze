# List of all Object Files
OBJECTFILES="wrapper/wrapper.o"

# Utility to compile a file
function compile {
    FILE=$1
    EXTENSION=${FILE: -2}
    NEWFILE=${FILE:0:${#FILE}-2 }.o

    if [ $EXTENSION == ".c" ]
    then
        x86_64-elf-gcc -Wall -ffreestanding -mcmodel=large -mno-red-zone -mno-mmx -mno-sse -mno-sse2 -c $FILE -o $NEWFILE -I include
    elif [ $EXTENSION == "sm" ]
    then
        /usr/local/bin/nasm -f elf64 $FILE -o $NEWFILE
    fi
    OBJECTFILES+=" $NEWFILE"
}

# Utility to compile all C and Assembly files in a directory
function compileAll {
  ALLFILES=$(find $1 -type f -name '*.c' -o -name '*.asm')
      for file in $ALLFILES ; do
        compile $file
      done
}

# Compile Bootloader
/usr/local/bin/nasm -f bin boot/boot.asm -o boot/boot.bin

# Compile Kernel
/usr/local/bin/nasm -f elf64 wrapper/wrapper.asm -o wrapper/wrapper.o
compileAll drivers
compileAll include/util
compileAll include/lib
compileAll include/cze
compileAll kernel/cpu
compileAll kernel/process
compile kernel/kernel.c
x86_64-elf-ld -o kernel/kernel.bin -nostdlib -T build/build.lds $OBJECTFILES

# Compile into one file
cat boot/boot.bin kernel/kernel.bin > dist/cze

# Cleanup old files
rm -f dist/cze.iso

# Put onto floppy image
dd if=/dev/zero of=dist/cze.img bs=1024 count=1440
dd if=./dist/cze of=dist/cze.img seek=0 conv=notrunc

# Remove binary file
rm -rf dist/cze

# Create temporary iso directory and move image to it
mkdir dist/iso
mv dist/cze.img dist/iso

# Create ISO
mkisofs -quiet -V 'ARC' -o dist/cze.iso -b cze.img -hide cze.img dist/iso

# Remove temporary iso directory
rm -rf dist/iso