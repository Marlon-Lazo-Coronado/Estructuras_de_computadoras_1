#################################################
#Universidad de Costa Rica
#Estructuras de Computadoras Digitales
#Marlon Lazo Coronado B43717
#Tarea #3

#Para hacer el codigo un poco mas general lo diseñe
#Para que sele ingrese un arraglo grande, de unos 
#400/4 espacios.
#El codigo es un poco extenso porque 
#se imprimieron varios mensajes y se ha tenido
#cuidado de no tener errores con los registros

#Se ha creado dos funciones, "Array" solamente
#guarda el arrego, mientras que "promedio" hace
# el resto.
#NOTA: EN LA TERMINAL NO SE PUEDE PONER NUMEROS
#EN EXADECIMAL!!!

#Para terminar de ingresar el array en la terminal
#se ingresa un numero negativo que indica el final 
#del array

.data
#array: .word 1,3,2,0x7FFFFFF9,-2 # Array de PRUEVA!
ArrayP: .space 400  # SE CREA EL ARRAY DE NUMEROS
#array1: .space 40 # SE CREA EL ARRAY DE NUMEROS
M2: .asciiz "No es posible calcular el promedio porque hay un \ndesbordamiento en los bits de la suma"
M3: .asciiz "\n"
M4: .asciiz ", "
M5: .asciiz "Array: "
M6: .asciiz "Suma del array: "
M7: .asciiz "Promedio: "
M8: .asciiz "Reciduo: "
M9: .asciiz "Ingrese los elementos del arreglo que desea probar"
M10: .asciiz "\n\n"
#x: .word 0x7FFFFFFF #PRUEVA!
#y: .word 1          #PRUEVA!

.text
.globl main

main:
	la $a0, ArrayP     #Obtengo la direccion A[0]
	jal Array
	jal promedio
	
	la $a0, M10          #Espacio
	li $v0, 4    
	syscall
	j main
	
	
	

promedio:
	and $t7, $t7, $0  #Limpiamos temporal
	and $t0, $t0, $0  #Limpiamos suma
	and $t1, $t1, $0  #i del contador

	loop:
	or $t2, $0, $a0      #Direccion A[0] 
	add $t2, $t2, $t1    #A[0]+i
	lw $t3, 0($t2)       #Gardamos A[0]+i en $t3
	slt $t7, $t3, $0
	bne $t7,$0, final
	addu $v0,$t0, $t3    #Sumamos el total
	
	#Verificacion de desborde o no desborde######################################
	slt $t8, $v0, $zero        #$t3 es negativo si signos de suma son diferentes, $t3=1 si seigno de sumas es diferentes
	bne  $t8, $zero, desborde
	#############################################################################
	
	NoDesborde:
	addu $t0,$t0, $t3  #Penultima suma
	addi $t1, $t1, 4   #Sumamos al contador
	j loop
	
	
	desborde:
	la $a0, M2     # SE IMPRIME UN Error
	li $v0, 4    
	syscall
	
	addi $v0, $0,-1
	addi $v1, $0,-1
	j fin2
		
	move $t8, $a0      # Guardamos la direccion del array
	la $a0, M10         # Array
	li $v0, 4 
	syscall   
	move $a0,$t8

	
	final:
	#Imprimimos el array$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	and $t1,$t1,$0
	and $t5,$t5,$0
	move $t0, $v0      # Guardamos la suma
	
	move $t8, $a0      # Guardamos la direccion del array
	la $a0, M5         # Array
	li $v0, 4 
	syscall   
	move $a0,$t8
	
	loop2:
	or $t2, $0, $a0      #Direccion A[0]
	add $t2, $t2, $t1    #A[0]+i
	lw $t3, 0($t2)       #Gardamos A[0]+i en $t3
	slt $t7, $t3, $0
	bne $t7,$0, finx
	
	move $t8, $a0
	move $a0, $t3      #Imprimimos el array
	li $v0, 1          #
	syscall            #
	la $a0, M4         # comas
	li $v0, 4    
	syscall
	move $a0,$t8
	
	addi $t1,$t1,4
	addi $t5,$t5,1
	j loop2
	finx:
	
	move $t4, $a0      # Guardamos la direccion del array
	
	la $a0, M3         # Espacio
	li $v0, 4    
	syscall
	    
	la $a0, M6         # Total
	li $v0, 4 
	syscall   
	
	move $a0, $t0      # Imprimimos suma
	li $v0, 1          #
	syscall            #
	
	#Imprimimos resultados$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	la $a0, M3         # Espacio
	li $v0, 4    
	syscall
	
	div $t0,$t5        #Division
	mflo $t8
	mfhi $t6
	
	la $a0, M7         # Promedio
	li $v0, 4 
	syscall 
	
	move $a0, $t8      # Imprimimos Promedio
	li $v0, 1          #
	syscall            #
	
	la $a0, M3         # Espacio
	li $v0, 4    
	syscall
	
	la $a0, M8         # Reciduo
	li $v0, 4 
	syscall 
	
	move $a0, $t6      # Imprimimos reciduo
	li $v0, 1          #
	syscall            #
	
	move $a0, $t4      #Restablecemos direccion del array
	move $v0, $t0      #Restablecemos $v0
	fin2:
	move $v0,$t8       #Devolvemos en $v0 la parte entera
	move $v1,$t6       #Devolvemos en $v1 el reciduo
	jr $ra
	




Array:
	and $t1,$t1, $0
	and $t2,$t2, $0
	
	move $t8, $a0
	la $a0, M9          # Mensaje
	li $v0, 4    
	syscall
	la $a0, M3          # Mensaje
	li $v0, 4    
	syscall
	move $a0,$t8
	
	
	loop3:
	or $t2, $0, $a0      #Direccion A[0]
	add $t2, $t2, $t1    #A[0]+i
	
	#Solicitamos elementos
	li $v0, 5
	syscall
	move $a1, $v0       #Movemos a los registros temporales
	
	sw $a1,0($t2)
	
	slt $t7, $a1, $0
	bne $t7,$0, finx2
	
	addi $t1,$t1,4
	j loop3

	finx2:
	and $t1,$t1, $0
	and $t2,$t2, $0
	and $t8,$t8, $0
	jr $ra










