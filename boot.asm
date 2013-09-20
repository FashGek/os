  BaseOfStack equ 07c00h

  org 07c00h    ; 告诉编译器程序加载到7c00处

  jmp short LABEL_START ; 开始启动
  nop

  ; BPB数据
  BS_OEMNAME      db 'nakupend'  ; OEM String 8个字节
  BPB_BytsPerSec  dw 512    ; 每个扇区字节数
  BPB_SecPerClus  db 1      ; 簇的大小，一个扇区
  BPB_RsvdSecCnt  dw 1      ; Boot记录占用多少扇区
  BPB_NumFATs     db 2      ; FAT表数量
  BPB_RootEntCnt  dw 224    ; 根目录文件数最大值
  BPB_TotSec16    dw 2880   ; 扇区数
  BPB_Media       db 0xF0   ; 媒体描述符
  BPB_FATSz16     dw 9      ; 每FAT扇区数
  BPB_SecPerTrk   dw 18     ; 每磁道扇区数
  BPB_NumHeads    dw 2      ; 磁头数（面数）
  BPB_HiddSec     dd 0      ; 隐藏扇区数
  BPB_TotSec32    dd 0      ; 
  BS_DrvNum       db 0      ; 中断13的驱动器号
  BS_Reserved1    db 0      ; 
  BS_BootSig      db 29h    ; 扩展引导标记
  BS_VolID        dd 0      ; 卷序列号
  BS_VolLab       db 'nakupenda  '  ; 卷标，11个字节
  BS_FileSysType  db 'FAT12   '     ; 文件系统类型 

ReadSector:     ; 从第ax个扇区开始将cl个扇区读入es:bx中
  push bp
  mov bp, sp
  sub esp, 2
  mov byte [bp-2], cl
  push bx       ; 保存bx
  mov bl, [BPB_SecPerTrk] ; bl：除数
  div bl
  inc ah
  mov cl, ah
  mov dh, al
  shr al, 1
  mov ch, al
  and dh, 1
  pop bx
  mov dl, [BS_DrvNum]
.GoOnReading:
  mov ah, 2
  mov al, byte [bp-2]
  int 13h
  jc .GoOnReading

  add esp, 2
  pop bp

  ret

; 起始程序
LABEL_START:
  mov ax, cs
  mov ds, ax
  mov ss, ax
  mov sp, BaseOfStack
  mov es, ax
  
  xor ah, ah
  xor dl, dl
  int 13h
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
