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
Temperatura: .word 45
Conver: .word 1

.text
.globl main

main:

	la $t7,Temperatura
	la $t8,Conver
	lw $a0,0($t7)
	lw $a1,0($t8)
	jal ConverT
	
	j final
	
ConverT:
	#Evaluamos si en $a1 se ingreso un numero diferente a 0 o 1.
	addi $t6,$0,2
	slt $t6,$a1,$t6
	beq $t6,$0,end
	addi $t6,$t0,0
	slt $t6,$a1,$t6
	addi $t7,$0,1
	beq $t6,$t7,end
	
	move $t7,$a0  #Guardamos #a0
	beq $a1,$0, CF
	#Pasamos de Fahrenheit a Celsius
	addi $t0,$0,32
	sub $t1,$a0,$t0
	addi $t0,$0,5
	mul $t1,$t1,$t0
	addi $t0,$0,9
	div $t1,$t1,$t0
	mflo $v0         #leemos el cociente
	mfhi $v1         #Leemos el reciduo
	move $a0,$t7
	
	CF:
	#Reescribimos la expresion como (1/5)*(9*C+5*32)
	addi $t0,$0,9
	mul $t1,$a0,$t0
	addi $t1,$t1,160
	addi $t0,$0,5
	div $t1,$t0
	
	mflo $v0         #leemos el reciduo
	mfhi $v1         #Leemos el reciduo
	move $a0,$t7
	
	end:
	jr $ra

final:













