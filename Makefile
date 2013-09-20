build:
	nasm boot.asm -f bin -o output/boot.bin
	node build.js

clean:
	rm output/*

loader:
	nasm loader.asm -f bin -o output/loader.bin
