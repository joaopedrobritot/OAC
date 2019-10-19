# Sejam s0,s1,s2 respectivamente a,b,x & t0 o condicional

addi $s0, $zero, 2 # a = ...
addi $s1, $zero, 2 # b = ...
addi $s2, $zero, 0 # x = 0

IF:
slt $t0, $s0, $zero # a < 0 ?
bne $t0, $zero, ELSEIF # se sim então pula pro else if, senão verifica a prox
slt $t0, $s0, $s1 # a < b ? 
beq $t0, $zero, ELSEIF # se sim então execute a prox linha, senão else if

addi $s2, $zero, 1 # x = 1
j EXIT

ELSEIF: 
slt $t0, $s1, $s0 # b < a ?
beq $t0, $zero, ELSE # se sim então prox linha, senao else (a == b)
slt $t0 , $s0, $zero # a < 0 ?
beq $t0, $zero, ELSE # se sim execute prox linha, senao else

addi $s2, $zero, 2 # x = 2
j EXIT

ELSE: addi $s2, $zero, 3 # x = 3
 
EXIT: 