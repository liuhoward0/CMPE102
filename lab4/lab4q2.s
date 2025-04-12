<<<<<<< HEAD
.global  main
.data
student_id: .long 0
x: .long 0
.text
main:
  mov $16935113,%eax
  mov %eax,student_id
  imul %eax
  mov student_id,%eax
  mov $-1,%edx
  neg %eax
  mov $11,%ebx
  idiv %ebx
  ret
=======
.global  main
.data
student_id: .long 0
x: .long 0
.text
main:
  mov $16935113,%eax
  mov %eax,student_id
  imul %eax
  mov student_id,%eax
  mov $-1,%edx
  neg %eax
  mov $11,%ebx
  idiv %ebx
  ret
>>>>>>> origin/main
