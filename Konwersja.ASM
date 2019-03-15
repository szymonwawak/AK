Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik

start:          mov     ax,dane
                mov     ds,ax
                mov     ax,stosik
                mov     ss,ax
                mov     sp,offset szczyt
pobranieLiczby:
                lea dx,numReq
                mov ah,09h
                int 21h
                mov dx,offset bufor
                mov ah,0ah
                int 21h
                mov bh,0
                mov bl,bufor[1]
                mov bufor[bx+2],'$'
                mov dx,offset bufor[2]
                mov ah,09h
                int 21h
                mov cx,bx
                dec bx
sprawdzenieLiczby:
                mov ax,0h
                mov al,bufor[bx+2]
                cmp al,39h
                jg errNaN
                cmp al,30h
                jl errNaN
                dec bx
                loop sprawdzenieLiczby
                jmp naLiczbe

errNaN:
                lea dx,errnn
                mov ah,09h
                int 21h
                mov ah,4ch
                mov al,00
                int 21h
naLiczbe:       mov bx,0
                mov ch,0
                mov cl,bufor[1]
czyWZakresie:
                mov ax,10d
                mul liczba
                jc errOutOfRange
                mov liczba,ax
                mov dl,bufor[bx+2]
                sub dl,30h
                mov ax,liczba
                add ax,dx
                jc errOutOfRange
                mov liczba,ax
                inc bx
                loop czyWZakresie
                jmp toHex
errOutOfRange:
                lea dx,errOOR
                mov ah,09h
                mov al,00h
                int 21h
                mov ah,4ch
                mov al,00h
                int 21h

toHex:
                mov cx,0004h
                mov dx,3h
convertHex:

                mov ax,cx
                mov bx,liczba
                mov cx,tmphex
                sar bx,cl
                and bx,000fh
                mov cl,tabHex[bx]
                mov bx,dx
                mov hexNum[bx],cl
                mov cx,ax
                add tmphex,4h
                dec dx
                loop convertHex

                lea dx,break
                mov ah,09h
                mov al,00h
                int 21h


                mov cl,10h
                mov dx,0fh
convertBin:
                mov ax,cx
                mov bx,liczba
                mov cx,tmpbin
                ror bx,cl
                and bx,0001h
                mov cl,tabBin[bx]
                mov bx,dx
                mov binNum[bx],cl
                mov cx,ax
                inc tmpbin
                dec dx
                loop convertBin

                lea dx,dwojk
                mov ah,09h
                int 21h

koniec:
               mov ah,4ch
               mov al,0h
               int 21h
Progr           ends

dane           segment
bufor db 6,?, 6 dup('?')
numReq db "Podaj liczbe z zakresu 0-65535",0dh,0ah,"$"
errnn db "Blad! To nie liczba!$"
errOOR db "Blad! Podano zla liczbe!$"
break db " ",0dh,0ah
szesn db "W systemie szesnastkowym: "
hexNum db "0000",0dh,0ah,"$"
dwojk db "W systemie dwojkowym: "
binNum db "0000000000000000$"
tabHex db "0123456789ABCDEF$"
tabbin db "01$"
tmphex dw 0h
tmpbin dw 0h
liczba dw 0h
dane            ends

stosik          segment
                dw    100h dup(0)
szczyt          Label word
stosik          ends

        end start