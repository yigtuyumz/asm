; nasm -f elf64 mylib.asm -o mylib.o
; ar rcs libmylib.a mylib.o

section .data
	HelloText db "Hello, from static library!", 10, 0

section .text
	global _write

_write:
	mov rax, 0x01
	mov rdi, 0x01
	mov rsi, HelloText
	mov rdx, 0x1C
	syscall
	ret
