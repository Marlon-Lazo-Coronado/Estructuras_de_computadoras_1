#Universidad de Costa Rica
#Estructura de Computadoras Digitales I
#Marlon Lazo Coronado B43717
#Tarea #5


#Para este programa se asume que los registros inicialmente estan en cero, esto
#con la finalidad de no llenar mas el codigo limpiando los registro, aunque se esta
#muy conciente que los registros inicialmente tienen basura en computador real.

.data
#array: .word 1,0xEFFFFFFF,-1 # SE CREA EL ARRAY DE NUMEROS A[0]
#Base: .space 1  # SE CREA EL ARRAY DE NUMEROS
#Altura: .space 1 # SE CREA EL ARRAY DE NUMEROS
mensaje: .asciiz "La multiplicacion es: "
M2: .asciiz "\n"
M3: .asciiz "El cociente es: "
M4: .asciiz "El reciduo es: "
M5: .asciiz "Ingrese el dividendo: "
M6: .asciiz "Ingrese el divisor: "
#Divisor: .word 12     #Para probar
#Dividendo: .word 144 #Para probar

.text
.globl main

main:
	
	jal Dividir
	j salir
	
	#$t1 Reciduo
	#$t0 Divisor
	#$v0 Cociente
	
Dividir:
	#Solicitamos loa el dividendo y el divisor
	la $a0, M5     # imprime mensaje
	li $v0, 4    
	syscall

	li $v0, 5      #Solicitamos el dividendo
	syscall
	move $t1,$v0
	
	la $a0, M6     # imprime mensaje
	li $v0, 4    
	syscall
	
	li $v0, 5      #Solicitamos el divisor
	syscall
	move $t0,$v0
	######################################################################
	
	###################COMENZAMOS CON LA DIVISION##########################
	addi $t9,$0,33 # n+1 iteraciones
	# Elegimos $s0 como reciduo, por lo que el resultado se espresara como $t1=cociente y $s0=reciduo
	# Para restablecer el cociente usamos la variable $s1 para amlmacenar
	move $t6,$s0 #Movemos $s0 solo para seguir la convecion de no modificarlo aunque ahorita no tiene nada.
	loop1:
	beq $t9,$0, Fin_Iteracion #Terminamos despues de 33 iteraciones.
	
	#Hacemos la resta
	subu $t2,$s0,$t0  #Hacemos la resta en $t2
	slt $t3,$t2,$0
	beq $t3,$0,positivo
	#La resta es negativa
	andi $t3,$t1,0x80000000 #tomamos el bit mas significativo del dividendo
	srl $t3,$t3,31          #lo movemos a la posisicion menos significativa.
	sll $s0,$s0,1           #Desplazamos el reciduo 1 espacio a la izquierda
	sll $t1,$t1,1           #Desplazamos el cociente 1 espacio a la izquierda
	or $s0,$s0,$t3          #Colocamos el bit
	sub $t9,$t9,1           #Restamos al contador
	j loop1
	
	#La resta es positiva
	positivo:
	move $s0,$t2            #No modificamos el cociente, por eso solo copiamos la resta en el reciduo
	andi $t3,$t1,0x80000000 #tomamos el bit mas significativo del dividendo
	srl $t3,$t3,31          #lo movemos a la posisicion menos significativa.
	sll $s0,$s0,1           #Desplazamos el cociente 1 espacio a la izquierda
	sll $t1,$t1,1           #Desplazamos el reciduo 1 espacio a la izquierda
	or $s0,$s0,$t3          #Colocamos el bit
	ori $t1,$t1,0x00000001
	sub $t9,$t9,1           #Restamos al contador
	j loop1

	Fin_Iteracion:
	srl $s0,$s0,1
	#Imprimimos resultados
	la $a0, M3     # imprime mensaje
	li $v0, 4    
	syscall
	
	move $a0,$t1
	li $v0, 1    
	syscall
	
	la $a0, M2     # imprime mensaje
	li $v0, 4    
	syscall
	
	la $a0, M4     # imprime mensaje
	li $v0, 4    
	syscall
	
	move $a0,$s0
	li $v0, 1    
	syscall
	
	#Devolvemos el cociente en $v0 y el reciduo en $v1
	move $v0,$t1
	move $v1,$s0
	#Restauramos el registro salvado
	move $s0,$t6
	
	jr $ra
	
	
salir:
