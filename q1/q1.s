.globl make_node
make_node:
    addi sp,sp,-16
    sd ra, 8(sp)
    sd a0, 0(sp)

    li a0, 24
    call malloc

    mv t0, a0

    ld t1, 0(sp)
    sw t1, 0(t0)

    sd zero, 8(t0)
    sd zero, 16(t0)

    mv a0, t0

    ld ra, 8(sp)
    addi sp, sp, 16
    ret

.globl insert
insert:
    addi sp, sp, -24
    sd ra, 16(sp)
    sd a0, 0(sp)
    sd a1, 8(sp)

    beq a0, zero, insert_make
    
    lw t0, 0(a0)
    blt a1, t0, go_left

go_right:
    ld t1, 16(a0)
    mv a0, t1
    ld a1, 8(sp)
    call insert

    ld t2, 0(sp)
    sd a0, 16(t2)
    mv a0, t2
    j insert_done

go_left:
    ld t1, 8(a0)
    mv a0, t1
    ld a1, 8(sp)
    call insert

    ld t2, 0(sp)
    sd a0, 8(t2)
    mv a0, t2
    j insert_done

insert_make:
    ld a0, 8(sp)
    call make_node

insert_done:
    ld ra, 16(sp)
    addi sp, sp, 24
    ret

.globl get
get:
    beq a0, zero, get_null

get_loop:
    lw t0, 0(a0)

    beq t0, a1, get_found
    blt a1, t0, get_left

    ld a0, 16(a0)
    bne a0, zero, get_loop
    j get_null

get_left:
    ld a0, 8(a0)
    bne a0, zero, get_loop

get_null:
    li a0, 0
    ret

get_found:
    ret

.global getAtMost
getAtMost:
    li t0, -1

loop_atMost:
    beq a1, zero, done_atMost

    lw t1, 0(a1)

    bgt t1, a0, go_left_atMost

    mv t0, t1
    ld a1, 16(a1)
    j loop_atMost

go_left_atMost:
    ld a1, 8(a1)
    j loop_atMost

done_atMost:
    mv a0, t0
    ret
