#Universidad de Costa Rica
#Estructuras de computadores digitales I
#Tarea 2
#Grupo 2
#Marlon Javier Lazo Coronado B43717


#Para resolver este problema se utilizo un metodo semejante al de Fibonaci en la
#que la funcion se define como f(n)=f(n-1)+f(n-2), comparar con C(n,k)=C(n-1)+C(n-1,k-1)

.data 
	Mensaje1: .asciiz "\n\nIngrese los numeros a los que quiere aplicar C( n , K )\n\n"
	Mensaje7: .asciiz "n="
	Mensaje8: .asciiz "k="
	Mensaje2: .asciiz "C( "
	Mensaje3: .asciiz " , "
	Mensaje4: .asciiz " ) = "
	Mensaje5: .asciiz "\n\n"
	Mensaje6: .asciiz "\nError, no se puede ingresar k>n"
.text 
	main:
	#Imprimimos mensajes del menu y solicitamos la opcion a ejecutar
	
	jal Mensajes
	
	jal Mensajes2
	
	add $t0, $0, $t0          #Aseguro mi variable temporal
	jal funcion
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		li $v0, 4         #Espacio
		la $a0, Mensaje5 
		syscall
		
		
		
	final:
	j main
		
										
	
#Esta es la funcion que me imprime los mensajes y me solicita la opcion
	Mensajes:

		li $v0, 4           # Código de imprimir cadena
		la $a0, Mensaje1    # dirección de la cadena
		syscall             # Llamada al sistema 
		
		
		li $v0, 4           
		la $a0, Mensaje7    
		syscall
		#Solicitamos n
		li $v0, 5
		syscall
		move $a1, $v0       #Movemos a los registros temporales
		
		
		li $v0, 4           
		la $a0, Mensaje8   
		syscall
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
	
		jr $ra




	Mensajes2:
	
		#Mensaje de error
		and $t0, $t0, $0
		slt $t0 , $a1, $a2
		beq $t0, $0, bien
		li $v0, 4           
		la $a0, Mensaje6
		syscall
		j main
		bien:
		jr $ra



	
#######################################################################################	
#Creamos la funcion
	funcion:
		
		#Mediante estas condiciones preguntamos si se ha llegado a la condicion de parada
		
		bne  $a1, $a2, salto1        # a=k o a=k-1
		addi $v0, $zero, 1           #Asignamos valor a la funcion
		jr $ra                       #Nos devolvemos
		
		salto1:
		bne  $a2, $zero, recursivo   #k=0
		addi $v0, $zero, 1           #Asignamos valor a la funcion
		jr $ra                       #Nos devolvemos
		
#############AQUI COMIENZA EL PROBLEMAS DE LLAMAR Y SUMAR A LAS 2 FUNCIONES###########
		
		recursivo:
		addi $sp, $sp, -16     #Pedimos espacio en la pila para las funciones
		sw $ra, 0($sp)         #Gardamos la direccion de retorno
		
		
		sw $a2, 8($sp)         #Guardamos k
		sw $a1, 4($sp)         #Guardamos n
		
		
		addi $a1, $a1, -1      #Tenemos n-1
		jal funcion            #Llamamos con n-1
		lw $a1, 4($sp)         #Leemos n
		lw $a2, 8($sp)         #Leemos k
		sw $v0, 12($sp)        #Guardamos el resultado
		
		
		##############################################  C(n-1,k-1)
		
		addi $a2, $a2, -1       #Tenemos k-1
		addi $a1, $a1, -1       #Tenemos n-1       
		jal funcion             #Llamamos con n-1 y k-1
		lw $t0, 12($sp)         #Asignamos mismo valor que C(n-1,k)
		
		                
		add $v0, $v0, $t0       #Sumamos ambos resultados
		
	
		lw $ra, 0($sp)          #Leemos la direccion de retorno
		addi $sp, $sp, 16       #Devolvemos el puntero de pila
		
		jr $ra                  #Nos devolvemos a donde nos llamaron.
		
				
