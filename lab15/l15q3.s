.global  main
.data
correctmsg:
    .ascii "password correct!\n"
    correctlen = . - correctmsg
incorrectmsg:
    .ascii "password incorrect!\n"
    incorrectlen = . - incorrectmsg
askid:
    .ascii "please enter id:"
    askidlen = . - askid
askpw:
    .ascii "please enter password:"
    askpwlen = . - askpw
userid:
    .ascii "temp"
input1:
    .ascii "        "
password:
    .ascii "sjsu"
input2:
    .ascii "        "
.text
main:
# prompt for id ...
    mov    $4,%eax
    mov    $1,%ebx
    mov    $askid,%ecx
    mov    $askidlen,%edx
    int    $0x80
# read(0,input1,64)
    mov    $3,%eax
    mov    $0,%ebx
    mov    $input1,%ecx
    mov    $64,%edx
    int    $0x80
#   check id
    movl   input1,%ebx
    cmpl   userid,%ebx
    jne    main
# prompt for password ...
    mov    $4,%eax
    mov    $1,%ebx
    mov    $askpw,%ecx
    mov    $askpwlen,%edx
    int    $0x80
# read(0,input2,64)
    mov    $3,%eax
    mov    $0,%ebx
    mov    $input2,%ecx
    mov    $64,%edx
    int    $0x80
#   check id
    movl   input2,%ebx
    cmpl   password,%ebx
    jne    incorrect
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
