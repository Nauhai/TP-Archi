.global _start
_start:
	mov r2, #1
	mov r0, #0

bcl:
	cmp r2, r1
	bhs fin
	mov r2, r2, lsl #1
	add r0, r0, #1
	b bcl
fin: