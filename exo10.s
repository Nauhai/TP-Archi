.global _start

blinker:
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "     o          "
  .ascii "    ooo         "
  .ascii "     o          "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "
  .ascii "                "

population: .fill 16*16, 1, 0
.align


tabvois: .byte -17, -16, -15, -1, 1, 15, 16, 17
.align

voisines:
	@ entree: r1 = pointeur sur cellule
	stmfd sp !, {r1-r5, lr}
	mov r0, #0
	adr r2, tabvois
	mov r3, #0
bclvois:
	cmp r3, #8
	bhs finvois
	ldrsb r4, [r2, r3]
	ldrb r5, [r1, r4]
	cmp r5, #'o'
	addeq r0, r0, #1
	add r3, r3, #1
	b bclvois
finvois:
	ldmfd sp !, {r1-r5, pc}

	
calcul:
	@ entree: r1 = pointeur sur grille
	stmfd sp !, {r1-r6, lr}
	mov r2, r1
	mov r3, #17
	adr r4, population
	mov r5, #0
bclcalc1:
	cmp r5, #14
	bhs fincalc1
	mov r6, #0
bclcalc2:
	cmp r6, #14
	bhs fincalc2
	add r1, r2, r3
	bl voisines
	strb r0, [r4, r3]
	add r3, r3, #1
	add r6, r6, #1
	b bclcalc2 
fincalc2:
	add r3, r3, #2
	add r5, r5, #1
	b bclcalc1
fincalc1:
	ldmfd sp !, {r1-r6, pc}


generation:
	@ entree: r1 = pointeur sur grille
	stmfd sp !, {r2-r8, lr}
	adr r2, population
	bl calcul
	mov r3, #17
	mov r4, #0
bclgen1:
	cmp r4, #14
	bhi fingen1
	mov r5, #0
bclgen2:
	cmp r5, #14
	bhi fingen2
	ldrb r6, [r1, r3]
	ldrb r7, [r2, r3]
	cmp r6, #'o'
	bne morte
vivante:
	cmp r7, #2
	beq finmodif
	cmp r7, #3
	beq finmodif
	mov r8, #' '
	strb r8, [r1, r3]
	b finmodif
morte:
	cmp r7, #3
	bne finmodif
	mov r8, #'o'
	strb r8, [r1, r3]
finmodif:
	add r3, r3, #1
	add r5, r5, #1
	b bclgen2
fingen2:
	add r3, r3, #2
	add r4, r4, #1
	b bclgen1
fingen1:
	ldmfd sp !, {r2-r8, pc}


_start:
	adr r1, blinker
bcl:
	bl generation
	b bcl