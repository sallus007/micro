

%macro write 2
        mov rax,1
        mov rdi,1 
        mov rsi,%1
        mov rdx,%2
        syscall
%endmacro

section .data

	arr dq 111111111111111h,-989898989898989h,666666666666666h
	len equ 3

	msg1 db "Positive Numbers ",10
	len1 equ $-msg1

	msg2 db "Negative Numbers ",10
	len2 equ $-msg2

section .bss

	ncnt resq 1
	pcnt resq 1
	num resb 16
	
section .text
global _start
_start:

	write len1,msg1
	mov rsi,arr
	mov rdi,3
	mov rbx,0
	mov rcx,0

    up: mov rax,[rsi]
	cmp rax,000000000000000h
	js neg
	
   pos: inc rbx
	jmp nxt

   neg:inc rcx

   nxt:
	add rsi,8
	dec rdi
	jnz up
	
	mov [pcnt],rbx
	mov [ncnt],rcx

	write msg1,len1
	mov rax,[pcnt]
	call dis

	write msg2,len2
	mov rax,[ncnt]
	call dis
  
        mov rax,60
        mov rbx,0
        syscall

dis:
        mov rsi,num
        mov rcx,16

        cnt:    rol rax,4
                mov dl,al
                and dl,0FH
                cmp dl,09h
                jbe add30
                add dl,07h
        add30:  add dl,30h
                mov [rsi],dl
                inc rsi
                loop cnt
               
        write   num,16
ret
