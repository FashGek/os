
; ±àÒëÁ´½Ó·½·¨
; (ld µÄ¡®-s¡¯Ñ¡ÏîÒâÎª¡°strip all¡±)
;
; [root@XXX XXX]# nasm -f elf foo.asm -o foo.o
; [root@XXX XXX]# gcc -c bar.c -o bar.o
; [root@XXX XXX]# ld -s hello.o bar.o -o foobar
; [root@XXX XXX]# ./foobar
; the 2nd one
; [root@XXX XXX]# 


extern choose	; int choose(int a, int b);


[section .data]	; Êý¾ÝÔÚ´Ë

num1st		dd	3
num2nd		dd	4


[section .text]	; ´úÂëÔÚ´Ë

global _start	; ÎÒÃÇ±ØÐëµ¼³ö _start Õâ¸öÈë¿Ú£¬ÒÔ±ãÈÃÁ´½ÓÆ÷Ê¶±ð¡£
global myprint	; µ¼³öÕâ¸öº¯ÊýÎªÁËÈÃ bar.c Ê¹ÓÃ

_start:
	push	num2nd		; ©·
	push	num1st		; ©§
	call	choose		; ©Ç choose(num1st, num2nd);
	add	esp, 4		; ©¿

	mov	ebx, 0
	mov	eax, 1		; sys_exit
	int	0x80		; ÏµÍ³µ÷ÓÃ

; void myprint(char* msg, int len)
myprint:
	mov	edx, [esp + 8]	; len
	mov	ecx, [esp + 4]	; msg
	mov	ebx, 1
	mov	eax, 4		; sys_write
	int	0x80		; ÏµÍ³µ÷ÓÃ
	ret
	

