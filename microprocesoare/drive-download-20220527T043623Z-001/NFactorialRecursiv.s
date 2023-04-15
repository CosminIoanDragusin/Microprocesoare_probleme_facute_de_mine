.data

	mesajIntroducetiN: .asciiz "Introduceti n: "
	mesajFactorialulEste: .asciiz "Factorialul este: "

	.align 4
	
	n: .space 4
	nFactorial: .space 4
	
.text

	puts mesajIntroducetiN

    li $v0,5
	syscall
	la $t0,n
	sw $v0,($t0)
	
	# INAINTE DE APEL
	subu $sp,$sp,12 # a0, fp, ra = 3 * 4B = 12B
	sw $ra,8($sp) # PUSH $ra
	sw $fp,4($sp) #PUSH $fp - indicatorul de cadru de stiva
	move $a0,$v0 # $a0 = n
	addu $fp,$sp,12
	# --------------
	
	jal Factorial
	
	# DUPA APEL
	addu $sp,$sp,12
	# --------------
	
	la $t0,nFactorial
	sw $v1,($t0)
	
afisare:
	
	lw $a0,($t0)
	li $v0,1
	syscall
	
sfarsit:
	li $v0,10
	syscall
	
#primeste in $a0 pe n
#returneaza in $v1 n!
Factorial:
	
	subu $sp,$sp,12
	sw $ra,8($sp)
	sw $fp,4($sp)
	sw $a0,($sp)
	addu $fp,$fp,12
	
	# pun in $v1, valoarea lui n, cu care vine din apelul precedent
	lw $v1,($sp)
	
	bgtz $v1,continua
	li $v1,1
	j iesireFunctie
	
continua:
	
	# in $a0 - urmatoarea valoare a lui n, adica n--
	lw $a0,($sp)
	addi $a0,$a0,-1 # n--
	jal Factorial
	
	lw $a0,($sp)
	mul $v1,$v1,$a0 # n *(n-1)
	
iesireFunctie:
	
	lw $ra,8($sp)
	lw $fp,4($sp)
	addu $sp,$sp,12
	
	jr $ra
	