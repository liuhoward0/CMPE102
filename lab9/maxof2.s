# maxof2.s 
.text
.global maxof2
maxof2:
#       prologue
        pushl   %ebp
        movl    %esp, %ebp
        subl    $16, %esp
#       core code
        movl    8(%ebp), %eax   # mov 7 to eax
        movl    %eax, -4(%ebp)  # mov eax to variable 1
        movl    12(%ebp), %eax  # mov 9 to eax
        movl    %eax, -8(%ebp)  # mov eax to variable 2
        cmpl    -4(%ebp),%eax   # compare eax with variable 1
        jl      first_larger    # if eax < variable 1, jump to first_larger
        jmp     return          # eax contains the larger
first_larger:
        movl    -4(%ebp), %eax  # move variable 1 to eax to return
return:
        leave
        ret
