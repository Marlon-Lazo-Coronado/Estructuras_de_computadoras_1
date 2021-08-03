#Universidad de Costa Rica
#Estructuras de computadores digitales I
#Tarea 1
#Grupo 2
#Marlon Javier Lazo Coronado B43717


.data 
	Mensaje1: .asciiz "##############Elija una opcion##################\n"
	Mensaje2: .asciiz "(1) Leer una frase\n"
	Mensaje3: .asciiz "(2) Primera Letra De Cada Palabra En Mayúscula Las Demás En Minúscula \n"
	Mensaje4: .asciiz "(3) Primera letra en mayúscula y todas las demás en minúscula\n"
	Mensaje5: .asciiz "(4) CAMBIAR TODO A MAYÚSCULAS\n"
	Mensaje6: .asciiz "(5) cambiar todo a minúsculas\n"
	Mensaje7: .asciiz "Este es el mensaje de prueva\n\n\n"
	Mensaje8: .asciiz "Ingrese el mensaje que desea probar\n"
	Mensaje9: .asciiz "Vuelva a seleccionar una opcion para el texto que acaba de ingresar\n"	
	Mens.Entrada: .space 100  # Espacio para los caracteres
	
.text 
	main:
	#Imprimimos mensajes del menu y solicitamos la opcion a ejecutar
	jal Mensajes
	#Utilizamos el registro $t6 para ir cargando los valores de las opciones y preguntar
	#jal Opcion1
	and $a0,$a0, $0
	#ESTA ES LA FUNCION DEL QUIZ!!!
	li $v0, 8                #Pido el arreglo al usuario
	la $a0, Mens.Entrada
	li $a1, 100
	syscall	
	
	
	jal Opcion6
	
	
	add $a0, $0, $v0		#Mediante este codigo puedo imprimer 
	li $v0, 1                       #el array por partes
	syscall
	
	add $a0, $0, $v1		#Mediante este codigo puedo imprimer 
	li $v0, 1                       #el array por partes
	syscall
	
		
	j main  # para probar la funcion del QUIZ
	SubfuncionOpcion1:
		
		#Aqui comienza la opcion 2
		addi $t6, $0, 2
		bne $t6, $t7 FinOp2
		jal opcion2
		FinOp2:
		
		#Aqui comienza la opcion 3
		addi $t6, $0, 3
		bne $t6, $t7 FinOp3
		jal opcion3
		FinOp3:
		
		#Aqui comienza la opcion 4
		addi $t6, $0, 4
		bne $t6, $t7 FinOp4
		jal opcion4
		FinOp4:
		
		#Aqui comienza la opcion 5
		addi $t6, $0, 5
		bne $t6, $t7 FinOp5
		jal opcion5
		FinOp5:
		
		
		j main
		.end main			
										
	
#Esta es la funcion que me imprime los mensajes y me solicita la opcion
	Mensajes:

		li $v0, 4           # código de imprimir cadena
		la $a0, Mensaje1    # dirección de la cadena
		syscall             # Llamada al sistema 
		
		li $v0, 4
		la $a0, Mensaje2
		syscall
		
		li $v0, 4               
		la $a0, Mensaje3
		syscall
		
		li $v0, 4               
		la $a0, Mensaje4
		syscall
		
		li $v0, 4               
		la $a0, Mensaje5
		syscall
		
		li $v0, 4               
		la $a0, Mensaje6
		syscall
		#Ocupo que el ultimo mensaje en $a0 sea el de prueva!         
		la $a0, Mensaje7
		
		#li $v0, 4		#Mediante este codigo puedo imprimer 
		#la $a0, Mensaje3	#el array por partes
		#addi $a0, $a0, 6
		#syscall
		
		#Solicitamos el numero de opcion
		#li $v0, 5
		#syscall
		#Movemos el dato para seguir utilizando $V0
		move $t7, $v0
		#Ahora establecemos las condiciones que se ejecutaran con $t7
		jr $ra

	
	
