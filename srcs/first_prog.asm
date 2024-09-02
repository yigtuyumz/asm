; TASK : just use the exit system call

global _start			; linker entrypoint

_start:
	mov rax, 0x3C		; exit syscall code -> 0x3C
	mov rdi, 0x00		; first parameter of exit (which is status code)
	syscall				; calling exit(1)
