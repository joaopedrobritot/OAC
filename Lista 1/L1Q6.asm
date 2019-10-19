# Inspirado no seguinte código (feito por mim):

#int Fibonacci(int n)
#{
#	if(n <= 0)
#	{
#		return 0;
#	}
#	else if(n > 0 && n <= 2)
#	{
#		return 1;
#	}
#	return Fibonacci(n - 1) + Fibonacci(n - 2);
#}

# Falta explicar

addi $s0, $zero, 6 # Fibonacci(n) == Fn

addi $s2, $zero, 0 # Fn - 1
addi $s3, $zero, 0 # Fn - 2

addi $s4, $zero, 0 # Resultado

jal Fibonacci

j EXIT

Fibonacci:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	slti $t0, $s0, 1
	bne $t0, $zero, return1
	slti $t0, $s0, 3
	bne $t0, $zero, return2
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	
	addi $s0, $s0, -1
	jal Fibonacci
	addi $s0, $s0, -1
	jal Fibonacci
	
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	return1:
		addi $s4, $s4, 0
		lw $ra, 0($sp) # recebe o valor armazenado do ultimo $ra da pilha
		addi $sp, $sp, 4
		jr $ra
		
	return2:
		addi $s4, $s4, 1
		lw $ra, 0($sp) # recebe o valor armazenado do ultimo $ra da pilha
		addi $sp, $sp, 4
		jr $ra

EXIT: