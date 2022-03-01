programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Teclado --> tec
	inclua biblioteca Objetos --> o
	inclua biblioteca Internet --> int
	inclua biblioteca Calendario --> cal
	inclua biblioteca ServicosWeb --> s
	inclua biblioteca Texto --> t
	inclua biblioteca Tipos --> type
	inclua biblioteca Sons --> som
	inclua biblioteca Mouse --> mo
	inclua biblioteca Graficos --> graf
	inclua biblioteca Matematica --> m
	
	funcao inicio()
	{


escreva("Seja bem-vindo(a) a Calculdora de Juros" + "\n" + "O seu analizador oficial de contas e gastos" + "\n")
	
					Util.aguarde(4300)
					escreva("by 'ROSEMBERG TECNOLOGIA DO BRASIL SA'" + "\n")
					Util.aguarde(4000)
					
					limpa()

			caracter parar
			parar = 'N'
			enquanto (parar != 'S')
			{
//------------------BANCO DE VARIÁVEIS
//					- Variável Débito --> debito
						real debito
//					- Variável de Tempo (Meses e Parcelas) --> tempo
						real tempo //EM MESES
//					- Variável Valores a Receber --> recebe
						real recebe

//------------------BANCO DE USUÁRIOS
//					- Administrador (PEDRO ROSEMBERG TECNOLOGIA DO BRASIL S.A.)
//					- Pedro Rosemberg (Usuário)
						inteiro logger
						logger = u.sorteia(1,2147)
						
						cadeia user_data_bank[][]={{"Nome de Usuário", "Código Logger", "Senha", "E-mail"}, {"Admin", "logger_admin", "36339282000101", "admin@rosemberg.com.br"}, {"pedro", "logger_pedro", "3001", "pedro@rosemberg.com.br"}}
						inteiro logger_pedro= u.sorteia(2,4), logger_admin= u.sorteia(0,1)
						
//-----------------------Nu Pagamentos
// 					- Juros Rotativo --> j_rotativo (14%/mês) | Cartão de Crédito
						real j_rotativo = 14.00
//					- Juros e Mora --> j_mora (15%/mês) | Cartão de Crédito
						real j_mora = 15.00
//					- Juros de Empréstimo --> j_emprestimo (3,9%/mês) | Empréstimo
						real j_emprestimo = 3.9
//					- Juros Atraso --> j_atraso (2%) | Cartão de Crédito
						real j_atraso = 2.0
//					- Juros Parcelamento --> j_parcela (7,9%/mês) | Cartão de Crédito
						real j_parcela = 7.9

						cadeia juros[][]={{"Modalidade de Juros", "Porcentagem (%)"}, {"Juros Rotativos", "14%"}, {"Juros e Mora", "15%"}, {"Juros de Atraso", "2%"}, {"Juros de Empréstimo", "3,9%"},{"Juros de Parcelamento", "7,9%"}}

					Util.aguarde(4300)
					escreva("\n" + "		Favor digitar seus dados		")
Util.aguarde(4300)
					
//					Tela de Login (Pede: Usuário e Senha)
					cadeia usuario = "pedro", senha = "3001"
					
					escreva("\n" + "		Usuário: ") 
					leia(usuario)
					enquanto (usuario != user_data_bank[2][0])
					{
					Util.aguarde(4300)
					escreva("\n" + "		Usuário: ") 
					leia(usuario)
					}
Util.aguarde(4300)

					escreva("		Senha: ")
					leia(senha)
					enquanto (senha != user_data_bank[2][2])
					{
					escreva("		Senha: ")
					leia(senha)
					}
					
					Util.aguarde(4300)
					limpa()
					
					escreva("\n" + "Login aprovado | *Rodando Teste*")
					Util.aguarde(4300)

					limpa()

					Util.aguarde(4300)
					escreva("\n" + "Estamos inicializando o software, por favor aguarde..." + "\n")
					Util.aguarde(4300)

					limpa()
					
					escreva("\n" + "Processos desempacotados, software iniciado" + "\n")
					Util.aguarde(5500)
					u.sorteia(1, 2147483647)
					logger = u.sorteia(1,2147)

					limpa()
					escreva("\n" + "Login nº " + logger + " iniciado com sucesso!" + "\n" + "Seja bem vindo, Pedro Rosemberg" + "\n")
					
	
					//CHECKPOINT
					//escreva("Conferência de Dados" + "usuário: " + usuario)
					
					//PROGRAMA -- v00.01 beta
limpa()
Util.aguarde(2200)

					//SELECIONA O BANCO PROVEDOR DO ATENDIMENTO
			//escreva("\n" + "Selecione o banco para avaliação: " + "\n" + "1 - NuPagamentos - 260" + "\n")
					escreva("\n" + "O banco disponível é 'NUPAGAMENTOS S.A. (Código 260)" + "\n")
limpa()
Util.aguarde(5000)
					//INFORMAÇÕES + PEDE O VALOR DO DÉBITO
					escreva("\n" + "Após a selecção do banco, iremos coletar todos os dados de juros e te mostraremos as opções de acordo com o que você escolher. Vamos lá?" + "\n" + "Qual o valor que você precisa?" + "\n" + "Valor (apenas números): ")
					leia(debito)
limpa()
Util.aguarde(5000)

					//PEDE O VALOR QUE A PESSOA QUER RECEBER
					escreva("\n" + "Qual valor você quer receber?" + "\n" + "Valor (apenas números): ")
					leia(recebe)

					//PEDE O TEMPO EM QUE A PESSOA QUER PAGAR (EM MESES) - É O MESMO NÚMERO DE PARCELAS
					escreva("\n" + "Em quanto tempo você deseja pagar?" + "\n" + "Lembre-se que esse número também será a quantidade de parcelas.")
					leia(tempo)

//INÍCIO DOS CÁLCULOS
							real montante // M = J + C

//					- Juros Rotativo --> j_rotativo (14%/mês) | Cartão de Crédito
//						real j_rotativo = 0.14

//					- Juros e Mora --> j_mora (15%/mês) | Cartão de Crédito
//						real j_mora = 0.15

//					- Juros de Empréstimo --> j_emprestimo (3,9%/mês) | Empréstimo
//						real j_emprestimo = 0.039

//					- Juros Atraso --> j_atraso (2%) | Cartão de Crédito
//						real j_atraso = 0.02

//					- Juros Parcelamento --> j_parcela (7,9%/mês) | Cartão de Crédito
//						real j_parcela = 0.079

//					- Juros de Empréstimo --> j_emprestimo (3,9%/mês) | Empréstimo
//						real j_emprestimo = 0.039
														
//----------------------CARTÃO DE CRÉDITO

//								SITUAÇÃO A - ATRASO DE POUCOS DIAS (MORA + ATRASO)
								real situacao_j1 = m.potencia(j_mora, tempo) + j_atraso
																
//								SITUAÇÃO B - PAGAMENTO NA PRÓXIMA FATURA (ROTATIVO, ATRASO E MORA)
								real situacao_j2 = m.potencia(j_mora + j_rotativo, tempo) + j_atraso
								
// 								SITUAÇÃO C - PARCELAMENTO (PARCELAMENTO + ATRASO)
								real situacao_j3 = m.potencia(j_parcela + j_rotativo, tempo)
								
//						JUROS DO ROTATIVO
						//	real montante_j_rotativo, pmf_jr
							//pmf_jr = (1 + j_rotativo)
//							m.potencia(pmf_jr, tempo)
							
//						JUROS E MORA
						//	real montante_j_mora, pmf_j_mora
							//pmf_j_mora = (1 + j_mora)
//							m.potencia(pmf_j_mora, tempo)
							
//						JUROS DE ATRASO
							//real montante_j_atraso, pmf_j_atraso
							//pmf_j_atraso = (1 + j_atraso)
//							m.potencia(pmf_j_atraso, tempo)
							
							
//						JUROS DE PARCELAMENTO
						//	real montante_j_parcela, pmf_j_parcela
							//pmf_j_parcela = (1 + j_parcela)
//							m.potencia(pmf_j_parcela, tempo)

//----------------------EMPRÉSTIMO

//						JUROS DE EMPRÉSTIMO
							//real montante_j_emprestimo, pmf_j_emprestimo
							real situacao_emprestimo_j4 = m.potencia(j_emprestimo, tempo)
//							m.potencia(pmf_j_emprestimo, tempo)

					 real show1 = situacao_j1
					
					 real show2 = situacao_j2
					 
					 real show3 = situacao_j3
					
					 real show4 = situacao_emprestimo_j4
					 
					 Util.aguarde(4300)
					 limpa()
					 Util.aguarde(4300)
						
					escreva("\n" + "Com base nos dados digitados, se liga nas taxas de juros: " + "\n" + juros[1][0] + " - " + juros[1][1] + "\n" + juros[2][0] + " - " + juros[2][1] + "\n" + juros[3][0] + " - " + juros[3][1] + "\n" + juros[4][0] + " - " + juros[4][1] + "\n" + juros[5][0] + " - " + juros[5][1] + "\n")		
					escreva("\n" + "Nesse sentido, é possível visualizar 4 ceários: " + "\n" + "1º Cenário - Atraso curto - Pagamento de Juros de Mora por " + tempo + " mês(es)" + ", aproximadamente " +  m.arredondar(show1, 2) + "%." + "\n" + "2º Cenário - Pagamento na Próxima Fatura - Pagamento de Rotativo e Juros de Mora por " + tempo + " mês(es)," + " mais juros por atraso" + ", aproximadamente " + m.arredondar(show2, 2) + "%." + "\n" + "3º Cenário - Parcelamento de fatura - Pagamento de Rotativo e Parcelamento por " + tempo + " mês(es)" + ", aproximadamente " +  m.arredondar(show3, 2) + "%." + "\n" + "4º Cenário - Contratação de Empréstimo - Juros de Empréstimo por " + tempo + " mês(es)" + ", aproximadamente " + m.arredondar(show4, 2) + "%." + "\n")
					 Util.aguarde(5300)
					
					
					//ENCERRAMENTO DO PROGRAMA
					escreva("\n" + "Encontrou o que precisava?" + "\n" + "Quer encerrar o programa?" + "\n" + "Digite S para parar e N para continuar: ")
					leia(parar)
					
		}
	} 
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 7814; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */