.data 
	separador: .asciiz  ","
	nuevalinia: .asciiz " \n \n"
	espacio: .asciiz " "
	Mensaje1: .asciiz "Elija una opcion\n"
	Mensaje2: .asciiz "(1) Leer una frase\n"
	Mensaje3: .asciiz "(2) Primera Letra De Cada Palabra En Mayúscula Las Demás En Minúscula \n"
	Mensaje4: .asciiz "(3) Primera letra en mayúscula y todas las demás en minúscula\n"
	Mensaje5: .asciiz "(4) CAMBIAR TODO A MAYÚSCULAS\n"
	Mensaje6: .asciiz "(5) cambiar todo a minúsculas\n"
	Mensaje7: .asciiz "Este es el mensaje de prueva\n"
	Mensaje8: .asciiz "Ingrese el mensaje que desea probar\n"
	Mensaje9: .asciiz "Vuelva a seleccionar una opcion para el texto que acaba de ingresar\n"	
	Mens.Entrada: .space 100  # Espacio para los caracteres
	
.text 
	main:
	
	#Imprimimos mensajes del menu.
	
	jal Mensajes
	
	
		
		#Aqui comienza la opcion 1
		addi $t6, $0, 1
		bne $t6, $t7, FinOp1
		
		li $v0, 4
		and $a0, $0, $a0 #Borramos el mensaje de $a0 para usar syscall en otro texto
		la $a0, Mensaje8
		syscall
		
		
		li $v0, 8                #Pido el arreglo
		la $a0, Mens.Entrada
		li $a1, 100
		syscall
		
		#Mensaje para volver a pedir el numero
		or $t5, $0, $a0
		and $a0, $0, $a0
		li $v0, 4
		la $a0, Mensaje9
		syscall
		or $a0, $0, $t5
		
		
		#Vovemos a solicitar un numero
		li $v0, 5
		syscall
	
		#Movemos el dato para seguir utilizando $V0
		move $t7, $v0
		
		
		#Esta es la accion que se realiza si se elije laopcion 1
		jal SubfuncionOpcion1
		#Aqui termina la accion de la opcion 1
		j main
		FinOp1:

	SubfuncionOpcion1:
		
		#Aqui comienza la opcion 2
		addi $t6, $0, 2
		bne $t6, $t7 FinOp2
		jal opcion2
		j main
		FinOp2:
		
		#Aqui comienza la opcion 3
		addi $t6, $0, 3
		bne $t6, $t7 FinOp3
		jal opcion3
		j main
		FinOp3:
		
		#Aqui comienza la opcion 4
		addi $t6, $0, 4
		bne $t6, $t7 FinOp4
		jal opcion4
		j main
		FinOp4:
		
		#Aqui comienza la opcion 5
		addi $t6, $0, 5
		bne $t6, $t7 FinOp5
		jal opcion5
		j main
		FinOp5:
		
		j main
				
		.end main			
										
	
	
	
Mensajes:

		li $v0, 4           # código de imprimir cadena
		la $a0, Mensaje1    # dirección de la cadena
		syscall             # Llamada al sistema 
		
		li $v0, 4
		la $a0, Mensaje2
		syscall
		
		li $v0, 4               #
		la $a0, Mensaje3
		syscall
		
		li $v0, 4               #
		la $a0, Mensaje4
		syscall
		
		li $v0, 4               #
		la $a0, Mensaje5
		syscall
		
		li $v0, 4               #
		la $a0, Mensaje6
		syscall
		
		#li $v0, 4               #
		la $a0, Mensaje7
		#syscall
		
		
		#li $v0, 4                #Imprimo el arreglo sin procesar
		#la $a0, Mens.Entrada
		#syscall
		
		#li $v0, 4		#Mediante este codigo puedo imprimer 
		#la $a0, Mensaje3	#el array por partes
		#addi $a0, $a0, 6
		#syscall
		
		
		
		#Solicitamos el numero de opcion
		li $v0, 5
		syscall
		#Movemos el dato para seguir utilizando $V0
		move $t7, $v0
		
		#Ahora establecemos las condiciones que se ejecutaran con $t7
		jr $ra
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
#################################################################################
#Con este he logrado modificar la primera letra
#Paraque sea mayuscula pero no las demas

