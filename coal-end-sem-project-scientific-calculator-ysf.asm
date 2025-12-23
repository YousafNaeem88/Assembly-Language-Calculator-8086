.model small

org 100h

jmp start

msg: db 0dh,0ah,"CALCULATOR",0dh,0ah,0dh,0ah,"1-For addition",0dh,0ah,"2-For multiplication",0dh,0ah,"3-For subtraction",0dh,0ah,"4-For division",0dh,0ah,"5-For square",0dh,0ah,"6-For power",0dh,0ah,"$"
msgA: db 0dh,0ah,"Enter Your Operation (1 to 6): $"
msgB: db 0dh,0ah,"Enter First Number: $"
msgC: db 0dh,0ah,"Enter Second Number: $"
msgD: db 0dh,0ah,"PLEASE ENTER A VALID OPERATION $"
msgE: db 0dh,0ah,"Result", 0dh,0ah,"the sum is:","$"
msgF: db 0dh,0ah,"Result", 0dh,0ah,"the difference is: ","$"
msgG: db 0dh,0ah,"Result", 0dh,0ah," the quotient is:","$"
msgH: db 0dh,0ah,"Result", 0dh,0ah,"the answer is: " ,0dh,0ah,"$"
msgI: db 0dh,0ah,"Result", 0dh,0ah,"the answer is: ",0dh,0ah,"$"
msgJ: db 0dh,0ah,"Enter the Base ","$"
msgK: db 0dh,0ah,"Enter the Power","$"
msgM: db 0dh,0ah,"Enter The Number ","$"
msgL: db 0dh,0ah,"THANK YOU FOR USING MY CALCULATOR"

base db ?
pow db ?
nl1 db 0ah,0dh,"enter base:","$"
nl2 db 0ah,0dh," Result in power 3: ",0dh,0ah,"$"

.code
start:
    mov ah, 9
    mov dx, offset msg
    int 21h

    mov dx, offset msgA
    int 21h
    mov ah, 0
    int 16h

    cmp al, '1'
    je addition
    cmp al, '2'
    je multiplication
    cmp al, '3'
    je subtraction
    cmp al, '4'
    je division
    cmp al, '5'
    je square
    cmp al, '6'
    je power

    mov ah, 9
    mov dx, offset msgD
    int 21h

    mov ah, 0
    int 16h
    jmp start

addition:
    ; Performing addition
    mov ah, 9
    mov dx, offset msgB
    int 21h
    mov cx, 0
    call inputno
    push dx
    mov ah, 9
    mov dx, offset msgC
    int 21h
    mov cx, 0
    call inputno
    pop bx
    add dx, bx
    push dx
    mov ah, 9
    mov dx, offset msgE
    int 21h
    pop dx
    mov cx, 10000
    call view
    jmp exit

exit:
    mov dx, offset msgL
    mov ah, 9
    int 21h
    mov ah, 0
    int 16h
    ret

view:
    mov ax, dx
    mov dx, 0
    div cx
    call viewno
    mov bx, dx
    mov dx, 0
    mov ax, cx
    mov cx, 10
    div cx
    mov dx, bx
    mov cx, ax
    cmp ax, 0
    jne view
    ret

inputno:
    mov ah, 0
    int 16h
    mov dx, 0
    mov bx, 1
    cmp al, 0dh
    je formno
    sub al, 30h
    call viewno
    mov ah, 0
    push ax
    inc cx
    jmp inputno

formno:
    pop ax
    push dx
    mul bx
    pop dx
    add dx, ax
    mov ax, bx
    mov bx, 10
    push dx
    mul bx
    pop dx
    mov bx, ax
    dec cx
    cmp cx, 0
    jne formno
    ret

viewno:
    push ax
    push dx
    mov dx, ax
    add dl, 30h
    mov ah, 2
    int 21h
    pop dx
    pop ax
    ret

multiplication:
    ; Performing multiplication
    mov ah, 9
    mov dx, offset msgB
    int 21h
    mov cx, 0
    call inputno
    push dx
    mov ah, 9
    mov dx, offset msgC
    int 21h
    mov cx, 0
    call inputno
    pop bx
    mov ax, dx
    mul bx
    mov dx, ax
    push dx
    mov ah, 9
    mov dx, offset msgH
    int 21h
    pop dx
    mov cx, 10000
    call view
    jmp exit

subtraction:
    ; Performing subtraction
    mov ah, 9
    mov dx, offset msgB
    int 21h
    mov cx, 0
    call inputno
    push dx
    mov ah, 9
    mov dx, offset msgC
    int 21h
    mov cx, 0
    call inputno
    pop bx
    sub bx, dx
    mov dx, bx
    push dx
    mov ah, 9
    mov dx, offset msgF
    int 21h
    pop dx
    mov cx, 10000
    call view
    jmp exit

division:
    ; Performing division
    mov ah, 9
    mov dx, offset msgB
    int 21h
    mov cx, 0
    call inputno
    push dx
    mov ah, 9
    mov dx, offset msgC
    int 21h
    mov cx, 0
    call inputno
    pop bx
    mov ax, bx
    mov cx, dx
    mov dx, 0
    div cx
    mov dx, ax
    push dx
    mov ah, 9
    mov dx, offset msgG
    int 21h
    pop dx
    mov cx, 10000
    call view
    jmp exit

square:
    ; Performing square
    mov ah, 9
    mov dx, offset msgM
    int 21h
    mov cx, 0
    call inputno
    push dx
    mov ah, 9
    mov cx, 0
    pop bx
    mov ax, dx
    mul bx
    mov dx, ax
    push dx
    mov ah, 9
    mov dx, offset msgI
    int 21h
    pop dx
    mov cx, 10000
    call view
    jmp exit

power:
    ; Performing power
    ; Enter base
    lea dx, nl1
    mov ah, 9
    mov dx, offset msgJ
    int 21h
    mov ah, 1
    int 21h
    sub al, 30h
    mov bl, al
    mov base, al

    ; Enter power
    lea dx, nl2
    mov ah, 9
    mov dx, offset msgK
    int 21h
    mov ah, 1
    int 21h
    sub al, 30h
    mov cl, al
    dec cl
    mov ax, 00
    mov al, base

lbl1:
    mul bl
    loop lbl1
    mov cl, 10
    div cl
    add ax, 3030h
    mov dx, ax
    mov ah, 02h
    int 21h
    mov dl, dh
    int 21h
    mov ah, 4ch
    int 21h


end main




