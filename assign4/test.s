.global  main
.data
input: .ascii "          "
 inputlen=.-input
arr: .long 0,0,0,0,0,0,0,0,0,0
max: .long 1
.text
main:
collectionloop:			#   collection loop responsible for taking user input
				#   eax = read(0,input,10)
    mov $3,%eax
    mov $0,%ebx
    mov $input,%ecx
    mov $4,%edx
    int $0x80
				#   eax = atoi(input)
    lea input,%eax
    subl $12,%esp
    push %eax
    call atoi
    addl $16,%esp

    cmpl $0,%eax		#   if input is negative quit
    jl   visualization

    movl $inputlen,%ecx		#   divide eax by 10, use it as index with exceptions
    cdq
    idiv %ecx
    lea  arr,%edi		#   %edi = &arr
    cmpl $10,%eax
    jl   normal
    movl $9,%eax

normal:
    addl $1,(%edi,%eax,4)

    movl max,%ebx		#   updating max
    movl (%edi,%eax,4),%ecx
    cmpl %ebx,%ecx
    jle  skip2
    movl %ecx,max
skip2:
    jmp  collectionloop

visualization:
    movl $9,%ebx		#   initialize ebx to act as 'int j' for outerloop
    lea  arr,%esi		#   esi = &arr
    
outerloop:
    movl max,%eax		#   edi = malloc(max + 5)
    addl $5,%eax
    push %eax
    call malloc
    addl $4,%esp
    movl %eax,%edi		#   edi = &display

    cmpl $9,%ebx		#   hardcoding bin 100
    jl   norm
    movl $0x7C303031,(%edi)
    addl $4,%edi
    jmp  init

norm:
    movb $0x20,(%edi)		#   alignment for 2 digit bins
    inc  %edi
    addl $'0',%ebx		#   displays proper bin number
    movb %bl,(%edi)
    subl $'0',%ebx
    addl  $1,(%edi)
    inc  %edi
    movw $0x7c30,(%edi)		#   adds the "0|" to the end
    addl $2,%edi

init:
    xor  %ecx,%ecx		# initialize ecx to act as 'int i' for innerloop
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
    movb $0x0a,(%edi,%ecx,1)	#   display + '\n'
    sub  $4,%edi		#   makes sure whole display is included
    push %edi			#   " 10|***..."  ->  " 10|***..."
    dec  %ebx			#        ^        ->   ^
    cmpl $0,%ebx		#        %edi          %edi
    jge  outerloop

    xor  %edi,%edi		#   prepares edi for counter usage as reg ecx is in use for write
printloop:
    movl max,%edx
    addl $5,%edx

    mov  $4,%eax
    mov  $1,%ebx
    mov  (%esp),%ecx
    int  $0x80

    inc  %edi 
    addl $4,%esp		#   pops the address of allocated displays
    cmpl $10,%edi
    jl   printloop

vertical_display:
    subl $40,%esp		#   retrieves addresses of allocated displays
    movl %esp,%esi		#   esi -> top of displays

    xor  %ebx,%ebx		#   for (j = 0; j < max + 3; j++)

    push $1234			#   a filler for the "pop" that makes outerloop work (see end of outerloop)
verticle_outerloop:
    addl $4,%esp
    movl $11,%eax		#   eax -> malloc(bin amount + \n)
    push %eax
    call malloc
    addl $4,%esp

    xor  %ecx,%ecx		#   initializing ecx as i for innerloop
				#   for (i = 0; i < 10; i++)	10 because 10 bins
verticle_innerloop:
    movl (%esi,%ecx,4),%edi	#   edi -> display stack[ecx] or display stack[i]
    movb (%edi,%ebx,1),%dl	#   eax[0-10] = display stack[ecx][ebx] or edi[ebx] or edi[j]

    cmpb $0x7c,%dl		#   changing '|' into '-' for a vertical display of the separation line
    jne  continue
    movb $'-',%dl

continue:
    movb %dl,(%eax)
    inc  %eax

    inc  %ecx
    cmpl $10,%ecx		#   end of innerloop
    jl   verticle_innerloop

    movb $0x0a,(%eax)
    subl $10,%eax		#   retrieving rest of vertical display
    push %eax

    inc  %ebx
    push max			#   end of outerloop
    addl $3,(%esp)
    cmpl (%esp),%ebx
    jle   verticle_outerloop

    movl max,%edi
    addl $3,%edi

print_vertical_loop:
    movl $11,%edx

    mov  $4,%eax
    mov  $1,%ebx
    mov  (%esp),%ecx
    int  $0x80

    dec  %edi 
    addl $4,%esp		#   pops the address of allocated displays
    cmpl $0,%edi
    jge  print_vertical_loop

    mov $1,%eax			#   exit
    mov $0,%ebx
    int $0x80
