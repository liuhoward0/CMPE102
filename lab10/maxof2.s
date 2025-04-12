.text
.global	maxof2
maxof2:
	pushl	%ebp
	movl	%esp, %ebp
        subl    $16, %esp
	movl	8(%ebp), %eax
        movl    %eax, -4(%ebp)
	movl	12(%ebp), %eax
        movl    %eax, -8(%ebp)
        cmpl    -4(%ebp),%eax
	jl 	first_larger
	jmp	return
first_larger:
	movl	-4(%ebp), %eax
return:
	leave
	ret
