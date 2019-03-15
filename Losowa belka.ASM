Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
start:

mov ax,dane
mov ds,ax
mov ax,0
losowanieNumeru:
                mov ah,2ch
                int 21h
                mov dl,dh
                mov dh,0
                mov ax,dx
                mov dx,256h
                div dl
                mov al,ah
                mov ah,0
                mov tempRand,ax

programPetla:
                mov ax,tempRand
                cmp ax,254
                jl  losowanie
                mov ax,1
losowanie:
                                mov tempRand,ax
                                mov cx,3
                                dec ax
                                mul cx
                                mov bx,ax

                                mov ax,0
                                mov al,rand[bx]
                                sub al,30h
                                mul ten
                                inc bx
                mov cl,rand[bx]
                sub cl,30h
                add al,cl
                mov bx,160
                mul bx
                mov random,ax
staraLinia:
                mov ax,ds
                mov es,ax
                push ds
                mov ax,0b800h
                mov bx,random
                mov si,bx
                mov ds,ax
                mov cx,80
                mov di,offset kopia
pobranieLinii:
                rep
                movsw
                mov ax,bx
                mov si,ax
                mov ah,11h
                mov cx,80
zmianaKoloru:
                mov ds:[si+1],ah
                add si,2h
                loop zmianaKoloru
                mov ax,8600h
                mov cx,8h
                xor dx,dx
                int 15h

powrotTekstu:
                pop ds
                mov cx,80
                mov ax,0b800h
                mov es,ax
                mov si,offset kopia
                mov ax,random
                mov di,ax
                rep
                movsw
                mov ax,8600h
                mov cx,8h
                xor dx,dx
                int 15h
                inc tempRand
                mov ah, 0bh
                int 21h
                cmp al, 0
               jne  koniec
               jmp programPetla
koniec:
                 mov ax,4c00h
                 int 21h


Progr           ends
dane segment
ten dw 10
tempRand dw 0h
random dw 0h
dlugosc dw 160
rand db "12,00,06,08,15,15,07,08,09,00,21,03,00,16,13,02,15,08,02,04,22,09,13,02,17,06,24,00,20,00,08,15,15,14,19,09,08,22,07,11,10,18,09,12,17,13,12,17,09,15,08,17,24,06,12,20,08,16,23,00,01,10,24,14,"
rand2 db "23,04,19,19,17,07,22,01,01,10,04,12,04,19,21,03,12,14,16,21,23,11,11,12,17,07,08,06,04,11,21,02,17,20,10,19,16,05,01,21,10,19,23,00,18,19,24,11,18,13,16,12,20,12,15,07,04,19,21,01,19,18,03,20"
rand3 db "01,14,00,07,09,04,03,03,10,04,14,03,10,19,11,00,08,12,04,19,01,05,16,13,00,06,02,00,00,04,06,04,18,03,01,02,22,14,15,22,15,04,24,14,05,05,04,07,13,17,14,11,14,00,15,08,09,15,13,24,21,16,04,14"
rand4 db "02,21,17,15,00,15,09,12,14,22,20,09,04,21,17,18,08,22,11,23,07,15,14,08,04,06,07,12,23,01,24,00,09,24,05,18,15,08,11,19,10,17,11,13,19,05,19,08,00,02,23,10,06,08,01,08,09,17,05,21,13,21,19,24"
kopia db 160 dup(0)
dane            ends

stosik          segment
                dw    100h dup(0)
szczyt          Label word
stosik          ends

        end start