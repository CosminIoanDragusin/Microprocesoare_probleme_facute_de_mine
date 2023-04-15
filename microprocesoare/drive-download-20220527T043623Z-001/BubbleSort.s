.data

	mesajIntroducetiN: .asciiz "n = "
	mesajIntroducetiNumerele: .asciiz "Introduceti numerele: "
	mesajVectorulSortatEste: .asciiz "Vectotul sortat este: "

	.align 2
	n: .space 4
	vector: .space 100

.text

	puts mesajIntroducetiN
	geti $a1 #citim n in $a1
	puts mesajIntroducetiNumerele
	la $t0,vector
	move $t1,$a1 #il copiem pe n in $t1

citesteNumerele:
	geti $v0 #citim un numar si il punem in $v0
	sw $v0,($t0) # salvam numarul in memorie
	addi $t1,$t1,-1
	addi $t0,$t0,4
	bgtz $t1,citesteNumerele
	
	jal BubbleSort
	
	puts mesajVectorulSortatEste
	la $t0,vector

afiseazaNumar:
	lw $a0,($t0)
	puti $a0
	putc ' '
	addi $t0,$t0,4
	addi $a1,$a1,-1
	bgtz $a1,afiseazaNumar
	
	done #echivalentul li $v0,10 + syscall

#primeste in $a1 pe n
BubbleSort:
	
	li $t1,1 #k = 1
	move $t2,$a1 #il copiem pe n in $t2
	
forDupaK:
	li $t3,0 #i = 0
	move $t4,$a1 #il copiem pe n in $t4
	addi $t4,$t4,-1 #$t4 = n - 1
	la $t0,vector

forDupaI:
	lw $t5,($t0) #$t5 = a[i]
	lw $t6,4($t0) #$t6 = a[i+1]
	sgt $t7,$t5,$t6 #a[i] > a[i+1]
	beqz $t7,continua

swap:
	sw $t6,($t0)
	sw $t5,4($t0)
	
continua:
	addi $t3,$t3,1 # i++
	addi $t0,$t0,4
	slt $t7,$t3,$t4 # daca i < n - 1
	bnez $t7,forDupaI
	
	addi $t1,$t1,1 # k++
	slt $t7,$t1,$t2 # daca k < n
	bnez $t7,forDupaK
	
	jr $ra
	