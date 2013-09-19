build:
	nasm bootloader.asm -f bin -o output/boot.bin
	node build.js

clean:
	rm output/*
