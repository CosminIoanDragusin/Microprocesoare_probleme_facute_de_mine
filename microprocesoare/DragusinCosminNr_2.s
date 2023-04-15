.data
citire:. asciiz "Dati un numar intreg="
e_perfect: .asciiz "Nr e perfect"
nu_e_perfect: .asciiz "Nr nu e perfect"
negativ: .asciiz "Introduceti numar pozitiv!"

.align 2
print_perfect: .word e_perfect
print_nu_perfect: .word nu_e_perfect
print_negativ: .word negativ
PrintfValue:.space 4

.text
.global main
main:
addi r1,r0,citire
jal InputUnsigned

addi r2,r1,0  ;numarul nostru
slt r3,r2,0
bnez r3,NumarNegativ

add  r3,r0,r0   ;suma divizorilor
addi r4,r0,1    ;primul divizor

calculeazaSuma:
div r5,r2,r4         ;se imparte r2(nr) la r4(divizor) se obtine catul
multu r6,r5,r4       ;se obtine in r6 restul
beqz r6,gasitDivizor ;se verifica daca restul e 0
addi r4,r4,1          ;urmatorul divizor
slt r7,r4,r2            ;compara daca r4(divizorul curent) a depasit r2(nr)
bnez r7,calculeazaSuma   ;daca sare inapoi la suma

gasitDivizor:   
add r3,r3,r4       ;aduna divizorul sa suma
addi r4,r4,1        ;trece la urmatorul divizpr
slt r7,r4,r2          ;comparam daca numarul e depasit de divizor
bnez r7,calculeazaSuma  ;mergem la suma
j compara                ;merge la compara 

compara:
seq r8,r2,r3         ;daca suma e egala cu nr
bnez r8,ePerfect      ;e egala se trece la perfect
j nuPerfect            ;se trece la nu e perfect
 
ePerfect:
addi r14,r0,print_perfect
trap 5
j gata

nuPerfect:
addi r14,r0,print_nu_perfect
trap 5
j gata

NumarNegativ:
addi r14,r0,print_negativ
trap 5
j main

gata:
trap 0

