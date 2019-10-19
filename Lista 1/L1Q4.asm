
addi $a0, $zero, 0 # a = ...
	
addi $a1, $zero, 5 # b = ...

slt $t0, $a1, $a0 # b < a ?
bne $t0, $zero, Else # se sim entao v1 = 1, senao soma o intervalo
	
addi $v1, $zero, 0 # inicia o somador v1 = 0
jal Sum # chama a funcao para somar o intervalo
	
j Exit # depois de efetuada a soma do intervalo encerra o programa

Sum:
	addi $sp, $sp, -4 # 'aloca' um espaço de 1 palavra na pilha
	sw $ra, 0($sp) # salva o $ra naquele espaco alocado (usado para voltar na recursao)
	slt $t0, $a1, $a0 # b < a ?
	bne $t0, $zero, Return # se sim então a condicao de parada da recursao foi aceita, senao some a ao resultado e o incremente
	
	add $v1, $v1, $a0 # v1 += a0
	addi $a0, $a0, 1 # a0 += 1
	jal Sum # chama a funcao recursivamente
	
	Return:
		lw $ra, 0($sp) # recebe o valor armazenado do ultimo $ra da pilha
		addi $sp, $sp, 4 # atualiza a posicao do $sp para a prox palavra
		jr $ra # volta na recursao
Else:

	addi $v1, $zero, 1 # caso onde b < a --> v1 = 1

Exit:
	
	
	
