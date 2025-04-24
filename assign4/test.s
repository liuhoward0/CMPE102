.global  main
.data
input: .ascii "          "
 inputlen=.-input
arr: .long 0,0,0,0,0,0,0,0,0,0
max: .long 1
.text
main:
collectionloop:
				#   eax = read(0,input,10)
    mov $3,%eax
    mov $0,%ebx
    mov $input,%ecx
    mov $inputlen,%edx
    int $0x80
				#   eax = atoi(input)
    lea input,%eax
    subl $12,%esp
    push %eax
    call atoi
    addl $16,%esp

    cmpl $0,%eax		#if input is negative quit
    jl   visualization

    movl $inputlen,%ecx		# divide eax by 10, use it as index with exceptions
    cdq
    idiv %ecx
    cmpl $0,%edx
    jg   skip
    cmpl $0,%eax
    je   skip
    dec  %eax
skip:
    lea  arr,%edi
    addl $1,(%edi,%eax,4)

    movl max,%ebx		# updating max
    movl (%edi,%eax,4),%ecx
    cmpl %ebx,%ecx
    jle  skip2
    movl %ecx,max
skip2:
    jmp  collectionloop

visualization:
    xor  %ebx,%ebx		# initialize ebx for outerloop
    lea  arr,%esi		# esi holds arr address
    
outerloop:
    movl max,%eax
    addl $5,%eax
    push %eax
    call malloc
    addl $4,%esp
    movl %eax,%edi
    cmpl $9,%ebx
    jl   norm
    movl $0x7C303031,(%edi)
    addl $4,%edi
    jmp  init
norm:
    movb $0x20,(%edi)		# empty space at start of display
    inc  %edi			# edi points to next memory
    addl $'0',%ebx		# display = ebx + 1 + '0'
    movb %bl,(%edi)
    subl $'0',%ebx
    addl  $1,(%edi)
    inc  %edi
    movw $0x7c30,(%edi)		# next display slot " 10______..."
    addl $2,%edi
init:
    xor  %ecx,%ecx		# initialize ebx for innerloop
innerloop:
    cmpl (%esi,%ebx,4),%ecx	# for (j < max; j++) if j < arr[i] print *, else print .
    jl   asterisk
    movb $'.',(%edi,%ecx,1)
    jmp  done
asterisk:
    movb $'*',(%edi,%ecx,1)
done:
    inc  %ecx
    cmpl max,%ecx
    jl   innerloop
    movb $0x0a,(%edi,%ecx,1)
    sub  $4,%edi
    push %edi
    inc  %ebx
    cmpl $10,%ebx
    jl   outerloop

    xor  %edi,%edi
printloop:
    movl max,%edx
    addl $5,%edx
    mov  $4,%eax
    mov  $1,%ebx
    mov  (%esp),%ecx
    int  $0x80
    inc  %edi 
    addl $4,%esp
    cmpl $10,%edi
    jl   printloop

    mov $1,%eax
    mov $0,%ebx
    int $0x80
