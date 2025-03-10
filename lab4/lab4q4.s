.global  main
.data
iarray: .long 10,20,30,40,50,60,70,80,90,100
.text 
main:
    movl $0,%ecx                # ecx used as the sum counter
    movl $4,%esi                # esi used as the index
    lea iarray,%esi
    lea iarray,%ebx
    addl $10*4,%ebx
loop:
    addl (%esi),%ecx      # ecx = ecx + iarray(esi)
    addl $4, %esi               # esi = esi + 8
    cmpl %ebx,%esi             # Has esi reached the end of iarray?
    jl   loop                   # not yet, repeat
#exit 
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
