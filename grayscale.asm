section .text
global cvtRGBToGray

cvtRGBToGray:
    ; img2: rdi
    ; img1: rsi
    ; m: rdx
    ; n: rcx
    
    push rbx            ; save rbx, rbp
    push rbp            

    mov r8, rcx         ; r8 = height
    xor r9, r9          

y_loop:
    cmp r9, r8          
    jge end             ; if y >= height, exit

    mov r10, rdx        ; r10 = width
    xor r11, r11        

x_loop:
    cmp r11, r10        
    jge next_row        ; if x >= width, next

    ; get the index
    ; index = (y * width + x) * 3
    mov rax, r9
    imul rax, r10
    add rax, r11
    imul rax, 3

    ; rgb values
    movzx rbx, byte [rsi + rax]
    movzx rbp, byte [rsi + rax + 1]
    movzx r12, byte [rsi + rax + 2]

    ; average
    add rbx, rbp
    add rbx, r12
    mov r12, 3
    xor rdx, rdx
    div r12

    ; grayscale value to img2
    mov [rdi + r9 * r10 + r11], bl

    ; x increment
    inc r11
    jmp x_loop

next_row:
    
    ; y increment
    inc r9
    jmp y_loop

end:
    pop rbp             
    pop rbx             
    
    xor rax, rax
    ret
