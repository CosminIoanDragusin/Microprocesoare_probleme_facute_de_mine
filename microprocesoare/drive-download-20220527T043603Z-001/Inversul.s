.data

	Prompt: .asciiz "Dati un numar intreg: "
	PrintFormat: .asciiz "Valoarea Inversa=%d\n\n"
	MesajNegativ: .asciiz "Numarul e negativ\n"

.align 2

	PrintfPar: .word PrintFormat
	PrintfValue: .space 4
	PrintfNeg: .word MesajNegativ

.text
.global main

main:
	addi r1, r0, Prompt
	jal InputUnsigned ; in r1 se va afla numarul citit de la tastatura
	addi r2, r1, 0 ; r2 ¬ r1
	slt r3, r2, 0 ; se verifica daca numarul citit este negativ
	bnez r3, NumarNegativ ; daca s-a tastat un numar negativ se va afisa un mesaj corespunzator urmat
	; de reintroducerea unei valori pozitive
	; de la intrare

	add r3, r0, r0 ; initializarea noului numar
	add r6, r0, 10 ; in r6 <- 10, baza sistemului zecimal
	add r4, r1, r0 ; transfera în r4 numarul citit pentru a opera asupra lui

loop:
	add r7, r4, r0 ; r7 ¬ r4 (salvare temporara a numarului ramas dupa eliminarea a cate unei cifre)
	div r4, r4, r6 ; r4 ¬ r4 / 10 (câtul împartirii)
	multu r5, r4, r6 ; secventa necesara pentru preluarea restului împartirii
	sub r5, r7, r5 ; r5 ¬ r4–[(r4/10)]*10 (restul împartirii – cifra curenta)
	multu r3, r3, r6 ; cifra curenta avanseaza în cadrul numarului nou format
	add r3, r3, r5 ; se adauga ultima cifra a numarului initial la numarul nou creat
	bnez r4, loop ; numarul initial mai contine cifre (r410) ? Daca da se reia algoritmul cu urmatoarea cifra.
	add r1, r3, r0 ; in r1 se afla numarul inversat tocmai calculat

Afisare:
	sw PrintfValue, r1 ; salvare parametrii afisare pentru numarul inversat
	addi r14, r0, PrintfPar
	trap 5 ; afisarea valorii întregi a numarului inversat
	j Finish ; salt peste mesaj de eroare

NumarNegativ:
	addi r14, r0, PrintfNeg ; salvare parametrii afisare pentru mesaj de eroare
	trap 5 ; afisare mesaj eroare ‘Dimensiune sir negativa !’
	j main ; reluare program cu reintroducerea unui numar pozitiv

Finish:
	trap 0 ; încheiere program