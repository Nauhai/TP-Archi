.global _start
_start:
	mov r0, #1
	mov r2, #0

bcl:
	cmp r2, r1
	bhs fin
	mov r0, r0, lsl #1
	add r2, r2, #1
	b bcl
fin: