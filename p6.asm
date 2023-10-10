section .data
    ;1) corregir para que cumpla lo que se indica arriba
    NL: db  13,10
    NL_L:    equ $-NL

section .bss
    ;2) corregir para que cumpla lo que se indica arriba
    X       resb 4
    Y       resb 4
    Z       resb 4
    W       resb 8
    tmp     resb 32
    cad     resb 16

section .text
global _start:
_start:mov esi,cad
    ;3 Inicialización de variables X = 10h, Y = 20h, Z = 30h y W = 4000000000000000h
    ;corregir para que cumpla lo que se indica arriba
    ;usar byte, word o dword, solo esas en esta 
    mov dword [X], 0x10
    mov dword [Y], 0x20
    mov dword [Z], 0x30
    mov dword [W], 0x40000000
    mov dword [W+4],0x00000000

    ;4 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[X]
    call printHex
    call salto_linea
    mov eax,[Y]
    call printHex
    call salto_linea
    mov eax,[Z]
    call printHex
    call salto_linea
    mov edi,0x0
    mov eax,[W+edi*4]
    call printHex
    mov edi,0x1
    mov eax,[W+edi*4]
    call printHex
    call salto_linea

    ;5 Suma de X e Y con modo de direccionamiento de registro y guardarlo en Z
    ;corregir para que cumpla lo que se indica arriba 
    ;usar byte o word, solo esas
    mov eax,[X]
    mov ebx,[Y]
    add eax,ebx
    mov [Z],eax

    ;6 imprimir y comprobar que se cumpla lo que se les indico
    call printHex
    call salto_linea

    ;7 Resta de Y a W y guardado en tmp con modo de direccionamiento indirecto
    ;corregir para que cumpla lo que se indica arriba
    mov eax,[Y]
    mov ebx,[W] ;Parte Alta
    mov ecx,[W+4]; Parte Baja
    sub [W+4],eax
    mov eax,[W+4] ; Resultado Parte Baja
    sub dword[W],0x1   ; Resultado Parte Alta
    mov edx,tmp
    mov ebx,[W] ;Parte Baja
    mov [edx],eax
    mov [edx+4],ebx

    ;8 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[tmp+4]
    call printHex
    mov eax,[tmp]
    call printHex
    call salto_linea

    ;9 Incremento en 16777216 decimal (1000000h) a W con modo de direccionamiento 
    ;base más índice escalado mas desplazamiento trabajando con movimientos de 8 bits 
    ;corregir para que cumpla lo que se indica arriba
    mov edi,0x7
    inc byte[W+edi*1] ;Parte Baja
    inc dword[W] ;Parte Alta

    ;10 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[W] ;Parte Alta
    call printHex
    mov eax,[W+4] ;Parte Baja
    call printHex
    call salto_linea

    ;11 Sumar W con W sin utilizar memoria en la suma y guardarlo en W
    mov ebx,[W] ; Parte Alta
    mov ecx,[W+4]; Parte Baja
    add ecx,ecx
    mov [W+4],ecx
    adc ebx,ebx
    mov [W],ebx

    ;12 imprimir y comprobar que se cumpla lo que se les indico
    ;corregir para que cumpla lo que se indica arriba
    mov eax,[W] ;Parte Alta
    call printHex
    mov eax,[W+4] ;Parte Baja
    call printHex
    call salto_linea

    ;13 Multiplicación con signo de X por Y y guardado en tmp con modo de direccionamiento de memoria directa
    ;corregir para que cumpla lo que se indica arriba

    call clearReg
    mov ax,[X]
    mov bx,[Y]
    imul bx
    mov [0x0804A018],eax

    ;14 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[tmp]
    call printHex
    call salto_linea

    ;15 División de Y entre X y guardado en Z con modo de direccionamiento de memoria indirecta
    ;corregir para que cumpla lo que se indica arriba
    mov ax,[Y]
    mov bx,[X]
    div bx
    mov ecx,Z
    mov [ecx],eax

    ;16 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[Z]
    call printHex
    call salto_linea

    ;17 Invertir del octavo al onceavo byte de tmp y guardado en tmp con modo de direccionamiento base más desplazamiento
    ; y negar del noveno al decimo
    ;corregir para que cumpla lo que se indica arriba
    mov ebx, tmp
    neg byte [ebx + 8]
    neg byte [ebx + 9]
    neg byte [ebx + 10]
    neg byte [ebx + 11]
    neg byte [ebx + 12]
    
    ;18 imprimir y comprobar que se cumpla lo que se les indico
    mov eax,[tmp]
    call printHex
    mov eax,[tmp+0x4]
    call printHex
    mov eax,[tmp+0x8]
    call printHex
    mov eax,[tmp+0xC]
    call printHex
    call salto_linea

    ;19 Comprobación de resultados en cada una de las variables
    ;corregir para que cumpla lo que se indica arriba
    call salto_linea
    mov eax, [X]
    call printHex
    call salto_linea
    mov eax, [Y]
    call printHex
    call salto_linea
    mov eax, [Z]
    call printHex
    call salto_linea
    mov eax, [W]
    call printHex
    mov eax,[W+4]
    call printHex
    call salto_linea
    mov eax, [tmp]
    call printHex
    mov eax, [tmp+4]
    call printHex
    mov eax, [tmp+8]
    call printHex
    mov eax, [tmp+0xC]
    call printHex
    call salto_linea

    ;20 Finalización del programa
    ;corregir para que cumpla lo que se indica arriba
    mov eax, 1
    mov ebx, 0
    int 0x80

salto_linea:
    ;21 corregir para que cumpla lo que se indica arriba
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, NL
    mov edx, NL_L
    int 80h
    popad
    ret

printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    .nxt: shr eax,cl
    .msk: and eax,ebx
    cmp al, 9
    jbe .menor
    add al,7
    .menor:add al,'0'
    mov byte [esi],al
    inc esi
    mov eax, edx
    cmp cl, 0
    je .print
    sub cl, 4
    cmp cl, 0
    ja .nxt
    je .msk
    .print: mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret

clearReg:
    xor eax,eax ; Limpieza De Registros
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
    ret
