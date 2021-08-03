#Universidad de Costa Rica
#Estructuras de Computadoras Digitales
#Marlon Lazo Coronado B43717
#Quiz #8 15/06/2020
#La funcion que se ha hecho calcula el volumen
# de una piremirerecibiendo en $a0 el area de
# la base y en $a1 la altura, devuelve en $v0
#el cociente del resultado y en $v1 el reciduo
#la funcion unicamente hace el calculo, no imprime
# esto pensando en que al momento de hacer la prueva
# de esta funcion se cuente con dicho codigo y asi
# no interferir con el tes.





.data
#array: .word 1,0xEFFFFFFF,-1 # SE CREA EL ARRAY DE NUMEROS A[0]
#Base: .space 1  # SE CREA EL ARRAY DE NUMEROS
#Altura: .space 1 # SE CREA EL ARRAY DE NUMEROS
M1: .asciiz ".FVC"
M2: .asciiz "\n"
a: .word 4
b1: .word 3
c: .word 7
.text
.globl main

main:

	la $t0,a
	la $t1,b1
	la $t2,c
	lw $a0,0($t0)
	lw $a1,0($t1)
	lw $a2,0($t2)
	jal ReglaD3
	
	j final
	
ReglaD3:
	move $t0,$a0
	move $t1,$a1
	move $t2,$a2
	mul $t8,$t1,$t2
	div $t9,$t8,$t0
	mflo $v0         #leemos el cociente
	mfhi $v1         #Leemos el reciduo
	jr $ra

final:













