.global itoa
itoa:

    mov 4(%esp), %esi  # %esi = ten
    mov 8(%esp), %eax  # %eax = counter
    mov 12(%esp), %edi # edi = itoa_string

    movl   $0x20202020, (%edi)
    add    $3,%edi

itoa_loop:
    mov    $0, %edx
    idivl  %esi
    addl   $'0', %edx
    movb   %dl, (%edi)
    dec    %edi
    cmpl   $0, %eax
    jg     itoa_loop

    ret
