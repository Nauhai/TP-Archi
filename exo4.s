.global _start
_start:
	ldr r1, =0b111000101011
	mov r1, r1, lsr r3
	sub r4, r2, r3
	add r4, r4, #1
	mov r5, #1
	mov r5, r5, lsl r4
	sub r5, r5, #1
	and r0, r1, r5
