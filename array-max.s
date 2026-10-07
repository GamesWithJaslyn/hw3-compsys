# Write the assembly code for the array_max function

array_max:
    push  %rdi              # saving first argument
    push  %rsi              # saving second argument
    push  %r12              # saving r12 tosurvive the function
    push  %r13              # saving r12 tosurvive the function
    Enter $0, $0
    movq $0, %r12
    movq $0, %r13

    .loop:

    movq (%rsi), %rax

    
    cmpq %rdi, %r12
    jge loop_done

    cmpq %r13, %rax
    jg set_new_high

    addq $8, %rsi
    addq $1, %r12
    jmp .loop

set_new_high:
    movq  %rax, %r13
    addq $8, %rsi
    addq $1, %r12
    jmp .loop




loop_done:
    movq %r13, %rax

leave
ret

