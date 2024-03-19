.global _start

grille:
	.ascii "  o  o          "
	.ascii "  ooo    ooo  o "
	.ascii "o o     ooo o   "
	.ascii "    o o o o o  o"
	.ascii "o    ooo o      "
	.ascii "       o oo     "
	.ascii "     ooo        "
	.ascii "       o  o o o "
	.ascii " o   o     o    "
	.ascii "o   oo ooo o    "
	.ascii "o     oo        "
	.ascii "     o   o     o"
	.ascii "oo o  o     o o "
	.ascii "    oo    o     "

population: .fill 16*16, 1, 0
.align

voisines:
	@ entree: r1 = pointeur sur cellule
	stmfd sp !, {r1-r8}
	mov r0, #0
	mov r3, #-1
	mov r7, #16
bclvois1:
	cmp r3, #1
	bgt finvois1
	mov r4, #-1
bclvois2:
	cmp r4, #1
	bgt finvois2
	mul r5, r4, r7
	add r5, r5, r1
	add r5, r5, r3
	cmp r5, r1
	beq saut
	ldrb r8, [r5]
	cmp r8, #'o'
	addeq r0, #1
saut:
	add r4, r4, #1
	b bclvois2
finvois2:
	add r3, r3, #1
	b bclvois1
finvois1:
	ldmfd sp !, {r1-r8}
	mov pc, lr
	
calcul:
	@ entree: r1 = pointeur sur grille
	stmfd sp !, {r1-r4}
	mov r2, r1
	mov r3, #17
	adr r4, population
bclcalc:
	cmp r3, #239
	add r1, r2, r3
	bhi fincalc
	bl voisines
	strb r0, [r4, r3]
	add r3, r3, #1
	b bclcalc
fincalc:
	ldmfd sp !, {r1-r4}
	mov pc, lr

_start:
	adr r1, grille
	bl calcul