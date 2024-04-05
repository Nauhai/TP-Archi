.global _start

cuve_pleine: .byte 0
.align

nombres: .byte 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b0000111, 0b01111111, 0b01101111
.align

wait1:
	stmfd sp !, {r0, lr}
	ldr r0, =0x2FFFF
bclwait1:
	cmp r0, #0
	bls finwait1
	sub r0, r0, #1
	b bclwait1
finwait1:
	ldmfd sp !, {r0, pc}
	
waitn:
	stmfd sp !, {r8, lr}
bclwaitn:
	cmp r8, #0
	bls finwaitn
	bl wait1
	sub r8, r8, #1
	b bclwaitn
finwaitn:
	ldmfd sp !, {r8, pc}

remplir:
	stmfd sp !, {r1-r3, r8, lr}
	mov r1, #0
	mov r2, #0
	ldr r3, =0xff200000
	mov r8, #5
bclremplir:
	cmp r2, #10
	bhs finremplir
	str r1, [r3]
	mov r1, r1, lsl #1
	add r1, r1, #1
	add r2, r2, #1
	bl waitn
	b bclremplir
finremplir:
	str r1, [r3]
	adr r3, cuve_pleine
	mov r1, #1
	strb r1, [r3]
	ldmfd sp !, {r1-r3, r8, pc}

vider:
	stmfd sp !, {r1, r3, r8, lr}
	ldr r1, =0b1111111111
	ldr r3, =0xff200000
	mov r8, #5
bclvider:
	cmp r1, #0
	beq finvider
	str r1, [r3]
	mov r1, r1, lsr #1
	bl waitn
	b bclvider
finvider:
	str r1, [r3]
	adr r3, cuve_pleine
	strb r1, [r3]
	ldmfd sp !, {r1, r3, r8, pc}

afficher_temperature:
	stmfd sp !, {r2-r5, lr}
	ldr r2, =0xff200030
	adr r3, nombres
	ldrb r4, [r3, r1]
	ldrb r5, [r3]
	mov r4, r4, lsl #8
	add r4, r4, r5
	str r4, [r2]
	ldmfd sp !, {r2-r5, pc}

chauffer:
	stmfd sp !, {r1, r2, r8, lr}
	mov r2, r1
	mov r1, #0
	mov r8, #5
bclchauffer:
	cmp r1, r2
	bhi finchauffer
	bl afficher_temperature
	bl waitn
	add r1, r1, #1
	b bclchauffer
finchauffer:
	ldmfd sp !, {r1, r2, r8, pc}

_start:
	mov r1, #6
	bl chauffer
	