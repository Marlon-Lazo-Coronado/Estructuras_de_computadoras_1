.data
array: .word 1,0xEFFFFFFF,-1 # SE CREA EL ARRAY DE NUMEROS A[0]
array0: .space 40  # SE CREA EL ARRAY DE NUMEROS
array1: .space 40 # SE CREA EL ARRAY DE NUMEROS
M1: .asciiz "Bien! "
M2: .asciiz "mal!"
x: .word 0x7FFFFFFF
y: .word 1

.text
.globl main

main:

	#la $a0, array     #Obtengo la direccion A[0]
	#la $v0, array0    #Guardo en $v0 la direccion de array0
	#la $v1, array1

	#ori $t1, $0, 0x5FFFFFFF
	#ori $t2, $0, 0x3FFFFFFF
	
	la $a0, array     #Obtengo la direccion A[0]
	
	and $t7, $t7, $0  #Limpiamos temporal
	and $t0, $t0, $0  #Limpiamos suma
	and $t1, $t1, $0  #i del contador
	  



promedio:
	or $t2, $0, $a0   #Direccion A[0] 
	add $t2, $t2, $t1    #A[0]+i
	lw $t3, 0($t2)       #Gardamos A[0]+i en $t3
	#slt $t7, $t3, $0
	#bne $t7,$0, fin
	#Verificacion de desborde o no desborde
	addu $v0,$t0, $t3                     #$t0=suma, $t2=A[0]+i
	
	###xor $t8, $t0,$t3                    #Chequemos signos diferentes
	###slt $t8, $t8, $zero                  #$t3=1 si son de signos diferentes
	###bne $t8,$zero, NoDesborde            #$t2 y $t1 signos diferentes, no desborde
	
	#xor $t8, $v0, $t3                    #comparar signos de suma
	
	slt $t8, $v0, $zero                    #$t3 es negativo si signos de suma son diferentes, $t3=1 si seigno de sumas es diferentes
	bne  $t8, $zero, desborde
	#slt $t8, $t8, $zero                    #$t3 es negativo si signos de suma son diferentes, $t3=1 si seigno de sumas es diferentes
	#bne  $t8, $zero, desborde              #Todos los 3 signos son diferentes, vamos a desborde
	#Fin de la verificacion
	
	
	NoDesborde:
	move $t7, $v0
	move $t8, $a0
	la $a0, M1     # SE IMPRIME UNA COMA
	li $v0, 4   
	syscall
	move $v0, $t7 
	move $a0, $t8
	
	addu $t0,$t0, $t3
	addi $t1, $t1, 4
	j promedio
	
	
	desborde:
	
	move $t7, $v0
	move $t8, $a0
	la $a0, M2     # SE IMPRIME UNA COMA
	li $v0, 4    
	syscall
	move $v0, $t7 
	move $a0, $t8
	
	addu $t0,$t0, $t3
	addi $t1, $t1, 4
	#j promedio

	
	fin:
	
	














