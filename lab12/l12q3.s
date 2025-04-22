.global main
.data
student_id = 0
student_name = 0+4
student_birthdate = 0+4+20
student_size = 0+4+20+8
student:
	.space student_size
student1: .long 0
.text
main:
    pushl   $student_size
    call    malloc
    addl    $4,%esp
    movl    $116935113,student_id(%eax)
    movl    $0x61776f48,student_name(%eax)
    movw    $0x6472,student_name+4(%eax)
    movl    $0x31303130,student_birthdate(%eax)
    movl    $0x30303032,student_birthdate+4(%eax)
    add     $28,%eax
    mov     $1,%eax
    mov     $0,%ebx
    int     $0x80
