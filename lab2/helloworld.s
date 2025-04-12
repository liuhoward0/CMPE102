<<<<<<< HEAD
# A Hello World program in x86 32-bit assembly
#
# To compile this program into an executable helloworld.exe:
#
# gcc helloworld.s -o helloworld.exe
#
.global  main
.data
msg:
    .ascii "Hello, who are you?\n"
name:
    
.text
main:
#   calling write(1,msg,20)
    mov    $4,%eax      # eax=4 means indirectly call write()
    mov    $1,%ebx      # ebx=1 means write to channel 1 of Linux
    mov    $msg,%ecx    # ecx=msg means write the value of variable msg
    mov    $20,%edx     # edx=20 means write 20 bytes of msg
    int    $0x80        # interupt 0x80 invokes OS control function
#   calling read(0,name,20)
    mov    $3,%eax		# eax=3 means indirectly call read()
    mov    $0,%ebx		# ebx=0 means read from channel 0 of Linux
    mov    $name,%ecx	# ecx=name means read the value of variable name
    mov	   $20,%edx		# edx=20 means read 4 bytes into name
    int    $0x80		# interupt 0x80 invokes OS control function
#calling write(1,name,20)
    mov	   $4,%eax		# eax=4 means indirectly call write()
    mov    $1,%ebx		# ebx=1 means write to channel 1 of Linux
    mov    $name,%ecx	# ecx=name means write the value of variable name
    mov    $20,%edx		# edx=20 means write 20 bytes of msg
    int    $0x80
#   calling exit(0)
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
=======
# A Hello World program in x86 32-bit assembly
#
# To compile this program into an executable helloworld.exe:
#
# gcc helloworld.s -o helloworld.exe
#
.global  main
.data
msg:
    .ascii "Hello, who are you?\n"
name:
    
.text
main:
#   calling write(1,msg,20)
    mov    $4,%eax      # eax=4 means indirectly call write()
    mov    $1,%ebx      # ebx=1 means write to channel 1 of Linux
    mov    $msg,%ecx    # ecx=msg means write the value of variable msg
    mov    $20,%edx     # edx=20 means write 20 bytes of msg
    int    $0x80        # interupt 0x80 invokes OS control function
#   calling read(0,name,20)
    mov    $3,%eax		# eax=3 means indirectly call read()
    mov    $0,%ebx		# ebx=0 means read from channel 0 of Linux
    mov    $name,%ecx	# ecx=name means read the value of variable name
    mov	   $20,%edx		# edx=20 means read 4 bytes into name
    int    $0x80		# interupt 0x80 invokes OS control function
#calling write(1,name,20)
    mov	   $4,%eax		# eax=4 means indirectly call write()
    mov    $1,%ebx		# ebx=1 means write to channel 1 of Linux
    mov    $name,%ecx	# ecx=name means write the value of variable name
    mov    $20,%edx		# edx=20 means write 20 bytes of msg
    int    $0x80
#   calling exit(0)
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
>>>>>>> origin/main
