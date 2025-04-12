.global   main
.data
msg: .ascii "          "
.text
main:
    mov    $3,%eax
    mov    $0,%ebx
    mov    $msg,%ecx
    mov    $10,%edx
    int    $0x80
    mov    $4,%eax
    mov    $1,%ebx
    mov    $msg,%ecx
    mov    $6,%edx
    int    $0x80
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
