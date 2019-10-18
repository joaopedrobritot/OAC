addi $s0, $zero, 5 # a = ...
addi $s1, $zero, 5 # b = ...

slt $t0, $s0, $zero # sinal de a ( 1 - negativo, 0 - positivo )
slt $t1, $s1, $zero # sinal de b ( 1 - negativo, 0 - positivo )

xor $a0, $t0, $t1 # sinal de a * b ( 1 - negativo, 0 - positivo )

MULT:
	addi $s2, $zero, 0 # aux = 0, onde será salvo o resultado
LOOP:
	beq $s1, $zero, RESULT # se b == 0 então para de somar ( ou subtrair )
	
	beq $t1, $zero, SUB_b # se o sinal de b for zero então b é positivo e b deve ser decrementado para chegar em zero
	SUM_b: addi $s1, $s1, 1 # se negativo, então será incrementado // b += 1
		j Continue
	SUB_b: addi $s1, $s1, -1 # b -= 1
	Continue:
	
	bne $a0, $zero, Neg # se o sinal da multiplicacao for positivo entao somamos o valor, senao subtraimos
	
	add $s2, $s2, $s0 # aux += a 
	j LOOP
	Neg:
		sub $s2, $s2, $s0 # aux -= a
		j LOOP
RESULT:
	bne $a0, $zero, Inverte # verificamos se o sinal do resulotado coincide com o sinal esperado
	j EXIT
	Inverte: # se nao coincidir, entaõ inverto o sinal:
		slt $t0, $s2, $zero
		bne $t0, $zero, EXIT
		add $s3, $zero, $s2
		sub $s2, $s2, $s3
		sub $s2, $s2, $s3

EXIT: # No final, o resultado estará armazenado em $s2.
	