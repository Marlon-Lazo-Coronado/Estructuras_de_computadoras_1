.data
array: .word -7,-9,3,-8,6,0 # SE CREA EL ARRAY DE NUMEROS A[0]
array0: .space 40  # SE CREA EL ARRAY DE NUMEROS
array1: .space 40 # SE CREA EL ARRAY DE NUMEROS
numero: .asciiz ", "

.text
.globl main

main:

la $a0, array     #Obtengo la direccion A[0]
la $v0, array0    #Guardo en $v0 la direccion de array0
la $v1, array1

and $t1, $t1, $0  #i del contador
or $t2, $0, $a0   #Direccion A[0]

or $t5, $0, $v0   #Copiamos en $t5 la direccion de $v0
or $t6, $0, $v1

#Comparamos
loop:
add $t2, $t2, $t1    #A[0]+i
lw $t3, 0($t2)       #Gardamos A[0]+i en $t3
beq $t3, $0, fin     #Preguntamos si $t3=0 para terminar
slt $t4, $t3, $0     #Preguntamos por el signo de $t3
bne $t4, $0, negativo#Saltamos si es negativo
#Positivo
sw $t3, 0($t5)       #Guardamos lo que hay en A[0]+i en $t5
addi $t1, $t1, 4     #Sumamos 4 a i
addi $t5, $t5, 4     #Sumamos 4 a la direccion de $t5
j loop

negativo:
sw $t3,0($t6)        # ||
addi $t1, $t1, 4
addi $t6, $t6, 4
j loop


fin:
sw $0,0($t5) #Ponemos un cero al final del arreglo con el ultimo $t5+4
sw $0,0($t6) 

#############################################################IMPRIMIMOS
and $t3, $t3, $0
and $t1, $t1, $0
or $t2, $0, $v1

loop2:
add $t2, $t2, $t1    #A[0]+i
lw $t3, 0($t2)       #Direccion A[0]
beq $t3,$0, final

move $a0, $t3      # SE GUARDA EL VALOR DE $T3 A $A0 PARA SYSCALL
li $v0, 1     
syscall

la $a0, numero     # SE IMPRIME UNA COMA
li $v0, 4    
syscall 

addi $t1,$t1, 4    #Sumamos 4 al contador para recorrer el array
j loop2
final:

