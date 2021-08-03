#Universidad de Costa Rica
#Estructuras de computadores digitales I
#Tarea 1
#Grupo 2
#Marlon Javier Lazo Coronado B43717


.data 
	Mensaje1: .asciiz "\n\nIngrese los numero al los que quiere aplicar C( n , K )\n\n"
	Mensaje2: .asciiz "C( "
	Mensaje3: .asciiz " , "
	Mensaje4: .asciiz " ) = "
	Mensaje5: .asciiz "\n\n"
	
.text 
	main:
	#Imprimimos mensajes del menu y solicitamos la opcion a ejecutar
	
	jal Mensajes
	
	
	
	
	add $t2, $0, $a2
	and $t3, $t3, $0
	jal funcion
		
		move $a0, $t3
		li $v0, 1
		syscall
		
	
	
	
	
	
		
	j main
		
										
	
#Esta es la funcion que me imprime los mensajes y me solicita la opcion
	Mensajes:

		li $v0, 4           # Código de imprimir cadena
		la $a0, Mensaje1    # dirección de la cadena
		syscall             # Llamada al sistema 
		
		#Solicitamos n
		li $v0, 5
		syscall
		move $a1, $v0       #Movemos a los registros temporales
		
		#Solicitamos k
		li $v0, 5
		syscall
		move $a2, $v0       #Movemos a los registros temporales
		
	
		li $v0, 4           # Código de imprimir cadena
		la $a0, Mensaje2    # dirección de la cadena
		syscall
		
		li $v0, 1
		move $a0, $a1
		syscall
		
	
		li $v0, 4           # Código de imprimir cadena
		la $a0, Mensaje3    # dirección de la cadena
		syscall
		
		li $v0, 1
		move $a0, $a2
		syscall
		
		
		li $v0, 4           # Código de imprimir cadena
		la $a0, Mensaje4    # dirección de la cadena
		syscall
	
		
	
		#Ahora establecemos las condiciones que se ejecutaran con $t7
		jr $ra

	
#######################################################################################	
#Creamos la funcion
	funcion:
		
		addi $sp, $sp, -16
		sw $ra, 12($sp)
		sw $t2, 8($sp)         #Gardamos $sp
		sw $a1, 4($sp)         #Guardamos n
		sw $a2, 0($sp)         #Guardamos k
		
		bne  $a1, $a2, salto1
		addi $v0, $zero, 1
		addi $sp, $sp, 16
		jr $ra
		
		salto1:
		bne  $t2, $zero, salto2
		addi $v1, $zero, 1
		addi $sp, $sp, 16
		jr $ra
		
		salto2:
		bne  $a2, $zero, recursivo1
		addi $v1, $zero, 1
		addi $sp, $sp, 16
		jr $ra
		
		
		
#############AQUI COMIENZA EL PROBLEMAS DE LLAMAR Y SUMAR A LAS 2 FUNCIONES###########
		
		recursivo1:
		addi $a1, $a1, -1      #Tenemos k-1
		jal funcion
		
		lw $ra, 12($sp)        #Leemos $sp
		lw $t2, 8($sp)         #Leemos k-1
		lw $a1, 4($sp)         #Leemos n
		lw $a2, 0($sp)         #Leemos k
		addi $sp, $sp, 16      #Devolvemos #sp
		
		#Aqui sumo las 2 funciones
		add $t3, $t3, $v0
		
		
		recursivo2:
		#addi $a1, $a1, -1       #Tenemos n-1
		addi $t2, $t2, -1       #Tenemos k-1       
		jal funcion
		
		lw $ra, 12($sp)
		lw $t2, 8($sp)         #Leemos $sp
		lw $a1, 4($sp)         #Leemos n
		lw $a2, 0($sp)         #Leemos n
		addi $sp, $sp, 16      #Leemos n
		
		
		
		#Aqui sumo las 2 funciones
		add $t3, $t3, $v1
		
		
		
		jr $ra
		
				
