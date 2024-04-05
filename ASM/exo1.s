.global _start
_start:
	mov r3, r1
	mov r4, r2

bcl:
	cmp r3, r4
	beq fin
	addhi r4, r4, r2
	addlo r3, r3, r1
	b bcl
fin:
	mov r0, r3