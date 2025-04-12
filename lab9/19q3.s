.global  main
.text
main:
    mov  $0xdeadbeef,%eax
    and  $0b00000000000000001111111111111111,%eax
    mov  $0xdeadbeef,%eax
    or   $0b00000000000000001111111111111111,%eax
    mov  $0xdeadbeef,%eax
    xor  $0b00000000000000001111111111111111,%eax
    mov  $0xdeadbeef,%eax
    not  %eax
    mov  $0xdeadbeef,%eax
    shl  $4,%eax
    mov  $0xdeadbeef,%eax
    sal  $4,%eax
    mov  $0xdeadbeef,%eax
    shr  $4,%eax
    mov  $0xdeadbeef,%eax
    sar  $4,%eax
