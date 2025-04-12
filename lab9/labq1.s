.globl  main
.data
msg: .ascii "Enter a number to increment:"
 msglen=.-msg
input: .ascii "          "
 inputlen=.-input
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
    dec %eax
#   exit
    mov $1,%eax
    mov $0,%ebx
    int $0x80
