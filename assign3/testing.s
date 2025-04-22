#
# This is the skeleton program for CMPE 102 section 2 assignment 3
#
# gcc -g sjsusimulator.s -o sjsusimulator.exe
#
.global  main
.data
two: .long 2
ten: .long 10
base: .long 10
counter: .long 0
minus: .ascii "-"
itoa_string: .ascii "          \n"
itob_string: .ascii "                                  \n"
sjsuprompt: .ascii "(sjsu) "
sjsumov: .ascii "mov\n"
sjsuadd: .ascii "add\n"
sjsumul: .ascii "mul\n"
instruction: .ascii "                                  "
ilen: .long 0
alu: .long 0
.text
main:
#   similar to eax = write(1,"(sjsu) "
    mov    $4,%eax
    mov    $1,%ebx
    mov    $sjsuprompt,%ecx
    mov    $7,%edx
    int    $0x80
#   similar to eax = read(0,&coinchoice,2)
    mov    $3,%eax
    mov    $0,%ebx
    mov    $instruction,%ecx
    mov    $16,%edx
    int    $0x80
    dec    %eax
    mov    %eax,ilen
    cmpl   $0x20766f6d,instruction	# cmpl "mov ",instruction in hex
    je     do_mov
    cmpl   $0x20646461,instruction	# cmpl "add ",instruction in hex
    je     do_add
    cmpl   $0x206c756d,instruction	# cmpl "mul ",instruction in hex
    je     do_mul
    cmpl   $0x20627573,instruction	
    je     do_sub
    cmpl   $0x0a636564,instruction
    je     do_dec
    cmpl   $0x0a786568,instruction 	# "hex\n"
    je     do_hex
    cmpl   $0x206C6F72,instruction	# "rol "
    je     do_rol
    cmpl   $0x20726F72,instruction	# "ror "
    je     do_ror
    cmpl   $0x0a746F6E,instruction 	# "not\n"
    je     do_not
    cmpl   $0x206C6173,instruction	# "sal "
    je     do_sal
    cmpl   $0x20726173,instruction	# "sar "
    je     do_sar
    cmpl   $0x20726F78,instruction	# "xor "
    je     do_xor
    cmpw   $0x726F,instruction		# "or "
    je     do_or
    cmpl   $0x20646E61,instruction	# "and "
    je     do_and
    jmp    main
print_reg:
    call   itoa
    mov    $4,%eax
    mov    $1,%ebx
    incl   %edi
    mov    %edi,%ecx
    lea    itoa_string+11,%edx
    subl   %edi,%edx
    int    $0x80
    mov    alu,%eax
    call   itob
    mov    $4,%eax
    mov    $1,%ebx
    incl   %edi
    mov    %edi,%ecx
    lea    itob_string+35,%edx
    subl   %edi,%edx
    int    $0x80
    jmp    main
do_or:
    call   atoi
    mov    alu,%eax
    or     %eax,counter
    mov    counter,%eax
    mov    %eax,alu
    call    print_reg
do_and:
    call   atoi
    mov    alu,%eax
    and    %eax,counter
    mov    counter,%eax
    mov    %eax,alu
    call    print_reg
do_xor:
    call   atoi
    mov    alu,%eax
    xor    %eax,counter
    mov    counter,%eax
    mov    %eax,alu
    call    print_reg
do_sar:
    call   atoi
    movb   counter,%cl
    mov    alu,%eax
    sar    %cl,%eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
do_sal:
    call   atoi
    movb   counter,%cl
    mov    alu,%eax
    sal    %cl,%eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
do_not:
    call   atoi
    mov    alu,%eax
    not    %eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
do_rol:
    call   atoi
    movb   counter,%cl
    mov    alu,%eax
    rol    %cl,%eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
do_ror:
    call   atoi
    movb   counter,%cl
    mov    alu,%eax
    ror    %cl,%eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
do_dec:
    movl   $10,base
    jmp     main
do_hex:
    movl   $16,base
    jmp     main
do_mov:
    call   atoi
    mov    counter,%eax
    mov    %eax,alu
    call    print_reg
do_add:
    call   atoi
    mov    counter,%eax
    add    %eax,alu
    movl   alu, %eax
    movl   %eax,counter
    call   print_reg
do_sub:
    call   atoi
    mov    counter,%eax
    sub    %eax,alu
    movl   alu, %eax
    movl   %eax,counter
    call    print_reg
