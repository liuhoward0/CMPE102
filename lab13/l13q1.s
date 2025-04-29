.global    main
.data
hellomsg: .ascii "hello world, I am LAM\n"
    hellolen = . - hellomsg
once: .long 0
.text
.type    main, @function
main:
    pushl  $INThandler
    pushl  $2
    call   signal
    addl   $8, %esp
loop:
    mov    $4,%eax
    mov    $1,%ebx
    mov    $hellomsg,%ecx
    mov    $hellolen,%edx
    int    $0x80
    pushl  $1
    call   sleep
    addl   $4, %esp
    jmp    loop
INThandler:
    pushl  %ebp
    movl   %esp, %ebp
    cmpl   $2,once
    jge    exit
#   variable once being zero, re-register signal(2,INThandler) once more
    addl   $1,once
    pushl  $INThandler
    pushl  $2
    call   signal
    addl   $8, %esp
    leave
    ret
exit:
    movl   $1, %eax
    movl   $0, %ebx
    int    $0x80
