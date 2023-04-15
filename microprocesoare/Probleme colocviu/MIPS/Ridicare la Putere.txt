.data
n: 
.asciiz "\tIntroduceti numarul:"
k: 
.asciiz "\tIntroduceti puterea:"
p: 
.asciiz "\t Ridicarea este: "

.text

la $a0, n
li $v0, 4
syscall
li $v0, 5
syscall
move $t0, $v0
la $a0, k
li $v0,4
syscall
li $v0, 5
syscall
move $t1, $v0 #t1 avem k
li $t2, 1 # produsul ridicarii la putere
loop:
	mul $t2, $t2, $t0
	sub $t1, $t1, 1
bnez $t1,loop  #cat timp k!=0 repete
	la $a0, p
	li $v0, 4
	syscall
	puti $t2
	done
	