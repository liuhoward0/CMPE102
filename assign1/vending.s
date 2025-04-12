#
# This is the skeleton program for CMPE 102 section 2 assignment 1
#
# gcc -g vending.s -o vending.exe
#
.global  main
.data
ten: .long 10
itoa_string: .ascii "    "
msg:
    .ascii "\nEnter coin choice (q,d,n,p):"
    len = . - msg
beg:
    .ascii "change: "
end:
    .ascii "cents"
term:
    .ascii "end "
newline:
    .ascii "\n"
coinchoice:
    .ascii "    "
counter: .long 0
.text
main:
#   similar to eax = write(1,"enter coin choice (q,d,n,p):",26)
    mov    $4,%eax
    mov    $1,%ebx
    mov    $msg,%ecx
    mov    $len,%edx
    int    $0x80
#   similar to eax = read(0,&coinchoice,2)
    mov    $3,%eax
    mov    $0,%ebx
    mov    $coinchoice,%ecx
    mov    $2,%edx
    int    $0x80

#   if coinchoice == 'q' jump to add25 to add 25 to counter and print the new value
    cmpb   $'q',coinchoice
    je     add25
#   if coinchoice == 'd' jump to add10 to add 10 to counter and print the new value
    cmpb   $'d',coinchoice
    
    je     add10
#   if coinchoice == 'n' jump to add5 to add 5 to counter and print the new value
    cmpb   $'n',coinchoice
    je     add5
#   if coinchoice == 'p' jump to add5 to add 5 to counter and print the new value
    cmpb   $'p',coinchoice
    je     add1
    jmp    add0
    jmp    call_exit
begin:
#   write(1,"change",7)
    mov    $4,%eax
    mov    $1,%ebx
    mov    $beg,%ecx
    mov    $7,%edx
    int    $0x80
    ret
add25:
    call begin
    add    $25,counter
    # call itoa(counter,itoa_string) - converts the integer in counter to ascii in itoa_string
    call itoa
    mov    $4,%eax
    mov    $1,%ebx
    mov    $itoa_string,%ecx
    mov    $3,%edx
    int    $0x80
    call   ending
    jmp    main
add10:
    call   begin
    add	   $10,counter
    # call itoa(counter,itoa_string) - converts the integer in counter to ascii in itoa_string
    call itoa
    mov    $4,%eax
    mov    $1,%ebx
    mov    $itoa_string,%ecx
    mov    $3,%edx
    int    $0x80
    call   ending
    jmp    main
add5:
    call   begin
    add	   $5,counter
    call itoa
    mov    $4,%eax
    mov    $1,%ebx
    mov    $itoa_string,%ecx
    mov    $3,%edx
    int    $0x80
    call   ending
    jmp    main
add1:
    call   begin
    add	   $1,counter
    call itoa
    mov    $4,%eax
    mov    $1,%ebx
    mov    $itoa_string,%ecx
    mov    $3,%edx
    int    $0x80
    call    ending
    jmp    main
add0:
#    write(1,"end ",4)
    mov    $4,%eax
    mov    $1,%ebx
    mov    $term,%ecx
    mov    $4,%edx
    int    $0x80

    call   begin

# prints counter as ascii
    mov    $4,%eax
    mov    $1,%ebx
    mov    $itoa_string,%ecx
    mov    $3,%edx
    int    $0x80

    call   ending

# "\n"
    mov    $4,%eax
    mov    $1,%ebx
    mov    $newline,%ecx
    mov    $1,%edx
    int    $0x80
    jmp    call_exit

ending:
#   similar to eax = write(1,"cents",5)
    mov    $4,%eax
    mov    $1,%ebx
    mov    $end,%ecx
    mov    $5,%edx
    int    $0x80
    ret
# exit here
call_exit:
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80

#   Function itoa() to convert integer variable counter's value to ASCII characters, placed in variable itoa_string.
itoa:
#   copy counter to %eax to prepare for division
    mov    counter,%eax
#   copy four spaces to itoa_string
    movl   $0x20202020,itoa_string
#   point %edi index register to the last byte of itoa_string, think:
#   char *itoa_string="    ";
#   char *edi = &itoa_string[3];
    lea    itoa_string+1,%edi
itoa_loop:
    mov    $0,%edx
    idivl  ten
    addl   $'0',%edx	# convert from binary 0 (or 1-9) to '0' (or '1'-'9')
    movb   %dl,(%edi)	# think: *(edi) = '0'
    dec    %edi		# think: edi--;
    cmpl   $0,%eax
    jg     itoa_loop
    ret			# ret: returns/jumps to the instruction after CALL itoa
