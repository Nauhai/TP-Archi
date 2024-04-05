.global _start

chaine1: .asciz "JLkd2nj345bnzApdd0j9"
.align
chaine2: .fill 255, 1
.align

_start:
	adr r1, chaine1
	adr r2, chaine2

bcl:
	ldrb r3, [r1], #1
	cmp r3, #0
	beq fin
	cmp r3, #'A'
	blo nombre
	cmp r3, #'z'
	bhi nombre
	cmp r3, #'Z'
	bls lettre
	cmp r3, #'a'
	blo nombre
lettre:
	strb r3, [r2], #1
nombre:
	b bcl
fin: