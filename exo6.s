.global _start

.equ N, 10
tab: .word 22, -12, 0, 9, 5, -1, 5, 43, 10, -10
.align

_start:
	adr r0, tab
	mov r1, #0		@ r1 = i
	mov r2, #N
	sub r2, r2, #1	@ r2 = N-1

for1:
	cmp r1, r2
	bge fin1
	mov r3, r1		@ r3 = minindex
	add r4, r1, #1	@ r4 = j
for2:
	cmp r4, #N
	bge fin2
	ldr r5, [r0, r4, lsl #2]	@ r5 = tab[j]
	ldr r6, [r0, r3, lsl #2]	@ r6 = tab[minindex]
	cmp r5, r6
	movlt r3, r4
	add r4, r4, #1
	b for2
fin2:
	cmp r3, r1
	beq finif
	ldr r7, [r0, r1, lsl #2]	@ r7 = temp = tab[i]
	ldr r8, [r0, r3, lsl #2]	@ r8 = tab[minindex]
	str r8, [r0, r1, lsl #2]	@ tab[i] = t[minindex]
	str r7, [r0, r3, lsl #2]	@ tab[minindex] = tmp
finif:
	add r1, r1, #1
	b for1
fin1:
	