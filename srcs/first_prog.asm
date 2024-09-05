; TASK : just use the exit system call

; _start is a special label. (it is linker's default entrypoint.)
; gloabal labels are accessible by the environment (ld, gcc, ..)
global _start

_start:
	mov rax, 0x3C		; exit syscall code -> 0x3C
	mov rdi, 0x00		; first parameter of exit (which is status code)
	syscall				; calling exit(1)
