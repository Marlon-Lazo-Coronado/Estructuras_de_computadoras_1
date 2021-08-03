.data 
	separador: .asciiz  ","
	nuevalinia: .asciiz " \n \n"
	espacio: .asciiz " "
	Mensaje1: .asciiz "Leer una frase\n"
	Mensaje2: .asciiz "CAMBIAR TODO A MAYÚSCULAS\n"
	Mensaje3: .asciiz "cambiar todo a minúsculas\n"
	
	Mens.Entrada: .space 100  # zona para los caracteres
	
.text 
	main:
	
	#Imprimimos mensajes del menu.
		li $v0, 4           # código de imprimir cadena
		la $a0, Mensaje1    # dirección de la cadena
		syscall             # Llamada al sistema 
		
		li $v0, 4
		la $a0, Mensaje2
		syscall
		
		li $v0, 4               #
		la $a0, Mensaje3
		syscall
		
		li $v0, 8                #Pido el arreglo
		la $a0, Mens.Entrada
		li $a1, 100
		syscall
		
		
		#li $v0, 4                #Imprimo el arreglo sin procesar
		#la $a0, Mens.Entrada
		#syscall
		
		
		
		#li $v0, 4		#Mediante este codigo puedo imprimer 
		#la $a0, Mensaje3	#el array por partes
		#addi $a0, $a0, 6
		#syscall
		
	

#Con este he logrado modificar la primera letra
#Paraque sea mayuscula pero no las demas

#opcion3:
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
	j End3
	Inc3:
	addi $t0, $t0, 1
	j Loop3
	End3:
	li $v0, 4		#Mediante este codigo puedo imprimer 
	la $a0, 0($a0)	        #el array por partes
	syscall
	#jr $ra




#Si convierte todas las letras a Mayusculas
#opcion4:
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
	#jr $ra
			
#Si convierte todas las letras a minusculas	
#opcion5:
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
	#jr $ra		


#No he logrado terminar para que combierta la primera
#letra de cada palabra en mayuscula.
#opcion2:
	addi $t3, $0, 'Z'
	add $t0, $0, $a0
	
	Loop2:
	lbu $t1, 0($t0)
	beq $t1, $0, End2
	sltiu $t2, $t1, 'A'
	bne $t2, $0, Inc2
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc2
	sb $t1, 0($t0)
	addi $t0, $t0, 1
	j Loop2
	Inc2:
	addi $t0, $t0, 1
	j LoopAux
	
	LoopAux:
	beq $t1, $0, End2
	sltiu $t2, $t1, 'A'
	bne $t2, $0, IncAux
	sltu $t2, $t3, $t1
	bne $t2, $0, IncAux
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	addi $t0, $t0, 1
	IncAux:
	j Loop2
	
	End2:
	li $v0, 4		#Mediante este codigo puedo imprimer 
	la $a0, 0($a0)	        #el array por partes
	syscall
	#jr $ra	

