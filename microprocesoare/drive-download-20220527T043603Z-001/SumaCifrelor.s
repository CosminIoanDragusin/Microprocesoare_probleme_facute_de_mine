.data

	Prompt: .asciiz "Dati un numar intreg: "
	PrintFormat: .asciiz "Suma este = %d\n\n"

.align 2

	PrintfPar: .word PrintFormat
	PrintfValue: .space 4

.text
.global main

main:
	addi r1, r0, Prompt
	jal InputUnsigned ; r1 = n
	addi r2, r1, 0 ; r2 = n
	addi r3, r0, 0 ; r3 = 0, adica suma
	addi r4, r0, 10 ; constanta 10, ca sa putem face %10 sau /10

loop:
	
	div r5, r2, r4 ; r5 <- n / 10
	multu r5, r5, r4 ; r5 <- n / 10 * 10
	sub r5, r2, r5 ; r5 <- n - n / 10 * 10, adica ultima cifra
	add r3,r3,r5 ; suma += ultima cifra
	div r2,r2,r4 ; n <- n / 10, adica taiem ultima cifra
	bnez r2, loop

Afisare:
	sw PrintfValue, r3 ; salvare suma in memorie
	addi r14, r0, PrintfPar
	trap 5 ; afisarea valorii întregi a numarului inversat

Finish:
	trap 0 ; încheiere program