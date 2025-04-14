.global  main
.data
iarray: .long 10,20,30,40,50,60,70,80
carray: .byte '0','1','2','3','4','5','6','7'
.text
main:
    mov iarray,%eax    
    mov iarray+12,%eax 
    mov iarray+16,%eax 
    movb carray+2,%ah 
    movb carray+4,%al
    mov  carray+4,%ax  
    mov  carray-16,%eax

    movl $01234567,%eax
    movl $5,%esi
    mov  carray(%esi),%al

    movl $01234567,%eax
    movl $5,%esi
    mov  iarray(%esi),%eax

    ret
