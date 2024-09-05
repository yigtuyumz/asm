section .data
	OutText db "The sum is: ", 0		; static data for write
	NumberText db "%d", 10, 0			; static data for printf

section .text
	global _start		; exposed tag to the ld (by default '_start' in linux)
	extern printf		; -lc -dynamic-linker [libc location]

_start:
	mov r10, 20		; first number
	mov r11, 50		; second number
	add r10, r11	; sum numbers and store it's value in r10

	mov rax, 1			; syscall write(fildes, bytes, length);
	mov rdi, 1			; stdout
	mov rsi, OutText	; written bytes
	mov rdx, 12			; length
	syscall				; run write

	mov rdi, NumberText		; printf first arg
	mov rsi, r10			; printf second arg
	call printf				; run printf

	mov rax, 60			; syscall exit
	mov rdi, 0			; exit status
	syscall				; call exit
