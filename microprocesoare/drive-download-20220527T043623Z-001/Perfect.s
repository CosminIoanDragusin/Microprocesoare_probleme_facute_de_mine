#Scrieţi un program care citeşte de la tastatură un număr natural n şi verifică dacă este
#perfect (este egal cu suma divizorilor săi strict mai mici decât numărul)

.data

mesajCitireN: .asciiz "Introduceti n: "
mesajEstePerfect: .asciiz "Este perfect! "
mesajNuEstePerfect: .asciiz "Nu este perefect! "

.text

	la $a0,mesajCitireN
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0 #n

	li $t1,0 #suma divizorilor
	li $t2,1
	
calculeazaSuma:

	div $t0,$t2
	mfhi $t3
	beqz $t3,gasitDivizor
	addi $t2,$t2,1
	slt $t4,$t2,$t0
	bnez $t4,calculeazaSuma
	j compara
	
gasitDivizor:
	
	add $t1,$t1,$t2
	addi $t2,$t2,1
	slt $t4,$t2,$t0
	bnez $t4,calculeazaSuma

compara:
	
	seq $t5,$t0,$t1
	bnez $t5,ePerfect
	j nuEstePerfect
	
ePerfect:

	la $a0,mesajEstePerfect
	li $v0,4
	syscall
	j sfarsit

nuEstePerfect:
	
	la $a0,mesajNuEstePerfect
	li $v0,4
	syscall
	
sfarsit:

	li $v0,10
	syscall
	