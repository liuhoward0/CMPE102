.global main
.data
message:
    .ascii "hello\n"
    messagelen = . - message
.text
main:
    mov    $4,%eax
    mov    $1,%ebx
    mov    $message,%ecx
    mov    $messagelen,%edx
    int    $0x80
    mov    $1,%eax
    mov    $2,%ebx
    int    $0x80