opcion3:
	addi $t3, $0, 'z'
	add $t0, $0, $a0
	Loop3:
	lbu $t1, 0($t0)
	beq $t1, $0, End3
	sltiu $t2, $t1, 'a'
	bne $t2, $0, Inc3
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc3
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	addi $t3, $0, 'Z'
	addi $t0, $t0, 1
	j Loop3A
	Inc3:
	addi $t0, $t0, 1
	j Loop3
	
	Loop3A:
	lbu $t1, 0($t0)
	beq $t1, $0, End3
	sltiu $t2, $t1, 'A'
	bne $t2, $0, Inc3A
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc3A
	ori $t1, $t1, 0x20
	sb $t1, 0($t0)
	Inc3A:
	addi $t0, $t0, 1
	j Loop3A
	
	End3:
	li $v0, 4		#Mediante este codigo puedo imprimer 
	la $a0, 0($a0)	        #el array por partes
	syscall
	jr $ra



#######################################################################################
#Si convierte todas las letras a Mayusculas
opcion4:
	addi $t3, $0, 'z'
	add $t0, $0, $a0
	Loop4:
	lbu $t1, 0($t0)
	beq $t1, $0, End4
	sltiu $t2, $t1, 'a'
	bne $t2, $0, Inc4
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc4
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	Inc4:
	addi $t0, $t0, 1
	j Loop4
	End4:
	li $v0, 4		#Mediante este codigo puedo imprimer 
	la $a0, 0($a0)	        #el array por partes
	syscall
	jr $ra


#################################################################################33
#Si convierte todas las letras a minusculas	
opcion5:
	addi $t3, $0, 'Z'
	add $t0, $0, $a0
	Loop5:
	lbu $t1, 0($t0)
	beq $t1, $0, End5
	sltiu $t2, $t1, 'A'
	bne $t2, $0, Inc5
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc5
	ori $t1, $t1, 0x20
	sb $t1, 0($t0)
	Inc5:
	addi $t0, $t0, 1
	j Loop5
	End5:
	li $v0, 4		#Mediante este codigo puedo imprimer 
	la $a0, 0($a0)	        #el array por partes
	syscall
	jr $ra		


#No he logrado terminar para que combierta la primera
#letra de cada palabra en mayuscula.
opcion2:

	addi $t3, $0, 'z'
	add $t0, $0, $a0

	lbu $t1, 0($t0)
	beq $t1, $0, End2
	sltiu $t2, $t1, 'a'
	bne $t2, $0, Loop2
	sltu $t2, $t3, $t1
	bne $t2, $0, Loop2
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	addi $t0, $t0, 1





	addi $t3, $0, 'Z'
	#add $t0, $0, $a0
	
	#AQUI CONVIERTO EN MUNUSCULAS
	Loop2:
	addi $t3, $0, 'Z'
	lbu $t1, 0($t0)
	beq $t1, $0, End2
	sltiu $t2, $t1, 'A'
	bne $t2, $0, Espacio
	sltu $t2, $t3, $t1
	bne $t2, $0, Espacio
	ori $t1, $t1, 0x20
	sb $t1, 0($t0)
	addi $t0, $t0, 1
	j Loop2
	
	#AQUI COMBIENTO A MUYUSCULA
	Espacio:
	addi $t0, $t0, 1
	
	addi $t3, $0, 'z'
	lbu $t1, 0($t0)
	beq $t1, $0, End2
	sltiu $t2, $t1, 'a'
	bne $t2, $0, IncAux
	sltu $t2, $t3, $t1
	bne $t2, $0, IncAux
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	addi $t0, $t0, 1
	IncAux:
	j Loop2
	
	
	End2:
	li $v0, 4		
	la $a0, 0($a0)	       
	syscall
	jr $ra	

