.text
.global add2
add2:
pushl    %ebp
movl    %esp,%ebp
subl    $16, %esp
movl    8(%ebp),%eax
movl    %eax,-4(%ebp)
movl    12(%ebp),%eax
movl    %eax,-8(%ebp)
addl    -8(%ebp),%eax
leave
ret
