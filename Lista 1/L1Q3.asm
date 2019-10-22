.data
string: .asciiz "HArdwArE" # string a ser invertida
output: .space 256 # string vazia onde serah salva a string invertida

.text
Main:
	addi $s7, $zero, 64 # limite inferior das letras maiusculas
	addi $s6, $zero, 90 # limite superior das letras maiusculas
	addi $s5, $zero, 96 # limite inferior das letras minusculas
	addi $s4, $zero, 123 # limite superior das letras minusculas
	
	# intervalos da tabela ascii /\, necessario para saber se o caracter eh maiusculo ou minusculo.
	# senao estiver no intervalo entao nao esta no alfabeto, portanto v1 = 1 e encerra o programa
	
	la $a0,	string # armazena o endereco da string em a0 /// endereco do primeiro byte da string
	
	addi $t0, $zero 0 # contador que percorre a string
	addi $t2, $zero, 0 # registrador que armazena o endereco de cada byte percorrido
	
	jal Inverte_caracteres # antes de inverter a string, trocamos o caracteres maiusculos e minusculos e recebemos o tamanho da string em v0

	add $t1, $zero, $v0	# Salva o tamanho da string em t1
	add $t2, $zero, $a0	# Salva o endereco da string // string[0], primeira posicao da string
	
	addi $t0, $zero, 0 # contador que percorre os bytes da string
	addi $t3, $zero, 0 # armazena o byte atual enquanto percorre a string

Inverte_string:
	add $t3, $t2, $t0 # Coloca o endereco do byte atual em t3 // t3 = string[0 + i]
	lb $t4, 0($t3) # Carrega o byte em t4
	
	beq $t4, $zero, done	# Caso seja nulo, indica que está no final da string // char NULL // EX: char '\0'
	
	sb $t4, output($t1)	# senao escreve esse byte no final de output	
	addi $t1, $t1, -1 # reduz o tamanho // para poder escrever o prox byte
	addi $t0, $t0, 1 # aumenta o contador de byte atual // para poder ler o prox byte a ser invertido na string
	j Inverte_string
	
done:
	addi $v0, $zero, 4 # funcao para imprimir a string invertida		
	la $a0, output
	syscall
				
	j EXIT
	
Inverte_caracteres: # a partir doi tamanho da string, invertemos os caracteres maiusculos e minusculos e armazenamos
	add $t2, $a0, $t0 # t2 recebe o endereco do byte atual da string // t2 = string[0 + i] onde i é o contador t0
	lb $t1, 0($t2) # t1 recebe o byte daquele endereco 
	beq $t1, $zero, end # se o caracter for nulo, então a inversao dos caracteres foi bem sucedida
	j Inverter_caracter	# funcao para inverte o caracter atual armazenado em t1
	next: # tive de usar esse label de retorno para nao perder a referencia de $ra
		sb $t1, string($t0) # depois de realizada a inversao, salvamos o byte novamente naquela posicao
		addiu $t0, $t0, 1 # aumentamos o contador que percorre a string
		j Inverte_caracteres # repetimos o processo ate que todos os caracteres sejam invertidos e o caracter nulo seja lido

end:
	addi $t0, $t0, -1 # no final da inversao (quando o char null eh lido) temos que diminuir esse caracter do tamanho
	add $v0, $zero, $t0 # assim teremos de armazena o tamanho da string em v0
	add $t0, $zero, $zero # zera o contador
	jr $ra # procede para a inversao da string

Inverter_caracter:
	slt $t7,$s7,$t1 # t1 >= 64 ? senao, eh inferior aos caracteres alfabeticos maiusculos
	beq $t7, $zero, nao_caracter	
	slt $t7,$s6,$t1 # t1 >= 90 ? senao, entao o caracter alfabetico eh maiusculo
	beq $t7, $zero, converte_minusculo
	slt $t7,$s5,$t1 # t1 >= 96 ? se sim entao pode ser minusculo, senao nao eh caracter alfabetico
	beq $t7, $zero, nao_caracter
	slt $t7,$t1,$s4 # t1 < 123 ? se sim, eh uma letra minuscula, senao nao eh letra
	beq $t7, $zero, nao_caracter
	j converte_maiusculo # como eh minusculo, converte para maiusculo

converte_minusculo: # funcao para converter o caracter atual para minusculo
	addi $t1,$t1,32
	j next

converte_maiusculo: # funcao para converter o caracter atual para maiusculo
	addi $t1,$t1,-32
	j next

nao_caracter: # caracter nao alfabetico inserido, armazena 1 em v1 e encerra o programa
	addi $v1, $zero, 1
	
EXIT:
