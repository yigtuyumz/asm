section .text
	global _start		; ld entrypoint, `-e _start`
	extern _write		; subroutine from static library

_start:
	call _write			; call externally defined subroutine
	mov rax, 60			; syscall exit
	mov rdi, 0			; exit status
	syscall				; call exit
