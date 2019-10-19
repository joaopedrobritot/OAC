# Sejam s0,s1,s2 respectivamente a,b,m

addi $s0, $zero, 2 # a recebe 2
addi $s1, $zero, 1 # b recebe 1
addi $s2, $s0, 0 #m recebe a

slt $t0, $s1, $s2 # se b < m ent�o t0 � 1, sen�o 0.
beq $t0, $zero, ELSE # se t0 for zero ent�o b >= m, leva ao else

addi $s2, $s1, 0 # m = b
j EXIT # pula para o fim do c�digo, evitando que o ELSE seja executado

ELSE: addi $s2, $zero, 0 # m = 0

EXIT: