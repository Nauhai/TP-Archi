.global _start
_start:
	mov r0, #0
	
bcl:
	add r2, r0, #1
	mul r3, r2, r2
	cmp r3, r1
	bhi fin
	add r0, r0, #1
	b bcl
fin: