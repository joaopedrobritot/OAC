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
Main:
	addi $s0, $zero, 6 # n = 6 /// também servirá de indice para a recursao

	addi $s4, $zero, 0 # Resultado /// Fibonacci(n) == F(n)

	jal Fibonacci # chamada da funcao

	j EXIT

Fibonacci:
	addi $sp, $sp, -4
	sw $ra, 0($sp) # guardo o endereço de retorno da chamada recursiva
	
	slti $t0, $s0, 1 # n < 1 ?
	bne $t0, $zero, return0 # se sim entao retorno 0, senao verifico a prox condicao
	slti $t0, $s0, 3 # já que n >= 1, então verifico só se ele n < 3 ?
	bne $t0, $zero, return1 # se sim entao retorne 1, senao:
	
	addi $sp, $sp, -4
	sw $s0, 0($sp) # salvo o indice da recursao na pilha
	
	addi $s0, $s0, -1
	jal Fibonacci # chamo a recursao para n - 1 /// F(n-1)
	
	# se todas as recursoes deste ponto já retornaram, então $s4 já deve conter o valor de F(n-1)	

	addi $s0, $s0, -1
	jal Fibonacci # depois chamo a recursao para n - 2 /// F(n-2)
	
	# se todas as recursoes deste ponto já retornaram, então $s4 já deve conter o valor de F(n-1) + F(n-2)
	
	lw $s0, 0($sp) # recebo o ultimo indice da recursao armazenado na pilha
	
	# caso ele ja tenha retornado todas as F(n-2) então o $s0 da pilha que ele está retirando foi o primeiro s0 da pilha
	# então só resta receber o primeiro endereco de retorno da pilha, que é o que volta para a Main com o resultado
	# armazenado em $s4.
	
	addi $sp, $sp, 4 
	
	# essa parte a cima eh necesaria para saber o valor retornado de F(n-1) + F(n-2)
	
	lw $ra, 0($sp) # retiro o ultimo endereco de retorno da pilha
	addi $sp, $sp, 4
	jr $ra # volto na recursao
	
	return0:
		addi $s4, $s4, 0 # adiciona 0 ao resultado do numero de fibonacci
		lw $ra, 0($sp) # recebe o ultimo endereco de retorno
		addi $sp, $sp, 4
		jr $ra # volta na recursao
		
	return1:
		addi $s4, $s4, 1 # adiciona 1 ao resultado do numero de fibonacci
		lw $ra, 0($sp) # recebe o ultimo endereco para retornar
		addi $sp, $sp, 4
		jr $ra # volta na recursao

EXIT:
