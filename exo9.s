.global _start

tab: .byte 0xc2, 0b11000011, 9, 252, 0xFF, 0x81, 0b10, 63, 0b11000101, 219
fintab:
.align

palindrome:
	@ entree = r1
	@ retour = r0
	stmfd sp !, {r1-r3}
	mov r0, #0
	mov r2, #0
	mov r3, #0
bclpal:
	cmp r3, #4
	bhs finpal
	mov r2, r2, lsl #1
	movs r1, r1, lsr #1
	adc r2, r2, #0
	add r3, r3, #1
	b bclpal
finpal:
	cmp r1, r2
	moveq r0, #1
	ldmfd sp !, {r1-r3}
	mov pc, lr

_start:
	adr r5, tab
	adr r6, fintab
	mov r2, #0
bcl:
	cmp r5, r6
	bhs fin
	ldrb r1, [r5], #1
	bl palindrome
	add r2, r2, r0
	b bcl
fin:
	