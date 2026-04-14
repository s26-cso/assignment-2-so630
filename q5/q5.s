.section .data
filename:
    .asciz "input.txt"
yes:
    .asciz "Yes\n"
no:
    .asciz "No\n"

.section .bss
char1: .space 1
char2: .space 1

.section .text
.globl main
main:
    li a7, 56 # sys_openat
    li a0, -100 # AT_FDCWD
    la a1, filename
    li a2, 0 # O_rdonly
    li a3, 0
    ecall
    mv s0, a0

    li a7, 62
    mv a0, s0
    li a1, 0
    li a2, 2
    ecall
    mv s1, a0

    addi s1, s1, -1

    blt s1, zero, is_palindrome

    li a7, 62
    mv a0, s0
    mv a1, s1
    li a2, 0
    ecall

    li a7, 63
    mv a0, s0
    la a1, char1
    li a2, 1
    ecall

    lb t0, char1
    li t1, 10
    bne t0, t1, init_loop
    addi s1, s1, -1

init_loop:
    li s2, 0

loop:
    bge s2, s1, is_palindrome

    li a7, 62
    mv a0, s0
    mv a1, s2
    li a2, 0
    ecall

    li a7, 63
    mv a0, s0
    la a1, char1
    li a2, 1
    ecall

    li a7, 62
    mv a0, s0
    mv a1, s1
    li a2, 0
    ecall

    li a7, 63
    mv a0, s0
    la a1, char2
    li a2, 1
    ecall

    lb t0, char1
    lb t1, char2
    bne t0, t1, not_palindrome

    addi s2, s2, 1
    addi s1, s1, -1
    j loop

is_palindrome:
    li a7, 64
    li a0, 1
    la a1, yes
    li a2, 4
    ecall
    j close

not_palindrome:
    li a7, 64
    li a0, 1
    la a1, no
    li a2, 3
    ecall

close:
    li a7, 57
    mv a0, s0
    ecall
    j exit

exit:
    li a7, 93
    li a0, 0
    ecall
