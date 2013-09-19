  org 07c00h    ; 告诉编译器程序加载到7c00处
  mov ax, cs
  mov ds, ax
  mov es, ax
  call Display  ; 调用子程序
  jmp $

; Display子程序
Display:
  mov ax, BootMessage
  mov bp, ax
  mov cx, 16 
  mov ax, 01301h
  mov bx, 000ch
  mov dl, 0
  int 10h
  ret

BootMessage:      db  "Hello, OS!"
times 510-($-$$)  db 0 ; 用0填充剩下控件，使之为512字节

dw 0xaa55     ; 结束的AA55两个字节
