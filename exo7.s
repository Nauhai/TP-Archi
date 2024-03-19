.global _start

message: .asciz "DTCXQXQWURQWXGBRCUUGTCNGZGTEKEGUWKXCPV"
.align
dec: .word 2

_start:
	adr r0, message
	adr r1, dec
	ldrb r1, [r1]

bcl:
	ldrb r2, [r0]
	cmp r2, #0
	beq fin
	sub r2, r2, r1
	cmp r2, #65
	addlt r2, r2, #26
	strb r2, [r0]
	add r0, r0, #1
	b bcl
fin: