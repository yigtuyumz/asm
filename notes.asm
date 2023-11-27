; temel olarak 3 adet 'section' bulunur.


section .data
; burada sabit verilerin tanimlamalari yapilir.
; string
; magic numbers
; terminating string
; gibi...

section .bss
; programda kullanicak olan veriler icin hafizada
; yer ayirma islemleri bu kisimda yapilir.

section .text
; kodlamalarin yapildigi kisimdir.
; 'label' lerin kaydedildigi bir tablo vardir ver o tabloya
; kayit islemi burada yapilir.
; her zaman bir label bulundurmak zorundadir. bu label
; _start: program ld ile link'lendigi zaman kullanilan entry point ismidir.
; main: program gcc ile link'lendigi zaman kullanilan entry point ismidir.

; nasm -f elf64 file.asm -> 'file.o' 64 bitlik derleme 'o' formatinda cikti dosyasi olusturur.
; nasm -f elf32 file.asm -> 'file.o' 32 bitlik derleme 'o' formatinda cikti dosyasi olusturur.

; ld -m elf_i386 -o file file.o -> file.o dosyasini link'ler.


; register'lar
; donanima ozel olusturulan degerlerdir.
; eax, rax, ebx gibi...
; her register'in aslinda sayisal bir degeri vardir.

; E register   0000000000000000_00000000_00000000
; E register =       X         +   H    +    L   
; 
;                 .--------------------32 bits--------------------.
;                 |              .-------------16 bits------------.
;                 |              |  -8bits HIGH-  |  -8bits LOW-  |
; General purpose | EAX      AX  |       AH       |      AL       | accumulator register (resulting an arithmetic operation)
;                 | EBX      BX  |       BH       |      BL       |
;     registers   | ECX      CS  |       CH       |      CL       | counter register (increment, decrement operations more efficient)
;                 | EDX      DX  |       DH       |      DL       |
; ----------------------------------------------------------------.
;                 | ESI      Source index                          Copy operations (source address of the data)
;                 | EDI      Destination index                     Copy operations (destination address of the data)
;                 | ESP      Stack pointer                         Top of the stack (when we push something into the stack, this is increased.)
;                 | EBP      Base pointer                          Bottom of the stack (constant, always has same value)
; 
; 
; 