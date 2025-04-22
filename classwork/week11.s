#indirect addressing equivalent

.global main
.data
carray: .ascii "              "
iarray: .zero 80
.text
    lea     carray,%eax
    movb    $'x',(eax,edi)
    movb    (eax,edi),%al

    lea     iarray,%eax
    mov     $7,(eax,edi,4)
    mov     (eax,edi,4),%eax
