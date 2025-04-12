# This program reads 2 integers in ascii, calls atoi to convert each into binary integers,
# then calls maxof2() to find the large of the 2
# then calls itoa to convert the larger into a string in itoa_string
# then calls write to print it out
.globl  main
.data
msg: .ascii "Enter a number:"
 msglen=.-msg
input: .ascii "          "
 inputlen=.-input
x: .long 0
y: .long 0
itoa_string: .ascii "    \n"
.text
main:
#   write(1,msg,msglen)
    mov $4,%eax
    mov $1,%ebx
    mov $msg,%ecx
    mov $msglen,%edx
    int $0x80
#   read(0,input,inputlen)
    mov $3,%eax
    mov $0,%ebx
    mov $input,%ecx
    mov $inputlen,%edx
    int $0x80
#   eax = atoi(input)
    push $input
    call atoi
    addl $4,%esp
    movl %eax,x
#   write(1,msg,msglen)
    mov $4,%eax
    mov $1,%ebx
    mov $msg,%ecx
    mov $msglen,%edx
    int $0x80
#   read(0,input,inputlen)
    mov $3,%eax
    mov $0,%ebx
    mov $input,%ecx
    mov $inputlen,%edx
    int $0x80
#   eax = atoi(input)
    push $input
    call atoi
    addl $4,%esp
    movl %eax,y
#   eax = maxof2(x,y)
    push y
    push x
    call maxof2
#    itoa(10,eax,&itoa_string) 
    push $itoa_string
    push %eax
    push $10
    call itoa
    add $12, %esp
#   write(1,itoa_string,10)
    mov $4,%eax
    mov $1,%ebx
    mov $itoa_string,%ecx
    mov $5,%edx
    int $0x80
#   exit
    mov $1,%eax
    mov $0,%ebx
    int $0x80
