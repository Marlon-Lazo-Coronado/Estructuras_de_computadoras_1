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
M1: .asciiz "Bien! "
M2: .asciiz "\n"
Base: .word 24
Altura: .word 5

.text
.globl main

main:

	la $a0,Base
	la $a1,Altura
	
	
	jal Volumen
	
	j final
	
Volumen:
	lw $t0,0($a0)    #Leemos los numeros
	lw $t1,0($a1)
	addi $t7,$0,3    #Guardamos un 3 para dividir
	
	multu $t1,$t0    #Multiplicamos bxh
	mflo $t0         #Leemos bits menos significativos
	divu $t0,$t7     #Dividemos por 3
	mflo $v0         #leemos el cociente
	mfhi $v1         #Leemos el reciduo
	
#imprimir v0 yv1
final:













