# Write the assembly code for the main function of the mystery program
.global main
.text

# 1. Signature
# int main(int argc, char * argv[])
main:
# 2. Pseudocode:
    # if (argc != 3) 
    # { 
    #   printf("Two arguments required.");
    #   return 1;
    # }
    # else
    # {
    #    long result = crunch(atoi(argv[1]), atoi(argv[2]));
    #    if(result < 0) { printf(hat_msg); }
    #    elseif(result > 0) { printf(beer_msg); }
    #    else { printf(tea_msg); }
    #
    #    return 0;
    # }

# 3. Variable Mappings:
    # argc -> %rdi
    # argv[] -> %rsi
    # argv[1] -> 8(%rsi)
    # argv[2] -> 16(%rsi)
    # result -> %rax
    #

# 4. Function Skeleton
    # Prologue:
    push  %rdi              # saving first argument
    push  %rsi              # saving second argument
    push  %r12              # saving r12 tosurvive the function calls of atoi
    push  %r13              # saving r13 tosurvive the function calls of atoi
    enter $24, $0           # Allocate / align stack
   
    # Body:
    cmpq $3, %rdi
    je   .same
    default_else:
    jmp  .error


   .same:
      movq 8(%rsi), %rdi
      call atoi
      movq %rax, %r12           # move the long value of the result of atoi, into r12

      movq 16(%rsi), %rdi
      call atoi
      movq %rax, %r13           # move the long value of the result of atoi, into r13

      movq %r12, %rdi
      movq %r13, %rsi
      call crunch

      cmpq $0, %rax
      jl   .negative
      cmpq $0, %rax
      jg   .positive
      default_else:
      jmp  .zero


      .negative:
          movq $hat_msg, %rdi
          call printf
          movq $0, %rax
          jmp .done

      .positive:
          movq $beer_msg, %rdi
          call printf
          movq $0, %rax
          jmp .done

      .zero:
          movq $tea_msg, %rdi
          call printf
          movq $0, %rax
          jmp .done
   
   .error:
      movq $error_msg, %rdi
      call printf
      movq $1, %rax
      jmp .done
    

    # Epilogue:
    .done:
      leave               # Clean up stack frame.
      pop %r13            # Restore saved regs in revser order
      pop %r12
      pop %rsi
      pop %rdi
      ret                 # Return to call site





.data
error_msg:
  .asciz "Two arguments required."
hat_msg:
  .asciz "hat"
tea_msg:
  .asciz "tea"
beer_msg:
  .asciz "beer"
