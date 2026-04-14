.data
fmt: .string "%d "
fmt_last: .string "%d"
nl: .string "\n"

.text
.globl main

main:
    mv s4, a1
    addi s3, a0, -1

    slli a0, s3, 2

    addi sp, sp, -8
    sd ra, 0(sp)

    call malloc

    ld ra, 0(sp)
    addi sp, sp, 8

    mv s0, a0

    slli a0, s3, 2

    addi sp, sp, -8
    sd ra, 0(sp)

    call malloc

    ld ra, 0(sp)
    addi sp, sp, 8

    mv s1, a0

    slli a0, s3, 2

    addi sp, sp, -8
    sd ra, 0(sp)

    call malloc

    ld ra, 0(sp)
    addi sp, sp, 8

    mv s2, a0

    li t0, 1

loop1:
    bgt t0, s3, done1

    slli t1, t0, 3
    add t1, s4, t1
    ld a0, 0(t1)

    addi sp, sp, -8
    sd ra, 0(sp)

    call atoi

    ld ra, 0(sp)
    addi sp, sp, 8

    addi t2, t0, -1
    slli t2, t2, 2
    add t2, s0, t2
    sw a0, 0(t2)

    addi t0, t0, 1
    j loop1

done1:
    addi t0, s3, -1
    li t1, -1

loop_i:
    blt t0, zero, done

loop:
    blt t1, zero, loop_done

    slli t2, t1, 2
    add t2, s2, t2
    lw t3, 0(t2)

    slli t4, t3, 2
    add t4, s0, t4
    lw t5, 0(t4)

    slli t6, t0, 2
    add t6, s0, t6
    lw t2, 0(t6)

    ble t5, t2, pop_stack
    j loop_done

pop_stack:
    addi t1, t1, -1
    j loop

loop_done:
    blt t1, zero, set_minus1

    slli t2, t1, 2
    add t2, s2, t2
    lw t3, 0(t2)

    slli t5, t3, 2
    add t5, s0, t5
    lw t6, 0(t5)

    slli t4, t0, 2
    add t4, s1, t4
    sw t6, 0(t4)

    j push_stack

set_minus1:
    slli t4, t0, 2
    add t4, s1, t4
    li t5, -1
    sw t5, 0(t4)

push_stack:
    addi t1, t1, 1

    slli t2, t1, 2
    add t2, s2, t2
    sw t0, 0(t2)

    addi t0, t0, -1
    j loop_i

done:
    li s5, 0

print_loop:
    bge s5, s3, finish

    slli t2, s5, 2
    add t2, s1, t2
    lw a1, 0(t2)

    addi t3, s3, -1
    beq s5, t3, print_last

    la a0, fmt
    j do_print

print_last:
    la a0, fmt_last

do_print:
    addi sp, sp, -8
    sd ra, 0(sp)

    call printf

    ld ra, 0(sp)
    addi sp, sp, 8

    addi s5, s5, 1
    j print_loop

finish:
    la a0, nl
    addi sp, sp, -8
    sd ra, 0(sp)

    call printf

    ld ra, 0(sp)
    addi sp, sp, 8

exit:
    li a0, 0
    ret
