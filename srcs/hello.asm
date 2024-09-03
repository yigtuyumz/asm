; TASK : make a "hello world" program

; data section
; used for declaring initialized data or constants.
; this data does not change at runtime!
section .data
	HelloText db "Hello from assembly!", 10	; 10 for newline '\n'
;       |      |           |
;       |      |           +-------> defined bytes
;       |      |
;       |      +-------------------> define bytes
;       |
;       +--------------------------> name of memory address

; bss section
; the bss section is used for declaring variables.
; in there, the data is allocated for future use.


; text section
; keeps the actual code.
section .text
	global _start


_start:
	mov rax, 0x01			; calling syscall write(fildes, str, strlen);
	mov rdi, 0x01			; first parameter of write (fildes)
	mov rsi, HelloText		; second parameter of write (str)
	mov rdx, 21				; third parameter of write (strlen)
	syscall
	mov rax, 60				; calling syscall exit(status_code);
	mov rdi, 0				; first parameter of exit (status code)
	syscall