#######################################################################################	
#Aqui comienza la opcion 1, con esta opcion puedo cambiar el texto segun las opciones 2,3,4,5 
	Opcion1:
		#preguntamos se se cumple la opcion 1
		addi $t6, $0, 1
		bne $t6, $t7, FinOp1
		
		li $v0, 4
		and $a0, $0, $a0 #Borramos el mensaje de $a0 para usar syscall en otro texto 
		la $a0, Mensaje8 #ya que como se eligio la opcion 1 ya no ocupamos el mensaje
		syscall          #de prueva
		
		li $v0, 8                #Pido el arreglo al usuario
		la $a0, Mens.Entrada
		li $a1, 100
		syscall
		#Mensaje para volver a pedir el numero y aplicarle una opcion
		or $t5, $0, $a0    #Guardamos a $a0 porque syscall solo me funciona con ese
		and $a0, $0, $a0   #y ahorita ocupo imprimir el mensaje nuevo no la cadena
		li $v0, 4
		la $a0, Mensaje9
		syscall
		or $a0, $0, $t5   #Volvemos a cargar la cadena
		#Vovemos a solicitar un numero
		li $v0, 5
		syscall
		#Movemos el dato para seguir utilizando $V0
		#porque $t7 lo vamos a seguir usando en las comparaciones
		move $t7, $v0
		#Esta es la accion que se realiza si se elije laopcion 1
		jal SubfuncionOpcion1
		#Aqui termina la accion de la opcion 
		FinOp1:
		jr $ra
		j main
		
	
####################################################################################
#Este opcion convierte la primera letra de cada palabra en mayuscula

opcion2:
	
	#Este es el codigo para convertir todas a mayusculas
	addi $t3, $0, 'z'
	add $t0, $0, $a0
	Loop41:
	lbu $t1, 0($t0)
	beq $t1, $0, End41
	sltiu $t2, $t1, 'a'
	bne $t2, $0, Inc41
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc41
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	Inc41:
	addi $t0, $t0, 1
	j Loop41
	End41:

	#Este es el codigo que convierte a minusculas
	addi $t3, $0, 'Z'
	add $t0, $0, $a0
	addi $t0, $t0,1
	Loop51:
	lbu $t1, 0($t0)
	beq $t1, $0, End51
	sltiu $t2, $t1, 'A'
	bne $t2, $0, reglon #Si encuentro reglon salto dos espacios de memoria
	sltu $t2, $t3, $t1
	bne $t2, $0, reglon
	ori $t1, $t1, 0x20
	sb $t1, 0($t0)
	Inc51:
	addi $t0, $t0, 1
	j Loop51
	reglon:
	addi $t0, $t0, 2 #Sumo dos espacio de me moria para dejar la mayuscula despues del reglon
	j Loop51
	End51:
	li $v0, 4		
	la $a0, 0($a0)	  
	syscall
	jr $ra	
	
	
	
	
#################################################################################
#Con este he logrado modificar la primera letra
#Paraque sea mayuscula pero no las demas
opcion3:
#En esta parte del codigo se espera a la primera letra y se combierte en mayuscula.	
	addi $t3, $0, 'z'
	add $t0, $0, $a0
	
	lbu $t1, 0($t0)
	beq $t1, $0, End3
	andi $t1, $t1, 0xDF
	sb $t1, 0($t0)
	addi $t0, $t0, 1
	
#Aquie tranformamos las letras a minusculas hasta acabar el strig

	Loop3A:
	addi $t3, $0, 'Z'
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
	li $v0, 4		
	la $a0, 0($a0)	     
	syscall
	jr $ra
	


#######################################################################################
#Si convierte todas las letras a mayusculas utilizando el codigo que el profe hizo como 
#ejemplien la presentacion 9.
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
	j main


#################################################################################33
#Si convierte todas las letras a minusculas utilizando el codigo que el profe hizo
#en la presentacion nueve y solo cambiamos la mascara y el valos de Z y A.
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
	
	
	
	
	
	
Opcion6:
	add $t0, $0, $a0     #$t0 es i
	and $v0, $v0,$0
	and $v1, $v1,$0
	
	Loop6:
	lbu $t1, 0($t0)     #Leemos lo que hay en la pocicion A[i]
	beq $t1, $0, End6  #Preguntamos si ya encontramos el 0
	
	#Calculamos las minusculas
	addi $t3, $0, 'Z'
	sltiu $t2, $t1, 'A'
	bne $t2, $0, Inc6A   #Saltamos si no encontramos minuscula
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc6A
	addi $v1, $v1, 1     #Sumamos al contador de munusculas
	addi $t0, $t0, 1     #Sumamos a i
	j Loop6
	Inc6A:
	
	#Calculamos las mayusculas
	addi $t3, $0, 'z'
	sltiu $t2, $t1, 'a'
	bne $t2, $0, Inc6B
	sltu $t2, $t3, $t1
	bne $t2, $0, Inc6B
	addi $v0, $v0, 1
	addi $t0, $t0, 1
	j Loop6
	Inc6B:
	
	addi $t0, $t0, 1
	j Loop6
	End6:             #Terminamos de recorrer el arreglo
	
	#Intercambio Los valores de $vo y $v1 porque por alguna razon 
	#me salen cambiados los valores.
	add $t1, $0, $v0
	add $v0, $0, $v1
	add $v1, $0, $t1
	
	jr $ra
	
	
	
	
	
	
	
