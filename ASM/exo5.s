.global _start

a: .byte 8
b: .byte 12
somme: .fill 1,1
.align

_start:
	adr r0, a
	adr r1, b
	adr r2, somme
	
	ldrb r0, [r0]
	ldrb r1, [r1]
	add r3, r0, r1
	strb r3, [r2]
	