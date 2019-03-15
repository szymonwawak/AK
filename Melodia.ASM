Progr           segment
                assume  cs:Progr, ds:dane, ss:stosik
start:

                mov     ax,dane
        mov     ds,ax
        mov     ax,stosik
        mov     ss,ax
        mov     sp,offset szczyt


                lea dx,plik
                mov ah,3dh
                mov al,0h
                int 21h
                mov link,al

petla:
                xor bh,bh
                mov bl,link
                mov cx,5
                lea dx,bufor
                mov ax,3f00h
                int 21h
                cmp al,0h
                jnz kontynuacja
                jmp koniec
kontynuacja:
                lea dx,bufor
                mov ax,0900h
                int 21h

                mov al,bufor[2]
                cmp al,'w'
                je nuta
                cmp al,'p'
                je polnuta
                cmp al,'q'
                je cwiercnuta
                cmp al,'o'
                je osemka
                cmp al,'s'
                je szesnastka
nuta:
                mov dlugosc,20
                jmp wysokosc
polnuta:
                mov dlugosc,10
                jmp wysokosc
cwiercnuta:
                mov dlugosc,5
                jmp wysokosc
osemka:
                mov dlugosc,2
                jmp wysokosc
szesnastka:
                mov dlugosc,1
                jmp wysokosc

wysokosc:
                mov al,bufor[1]
                cmp al,'C'
                je C
                cmp al,'c'
                je cm
                cmp al,'D'
                je D
                cmp al,'d'
                je dm
                cmp al,'E'
                je E
                cmp al,'e'
                je em
                cmp al,'F'
                je F
                cmp al,'f'
                je fm
                cmp al,'G'
                je G
                cmp al,'g'
                je gm
                cmp al,'A'
                je A
                cmp al,'a'
                je am
                cmp al,'H'
                je H
                cmp al,'N'
                je N

C:
mov dzwiek,0
jmp oktawa
cm:
mov dzwiek,2
jmp oktawa
D:
mov dzwiek,4
jmp oktawa
dm:
mov dzwiek,6
jmp oktawa
E:
mov dzwiek,8
jmp oktawa
em:
mov dzwiek,10
jmp oktawa
F:
mov dzwiek,12
jmp oktawa
fm:
mov dzwiek,14
jmp oktawa
G:
mov dzwiek,16
jmp oktawa
gm:
mov dzwiek,18
jmp oktawa
A:
mov dzwiek,20
jmp oktawa
am:
mov dzwiek,22
jmp oktawa
H:
mov dzwiek,24
jmp oktawa
N:
mov dzwiek,26
jmp oktawa

oktawa:

        mov bx,dzwiek
        mov al,bufor[0]
        cmp al,'1'
        je jeden
        cmp al,'2'
        je dwa
        cmp al,'3'
        je trzy
        cmp al,'4'
        je cztery
        cmp al,'5'
        je piec
        cmp al,'6'
        je szesc
        cmp al,'7'
        je siedem
		cmp al,'b'
		je pauza



jeden:
mov ax,o1[bx]
jmp graj
dwa:
mov ax,o2[bx]
jmp graj
trzy:
mov ax,o3[bx]
jmp graj
cztery:
mov ax,o4[bx]
jmp graj
piec:
mov ax,o5[bx]
jmp graj
szesc:
mov ax,o6[bx]
jmp graj
siedem:
mov ax,o7[bx]
jmp graj
pauza:
				xor     dx,dx
                mov     cx,dlugosc
                mov     ah,86h
                mov al,0h
                int     15h
				jmp petla
graj:
                out     42h,al
                mov     al,ah
                out     42h,al

                in      al,61h
                or      al,00000011b
                out     61h,al

                xor     dx,dx
                mov     cx,dlugosc
                mov     ah,86h
                                mov al,0h
                int     15h

                in      al,61h
                and     al,11111100b
                out 61h,al
				
				xor     dx,dx
                mov     cx,1
                mov     ah,86h
                mov al,0h
                int     15h

                                

jmp petla
koniec:
                mov ax,4c00h
                int 21h


Progr           ends
dane segment

dzwiek dw 0
dlugosc dw 0
plik db "piosenka.txt",0
link db 0
bufor db "00000$"
o1 dw 36152,34086,32243,30589,29097,28405,27113,25934,24347,22942,21691,20569,19241,18354
o2 dw 18354,17289,16342,15493,14548,14202,13712,12967,12173,11471,10845,10284,9699,9107
o3 dw 9107,8583,8116,7647,7230,7018,6817,6448,6087,5736,5423,5120,4830,4553
o4 dw 4553,4307,4058,3836,3615,3519,3418,3224,3043,2874,5476,2560,2414,2281
o5 dw 2281,2153,2032,1918,1810,1759,1709,1612,1521,1435,1356,1280,1207,1139
o6 dw 1139, 1075, 1015, 958,904,879,854,806,760,718,677,639,604,570
o7 dw 570,538,508,479,452,439,427,403,380,359,339,320,301,285

w db 32
p db 16
q db 8
o db 4
s db 2



dane            ends

stosik          segment
                dw    100h dup(0)
szczyt          Label word
stosik          ends

        end start