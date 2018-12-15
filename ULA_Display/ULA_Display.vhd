LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Unidade Lógica e Aritimética Com Display
ENTITY ULA_Display IS	
	PORT (I: 				IN STD_LOGIC_VECTOR(15 DOWNTO 0);		-- Entradas ( Tanto o A como o B )
			A_or_B :			IN STD_LOGIC_VECTOR (1 DOWNTO 0);		-- Indica qual é o numero que entrou
			clk: 				IN STD_LOGIC;									-- Clock
			M: 				IN STD_LOGIC;									-- Indica o modo lógico e o aritmetico
			SELETOR: 		IN STD_LOGIC_VECTOR(1 DOWNTO 0);			-- Indica qual operaçao será realizada
			D1,D2,D3,D4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para os numeros
			LED_TERMINO : 	OUT STD_LOGIC;									-- Indica o fim da operaçao
			debug_ULA :  OUT STD_LOGIC_VECTOR(15 DOWNTO 0);			-- Informa qual o resultado da ULA, para testes
			OVERFLOW: 		OUT STD_LOGIC);								-- Indica overflow
END;		

ARCHITECTURE arch OF ULA_Display IS

	COMPONENT Registrador
		PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Numero a ser registrado
				clk_r, ld_r, escolhido_r: IN STD_LOGIC;			-- Clock, indica se a entrada será registrada, indica se o registrador é o certo
				saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) ); -- Numero atualmente registrado / novo numero registrado
	END COMPONENT;
	
	COMPONENT Display 
		PORT (W,X,Y,Z: 		IN STD_LOGIC;				-- Bits do número a ser mostrado no display (Hexadeciaml)
				A,B,C,D,E,F,G:	OUT STD_LOGIC);			-- Segmentos do display que serão acesos
	END COMPONENT;
	
	COMPONENT ULA												
		PORT (A,B: IN STD_LOGIC_VECTOR(15 DOWNTO 0);	-- Entradas da ULA
			M: IN STD_LOGIC;									-- Modo da ULA. Aritimético ou lógico
			SELETOR: IN STD_LOGIC_VECTOR(1 DOWNTO 0);	-- Operaçao que a ULA irá realizar
			SAIDA: OUT STD_LOGIC_VECTOR(15 DOWNTO 0); -- Resultado da operaçao
			COUT: OUT STD_LOGIC);							-- Indica se ocorreu overflow durante a operaçao
	END COMPONENT;
	
	SIGNAL C	: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Armazena o resultado da operação
	SIGNAL reg_A: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_A
	SIGNAL reg_B: STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Utiliza o valor do registrador reg_B
	SIGNAL D: STD_LOGIC_VECTOR (15 DOWNTO 0);			-- Sinal a ser mandado para o display
	
BEGIN

	i0: Registrador PORT MAP (I, clk, '1', A_or_B(0), reg_A);	-- Registrador para o valor de A
	i1: Registrador PORT MAP (I, clk, '1', A_or_B(1), reg_B);	-- Registrador para o valor de B
	
	PROCESS (A_or_B,C,reg_A,reg_B) IS 		-- Processo que verifica qual valor está sendo mostrado no display e se a operaçao terminou
	BEGIN
		IF (A_or_B = "00") THEN
			D <= C;
			Led_termino <= '1';
		ELSIF (A_or_B = "01") THEN
			D <= reg_A;
			Led_termino <= '0';
		ELSIF (A_or_B = "10") THEN
			D <= reg_B;		
			Led_termino <= '0';
		ElSE
			D <= "0000000000000000";
			Led_termino <= '0';
		END IF;
	END PROCESS;
		
	-- Digitos do número a ser mostrado
	dS0 : Display PORT MAP (D(15),D(14),D(13),D(12),		D1(6),D1(5),D1(4),D1(3),D1(2),D1(1),D1(0));
	dS1 : Display PORT MAP (D(11),D(10),D(9) ,D(8) ,		D2(6),D2(5),D2(4),D2(3),D2(2),D2(1),D2(0));
	dS2 : Display PORT MAP (D(7) ,D(6) ,D(5) ,D(4) ,		D3(6),D3(5),D3(4),D3(3),D3(2),D3(1),D3(0));
	dS3 : Display PORT MAP (D(3) ,D(2) ,D(1) ,D(0) ,		D4(6),D4(5),D4(4),D4(3),D4(2),D4(1),D4(0));
	
	U : ULA PORT MAP (reg_A, reg_B ,M ,SELETOR, C, OVERFLOW);
	
	debug_ULA <= C;
	
END arch;
