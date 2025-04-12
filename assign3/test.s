.global main
.data
num: .long 4
.text
main:
	mov	$num,%eax
	ror	%eax
	int	$0x80
