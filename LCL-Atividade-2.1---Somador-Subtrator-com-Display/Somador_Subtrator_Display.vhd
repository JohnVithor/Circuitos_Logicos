-- João Vítor Venceslau Coelho
-- Josivan Medeiros da Silva Gois

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Somador_Subtrator_Display IS
	PORT ( 	I :				IN STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Entradas ( Tanto o A como o B )
				A_or_B :			IN STD_LOGIC_VECTOR (1 DOWNTO 0);		-- Indica qual é o numero que entrou
				clk :				IN STD_LOGIC;									-- clock
				Operacao :		IN STD_LOGIC;									-- Operação
				guardar :		IN STD_LOGIC;									-- guarda entrada
				S :				OUT STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Saida
				D1,D2,D3,D4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para os numeros ( Tanto o A B e o S )
				Led_operacao, Led_termino : OUT STD_LOGIC;				-- Indica a operaçao e o fim da operaçao indicada
				Led_A, Led_B : OUT STD_LOGIC									-- Indica qual o numero de entrada mostrado no display
				);
END;

ARCHITECTURE arq OF Somador_Subtrator_Display IS
	COMPONENT Registrador
		PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				clk_r, ld_r, escolhido_r: IN STD_LOGIC;
				saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
	END COMPONENT;
	
	COMPONENT Somador_Subtrator IS
		PORT (A, B :	IN STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Números a serem operados
				Cin :		IN STD_LOGIC;									-- Bit que representa a operação que será realizada
				S :		OUT STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Resultado da operaçao
				Cout :	OUT STD_LOGIC);								-- Indica se houve overflow após a operação
	END COMPONENT;
	
	COMPONENT Display 
		PORT (W,X,Y,Z: 		IN STD_LOGIC;				-- Bits do número a ser mostrado no display (Hexadeciaml)
				A,B,C,D,E,F,G:	OUT STD_LOGIC);			-- Segmentos do display que serão acesos
	END COMPONENT;
	
	SIGNAL Cout	: STD_LOGIC;
	SIGNAL C	: STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Armazena o resultado da operação
	SIGNAL reg_A: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_A
	SIGNAL reg_B: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_B
	SIGNAL D: STD_LOGIC_VECTOR (15 DOWNTO 0);			-- Sinal a ser mandado para o display

BEGIN

	i0: Registrador PORT MAP (I, clk, guardar, A_or_B(0), reg_A);	-- Registrador para o valor de A
	i1: Registrador PORT MAP (I, clk, guardar, A_or_B(1), reg_B);	-- Registrador para o valor de B

	PROCESS (A_or_B,C,reg_A,reg_B) IS 		-- Processo que verifica qual valor está sendo mostrado no display e 
														-- também quais leds estão acesos
	BEGIN
		IF (A_or_B = "00") THEN
			D <= C;
			Led_A <= '0';
			Led_B <= '0';
			Led_termino <= '1';
		ELSIF (A_or_B = "01") THEN
			D <= reg_A;
			Led_A <= '1';
			Led_B <= '0';
			Led_termino <= '0';
		ELSIF (A_or_B = "10") THEN
			D <= reg_B;
			Led_A <= '0';
			Led_B <= '1';			
			Led_termino <= '0';
		ElSE
			D <= "0000000000000000";
			Led_A <= '0';
			Led_B <= '0';
			Led_termino <= '0';
		END IF;
	END PROCESS;
	
	-- Informa qual a operação que será/(está sendo) realizada	(1 soma e 0 subtraçao)
	Led_operacao <= NOT Operacao;
	
	-- Digitos do número a ser mostrado
	dS0 : Display PORT MAP (D(15),D(14),D(13),D(12),		D1(6),D1(5),D1(4),D1(3),D1(2),D1(1),D1(0));
	dS1 : Display PORT MAP (D(11),D(10),D(9) ,D(8) ,		D2(6),D2(5),D2(4),D2(3),D2(2),D2(1),D2(0));
	dS2 : Display PORT MAP (D(7) ,D(6) ,D(5) ,D(4) ,		D3(6),D3(5),D3(4),D3(3),D3(2),D3(1),D3(0));
	dS3 : Display PORT MAP (D(3) ,D(2) ,D(1) ,D(0) ,		D4(6),D4(5),D4(4),D4(3),D4(2),D4(1),D4(0));
	
	sAB : Somador_Subtrator PORT MAP (reg_A, reg_B ,Operacao ,C , Cout);
	
	-- Mandando o resultado para a saída
	S <= C;
END arq;