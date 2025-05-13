.global main
.data
.text
main:
    mov    $3,%ecx
    mov    $4,%ebx
    add    %ebx,%ecx
    mov    $3,%ecx
    mov    $4,%ebx
    addl    %ebx,%ecx
    mov    $3,%ecx
    mov    $4,%ebx
    imull  %ebx,%ecx

    movl   $6,%eax
    imul   %ebx

    movl   $1,%eax
    movl   $0,%ebx
    int    $0x80
