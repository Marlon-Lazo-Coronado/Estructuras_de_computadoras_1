.data
#array: .word 1,0xEFFFFFFF,-1 # SE CREA EL ARRAY DE NUMEROS A[0]
#Base: .space 1  # SE CREA EL ARRAY DE NUMEROS
#Altura: .space 1 # SE CREA EL ARRAY DE NUMEROS
mensaje: .asciiz "La multiplicacion es: "
M2: .asciiz "\n"
M3: .asciiz "La parte alta es: "
M4: .asciiz "La parte baja es: "
Multiplicador: .word 11
multiplicando: .word 5#Ahi esta bien la maxima representacion

.text
.globl main

main:
	la $a0, Multiplicador
	la $a1, multiplicando
	
	and $v0,$v0,$0
	and $v1,$v1,$0
	and $t3,$t3,$0
	and $t6,$t6,$0
	
	jal Multiplicar
	j salir
	
	
Multiplicar:
	lw $t0,0($a0)    #Leemos los numeros
	lw $t1,0($a1)

#############PRIMEROTENEMOS TENEMOS QUE HACER UN COMPARADOR DE BITS################
	addiu $t7,$0,31

	loop1:
	slt $t3,$t6,$t7       #$t7=32 es mi comparador, cuando $t6 llegue 31 terminamos
	beq $t3,$0,final
	
	and $t5,$t0,1         #$t5 verifica si tenemos un 1 o 0 en el multiplicador
	srl $t0,$t0,1         #Desplazamos ->
	beq $t5,$0, desplazar
	
	############Aqui sumamos##############
	
	addu $v0,$v0,$t1 #suma+sumando
	move $t4,$v0    #Copiamos suma para trabajarla
	sll $t4,$t4,31  #desplazamos suma 31 veces para sumar su bit menos significativo al total
	or $v1,$v1,$t4  #sumo el bit al total
	srl $v1,$v1,1   #desplazo los 32 bits menos significativos un espacio 
	srl $v0,$v0,1   #desplazo mi suma un espacio
	move $s0,$v0    #Guardo para concatenar al final
	
	
	addi $t6,$t6,1        #$t6 esel contador
	move $s1,$t6    #guardo para calcular donde voy a concatenar
	j loop1
	
	desplazar:

	srl $v1,$v1,1   #desplazo los 32 bits menos significativos un espacio 
	srl $v0,$v0,1   #desplazo mi suma un espacio
	
	addi $t6,$t6,1        #$t6 esel contador
	j loop1


	final:

	loop2:
	beq $s1,$0,FinAhoraSi   #Bucle para desplazar la parte que no se logra
	sll $s0,$s0,1           #Concatenar en el corte del loop1
	addi $s1,$s1,-1
	j loop2
	
	
	FinAhoraSi:
	or $s3,$v1,$s0         #Concatenamos lo que quedo en loop1
	srl $v0,$v0,1          #Corremos un espacio para obtener la segunda palabra
	move $v1,$s3
	
	move $t0,$v0
	move $t1,$v1
	
	la $a0, M3     # imprime mensaje
	li $v0, 4    
	syscall
	
	move $a0,$v0
	li $v0, 36    
	syscall
	
	la $a0, M2     # imprime mensaje
	li $v0, 4    
	syscall
	
	la $a0, M4     # imprime mensaje
	li $v0, 4    
	syscall
	
	move $a0,$v1
	li $v1, 36    
	syscall
	
	move $v0,$t0
	move $v1,$t1
	
	jr $ra
	
salir:


##############SE CONCLUYE QUE CON LOS BITS MENOS SIGNIDICATIVOS Y MAS SIGNIFICATIVOS
##############SE COMPOTA BIEN, PARO POR AHI DE LOS BITS 24 A 32 SE DESMADRA
	
	#la $a0, mensaje     # imprime mensaje
	#li $v0, 4    
	#syscall





































	#or $t8,$0,$v1
	#addi $t5,$0,8
	#and $t6,$t6,$0
	#and $t7,$t7,$0
	#and $t3,$t3,$0
	
	
	#loop3:
	#beq $t6,$t5,ragnaro
	#andi $t1,$t8,0x0000000F
	#srl $t8,$t8,4
	
	
	#move $t7,$t6
	#loopx:
	#beq $t6,$0,siguiente
	#sll $t1,$t1,4
	#addi $t6,$t6,-1
	#j loopx
	#siguiente:
	#move $t6,$t7
	
	
	#addu $t3,$t3,$t1
	#addi $t6,$t6,1
	#j loop3
	
	#ragnaro:
	
	
	#move $a0, $t3      #imprime un numero
	#li $v0, 1     
	#syscall