do_mul:
    call   atoi
    mov    counter,%eax
    imul    alu,%eax
    mov    %eax,alu
    mov    %eax,counter
    call    print_reg
# exit here
    mov    $1,%eax
    mov    $0,%ebx
    int    $0x80
#   Function atoi() to convert an ascii string like "mov 125" into binary 125
atoi:
    mov    ilen,%esi			# set esi to the length of instruction variable
    dec    %esi				# decrement by 1 to point at the last byte
    mov    $1,%ebx
    movl   $0,counter    		# initialize the result counter to 0
atoi_loop: 
    mov    $0,%eax
    movb   instruction(%esi),%al	# eax = instruction[esi]
    subb   $'0',%al			# convert from character like '0' to binary like 0
    imull  %ebx				# multiply eax by the scaling factor in ebx
    add    %eax,counter			# add the value of one digit to the counter
    imull   $10,%ebx,%ebx		# multiply the scaling factor by 10, to get 1,10,100,etc
    dec    %esi				# esi = esi -1, moving to right
    cmpl   $4,%esi			# Have we reached index 4 (the space) of "mov 125"
    jge    atoi_loop			# not yet, jump back
    ret
itob:
    mov    counter,%eax
#   copy 10 spaces to itoa_string
    movl   $0x20202020,itob_string
    movl   $0x20202020,itob_string+4
    movl   $0x20202020,itob_string+8
    movl   $0x20202020,itob_string+12
    movl   $0x20202020,itob_string+16
    movl   $0x20202020,itob_string+20
    movl   $0x20202020,itob_string+24
    movl   $0x20202020,itob_string+28
    movw   $0x2020,itob_string+32
    lea    itob_string+33,%edi
    movl   $32,%ecx
itob_loop:
    mov    $0,%edx
    idivl  two		# divide by 16
    addl   $'0',%edx	# convert from binary 0 (or 1-9) to '0' (or '1'-'9')
    movb   %dl,(%edi)	# think: *(edi) = '0'
    dec    %edi		# think: edi--;
    loop   itob_loop # decrement ecx, if not 0, jump to itob_loop
    movb   $'b',(%edi)
    dec    %edi
    movb   $'0',(%edi)
    dec    %edi
    ret#   Function itoa() to convert integer variable counter's value to ASCII characters, placed in variable itoa_string.
itoa:
#   copy counter to %eax to prepare for division
    mov    counter,%eax
    cmpl   $16,base
    je     hexadecimal
    cmpl   $0,%eax
    jge    positive
    neg    %eax
positive:
#   copy 10 spaces to itoa_string
    movl   $0x20202020,itoa_string
    movl   $0x20202020,itoa_string+4
    movw   $0x2020,itoa_string+8
#   point %edi index register to the last byte of itoa_string, think:
#   char *itoa_string="    ";
#   char *edi = &itoa_string[3];
    lea    itoa_string+9,%edi
itoa_loop:
    mov    $0,%edx
    idivl  ten
    addl   $'0',%edx	# convert from binary 0 (or 1-9) to '0' (or '1'-'9')
    movb   %dl,(%edi)	# think: *(edi) = '0'
    dec    %edi		# think: edi--;
    cmpl   $0,%eax
    jg     itoa_loop
    cmpl   $0,counter
    jge    no_minus
    movb   $'-',(%edi)
    dec    %edi
no_minus:
    ret			# ret: returns/jumps to the instruction after CALL itoa
hexadecimal:
#   copy 8 spaces to itoa_string
    movl   $0x20202020,itoa_string+2
    movl   $0x20202020,itoa_string+6
    lea    itoa_string+9,%edi
    movl   $8,%ecx	# repeat 8 times because 4 bytes == 8 hex units
itoa_hex_loop:
    mov    $0,%edx
    idivl  base		# divide by 16
    cmpl   $10,%edx	# is the remainder >= 10, if so covert to A-F
    jge    convert_hex_char
    addl   $'0',%edx	# convert from binary 0 (or 1-9) to '0' (or '1'-'9')
    jmp    done_one_dec_char
convert_hex_char:
    addl   $55,%edx	# convert from binary 10-15 to 'A'-'F' (65-70)
done_one_dec_char:
    movb   %dl,(%edi)	# think: *(edi) = '0'
    dec    %edi		# think: edi--;
    loop  itoa_hex_loop # decrement ecx, if not 0, jump to itoa_hex_loop
    ret
