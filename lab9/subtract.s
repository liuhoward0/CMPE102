# subtract.s
.text
.global subtract
subtract:
#	prologue
	pushl	%ebp
	movl	%esp,%ebp
	subl	$16,%esp
#	core code
	movl	12(%ebp),%eax
	movl	%eax,-4(%ebp)
	movl	8(%ebp),%eax
	subl	-4(%ebp),%eax
	leave
	ret
