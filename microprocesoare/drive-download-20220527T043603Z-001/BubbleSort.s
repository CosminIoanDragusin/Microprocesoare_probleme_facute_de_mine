;Sorteaza un vector prin metoda Bubble Sort

.data
	msg_citire_n: .asciiz "n = "
	msg_citire_elemente: .asciiz "\nIntroduceti elementele!\n"
	msg_afisare_vector: .asciiz "\nVectorul sortat este: "
	msg_citire_nr: .asciiz "nr = "
	msg_afisare_element: .asciiz "%d "

.align 2
	
	para_citire_elemente: .word msg_citire_elemente
	para_afisare_vector: .word msg_afisare_vector
    para_afisare_element: .word msg_afisare_element
    
	value_element: .space 4
    n: .space 4
    vector: .space 100

.text
.global main
main:
	addi r1, r0, msg_citire_n
	jal InputUnsigned
	sw n, r1

	addi r2, r1, 0 ;r2<-ct. elemente
	addi r14, r0, para_citire_elemente
	trap 5

	addi r3, r0, 0 ;r3<-ct. elemente
	addi r4, r0, vector ;r4<-deplasament

citeste:
	addi r1, r0, msg_citire_nr
	jal InputUnsigned
	sw (r4), r1
	addi r4, r4, 4
	addi r3, r3, 1
	slt r15, r3, r2
	bnez r15, citeste

	jal bubblesort

	addi r14, r0, para_afisare_vector
	trap 5

	addi r3, r0, 0 ;r3<-ct. elemente
	addi r4, r0, vector ;r4<-deplasament
afiseaza:
	lw r5, (r4)
	sw value_element, r5
	addi r14, r0, para_afisare_element
	trap 5
	addi r4, r4, 4
	addi r3, r3, 1
	slt r15, r3, r2
	bnez r15, afiseaza

sfarsit:
	trap 0


;Procedura Bubble Sort
bubblesort:
	addi r6, r0, 1 ;k<-1
	for1:
	addi r7, r0, 0 ;i<-0
	addi r8, r0, vector
	for2:
	lw r9, (r8)
	lw r10, 4(r8)
	sgt r15, r9, r10
	beqz r15,next
	interschimbare:
	sw (r8), r10
	sw 4(r8), r9
	next:
	addi r8, r8, 4
	addi r7, r7, 1
	addi r10, r2, -1
	slt r15, r7, r10
	bnez r15, for2

	addi r6, r6, 1
	slt r15, r6, r2
	bnez r15, for1

	jr r31