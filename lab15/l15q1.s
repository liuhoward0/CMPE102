# license key checking program
#
# main calls function checkpw, which prompts for a license key
# and check if the input matches the variable license key
# If so, function checkpw returns 1 in eax, if not, returns 0 in eax
# main checks eax and print "license key correct" or "license key incorrect"
.global  main
.data
correctmsg:
    .ascii "license key correct! Go ahead and use the software.\n"
    correctlen = . - correctmsg
incorrectmsg:
    .ascii "license key incorrect! Must pay for the software.\n"
    incorrectlen = . - incorrectmsg
askmsg:
    .ascii "please enter license key:"
    asklen = . - askmsg
input:
    .ascii "          "
license_key:
    .ascii "sjsu"
.text
#   initialize license key
    movl   %eax,license_key
main:
#   eax = checkpw()
    call   checkpw
#   if eax == 0, jump to label incorrect
    cmp    $0,%eax
    je     incorrect
#   correct case here, print correct message
    mov    $4,%eax
    mov    $1,%ebx
    mov    $correctmsg,%ecx
    mov    $correctlen,%edx
    int    $0x80
    jmp    exit
incorrect:
    mov    $4,%eax
    mov    $1,%ebx
    mov    $incorrectmsg,%ecx
    mov    $incorrectlen,%edx
    int    $0x80
exit:
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
# function checkpw here...
checkpw:
# prompt for license key...
    mov    $4,%eax
    mov    $1,%ebx
    mov    $askmsg,%ecx
    mov    $asklen,%edx
    int    $0x80
# read input license key...
    mov    $3,%eax
    mov    $0,%ebx
    mov    $input,%ecx
    mov    $20,%edx
    int    $0x80
#   check input license key with true license key
    movl   input,%ebx
    cmpl   license_key,%ebx
    je     return1
    mov    $0,%eax
    ret
return1:
    mov    $1,%eax
    ret
