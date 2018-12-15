LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Projeto Final
ENTITY Projeto_final IS	
	PORT (Switches:		IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Reset :			IN STD_LOGIC;
			Operar :			IN STD_LOGIC;
			Validar :		IN STD_LOGIC;
			clk: 				IN STD_LOGIC;									-- Clock
			LER_A: 			IN STD_LOGIC;
			LER_B: 			IN STD_LOGIC;
			
			Debug_A :		OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			Debug_B :		OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			
			D1,D2,D3,D4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para os numeros
			LED_16 : 		OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			LED_TERMINO : 	OUT STD_LOGIC);								-- Indica o fim de uma operaçao
END;		

ARCHITECTURE arch OF Projeto_final IS

	COMPONENT Banco_Reg
	PORT (reg_alvo: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clk, load: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
	END COMPONENT;

	COMPONENT Registrador
		PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Numero a ser registrado
				clk_r, ld_r, escolhido_r: IN STD_LOGIC;			-- Clock, indica se a entrada será registrada, indica se o registrador é o certo
				saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) ); -- Numero atualmente registrado / novo numero registrado
	END COMPONENT;
	
	COMPONENT memory_acess
    PORT (
       clk:					IN STD_LOGIC;
		 Operar:				IN STD_LOGIC;
       Clear:				IN STD_LOGIC;
		 instrucao:			IN STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 endereco_atual:	OUT STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 cod_op:				OUT STD_LOGIC_VECTOR( 3 DOWNTO 0 );
		 end_reg:			OUT STD_LOGIC_VECTOR( 2 DOWNTO 0 );
		 constante:			OUT STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 salvar_memo:		OUT STD_LOGIC;
		 load:				OUT STD_LOGIC;
		 sel_entr_Banco:	OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		 sel_saida_Banco:	OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 )
    );
	END COMPONENT;
	
	COMPONENT ram_comandos
	   PORT ( clock  : IN STD_LOGIC;
				 wren   : IN STD_LOGIC;
				 addr   : IN STD_LOGIC_VECTOR( 15 DOWNTO 0);
				 data_i : IN STD_LOGIC_VECTOR( 15 DOWNTO 0);
				 data_o : OUT STD_LOGIC_VECTOR( 15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT ram_valores
	   PORT ( clock  : IN STD_LOGIC;
				 wren   : IN STD_LOGIC;
				 addr   : IN STD_LOGIC_VECTOR( 15 DOWNTO 0);
				 data_i : IN STD_LOGIC_VECTOR( 15 DOWNTO 0);
				 data_o : OUT STD_LOGIC_VECTOR( 15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Display 
		PORT (W,X,Y,Z: 		IN STD_LOGIC;				-- Bits do número a ser mostrado no display (Hexadeciaml)
				A,B,C,D,E,F,G:	OUT STD_LOGIC);			-- Segmentos do display que serão acesos
	END COMPONENT;
	
	COMPONENT ULA												
		PORT (A,B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);	-- Entradas da ULA
			SELETOR: IN STD_LOGIC_VECTOR(3 DOWNTO 0);	-- Operaçao que a ULA irá realizar
			SAIDA: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- Resultado da operaçao
			COUT: OUT STD_LOGIC);							-- Indica se ocorreu overflow durante a operaçao
	END COMPONENT;

	COMPONENT Modulo_entrada	
	PORT( Switches:		IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Reset :			IN STD_LOGIC;
			Operar :			IN STD_LOGIC;
			Validar :		IN STD_LOGIC;
			Clear:			OUT STD_LOGIC;
			Executar:		OUT STD_LOGIC;
			Valor:			OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
	END COMPONENT;
	
	COMPONENT Modulo_saida
	PORT (clock: 		IN STD_LOGIC;
			end_alg: 	IN STD_LOGIC;
			result: 		IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			t_alg: 		IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			D1,D2,D3,D4	: out STD_LOGIC_VECTOR (6 DOWNTO 0);
			saida_LED: 	OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
			Led_alg:		OUT STD_LOGIC);	
	END COMPONENT;
		
	SIGNAL Clear: STD_LOGIC;
	SIGNAL Executar: STD_LOGIC;
	SIGNAL Valor: STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	SIGNAL salvar_memo: STD_LOGIC;
	
	SIGNAL entrada_MEMO: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL saida_MEMO: STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	SIGNAL endereco_atual: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL instrucao: STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	SIGNAL cod_op: STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL end_reg: STD_LOGIC_VECTOR (2 DOWNTO 0);
	SIGNAL constante: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_alvo: STD_LOGIC_VECTOR (7 DOWNTO 0);
	
	SIGNAL load: STD_LOGIC;
	SIGNAL entrada_banco: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL saida_banco: STD_LOGIC_VECTOR (15 DOWNTO 0);
	
	SIGNAL sel_entr_Banco: STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL sel_saida_Banco: STD_LOGIC_VECTOR (1 DOWNTO 0);

	SIGNAL Entrada_REG_A: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL Entrada_REG_B: STD_LOGIC_VECTOR (15 DOWNTO 0);
		
	SIGNAL reg_A: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_A
	SIGNAL reg_B: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_B
	SIGNAL reg_R: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_R
	
	SIGNAL Result: STD_LOGIC_VECTOR (15 DOWNTO 0);			-- Sinal a ser mandado para o display
	
	SIGNAL OVERFLOW: STD_LOGIC;
	
BEGIN

	M_Entrada:	Modulo_entrada PORT MAP ( Switches, Reset, Operar, Validar, Clear, Executar, Valor );
	
	M_VAL :		ram_valores		PORT MAP ( clk, salvar_memo, reg_R, entrada_MEMO, saida_MEMO );
	
	INTRUCOES:  ram_comandos	PORT MAP ( clk, '0', endereco_atual, "0000000000000000", instrucao );
	
	M_ACESS: 	memory_acess	PORT MAP ( clk, Executar, Clear, instrucao, endereco_atual, cod_op, end_reg, constante, salvar_memo, load, sel_entr_Banco, sel_saida_Banco );
	
	B_REG:  Banco_Reg				PORT MAP ( reg_alvo , clk, load, entrada_banco, saida_banco );
	
	ULA_REG_A:	Registrador		PORT MAP (Entrada_REG_A, clk, '1', Ler_A, reg_A);	-- Registrador para o valor de A
	
	ULA_REG_B:	Registrador		PORT MAP (Entrada_REG_B, clk, '1', Ler_B, reg_B);	-- Registrador para o valor de B
	
	Unid_LA:		ULA 				PORT MAP (reg_A, reg_B , cod_op, Result, OVERFLOW);
	
	ULA_REG_R:	Registrador		PORT MAP (Result, clk, '1', '1', reg_R);	-- Registrador para o Resultado de A operado com B
	
	M_Saida:		Modulo_saida 	PORT MAP ( clk, '1', reg_R, "00", D1, D2, D3, D4, LED_16, LED_TERMINO );	
	
	WITH end_reg SELECT reg_alvo <=
		"00000001"	WHEN "000",
		"00000010"	WHEN "001",
		"00000100"	WHEN "010",
		"00001000"	WHEN "011",
		"00010000"	WHEN "100",
		"00100000"	WHEN "101",
		"01000000"	WHEN "110",
		"10000000"	WHEN "111";

	WITH sel_entr_Banco SELECT entrada_banco <=
		reg_R 		WHEN "00",
		saida_MEMO	WHEN "01",
		Valor 		WHEN "10",
		"0000000000000000" WHEN "11";
	
	Entrada_REG_A	<= saida_banco WHEN sel_saida_Banco = "00" ELSE "0000000000000000";
	
	WITH sel_saida_Banco SELECT Entrada_REG_B <=
		saida_banco WHEN "01",
		constante 	WHEN "10",
		"0000000000000000" WHEN OTHERS;

	entrada_MEMO 	<= saida_banco WHEN sel_saida_Banco = "11" ELSE "0000000000000000";
	
	Debug_A <= reg_A;
	Debug_B <= reg_B;
	
END arch;
