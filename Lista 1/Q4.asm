addi $s0, $zero, 4 # a = ...
addi $s1, $zero, 4 # b = ...
addi $v1, $zero, 0 # v1 = 0

addi $k0, $zero, 0 # contador

Main:
slt $t0, $s1, $s0 # b < a ?
beq $t0, $zero, SUM # se sim entao valor 1 em v1, senao soma o intervalo

addi $v1, $zero, 1 # v1 = 1
j EXIT

SUM:
addi $s1, $s1, 1 # b += 1 ( condicao de parada )
Function:
beq $s0, $s1, EXIT # a == (b + 1) ? se sim então a soma está completa
add $v1, $v1, $s0 # v1 += a
addi $s0, $s0, 1 # a += 1

j Function

EXIT: