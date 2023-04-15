.data

stringIntroducetiNumarul: .asciiz "Introduceti numarul: "
stringDivizoriiSunt: .asciiz "Divizorii sunt: "
caracterSpatiu:  .asciiz " "

.text

	#afiseaza "Introduceti numarul: "
	la $a0,stringIntroducetiNumarul
	li $v0,4
	syscall

	li $v0,5 #citeste un intreg si il pune in $v0
	syscall
	move $t0,$v0
	
	#afiseaza "Divizorii sunt: "
	la $a0,stringDivizoriiSunt
	li $v0,4
	syscall
	
	#afiseaza 1, primul numar
	li $a0,1
	li $v0,1
	syscall
	
	#impartim pe rand, numarul citit de la tastatura, la numerele la $t1
	#initializam $t1 cu 2
	li $t1,2
	
repeta:
	div $t0,$t1
	mfhi $t3
	beqz $t3,afisareDivizori #daca restul e 0, inseamna ca $t1 e un divizor
	addi $t1,$t1,1 #incrementam $t1
	ble $t1,$t0,repeta #cat timp $t1 e mai mic egal cu numarul citit de la tastatura
	j sfarsit

afisareDivizori:
	#afiseaza un spatiu
	la $a0,caracterSpatiu
	li $v0,4
	syscall
	
	#afiseaza divizorul
	move $a0,$t1
	li $v0,1
	syscall
	
	addi $t1,$t1,1
	j repeta
	
sfarsit:
	li $v0,10
	syscall
	