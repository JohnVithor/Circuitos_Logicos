LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Somador_Subtrator_Display IS
	PORT ( 	A, B :			IN STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Entradas
				Operacao :		IN STD_LOGIC;									-- Operação
				S :				OUT STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Saidas
				Cout :			OUT STD_LOGIC;									-- Indica overflow
				A1,A2,A3,A4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para o numero A
				B1,B2,B3,B4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para o numero B
				S1,S2,S3,S4 :	OUT STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para o numero S (resultado de A e B operados)
				Led_operacao, Led_termino : OUT STD_LOGIC					-- Indica a operaçao e o fim da operaçao indicada
				);
END;

ARCHITECTURE arq OF Somador_Subtrator_Display IS
	
	COMPONENT Somador_Subtrator IS
		PORT (A, B :	IN STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Números a serem operados
				Cin :		IN STD_LOGIC;									-- Bit que representa a operação que será realizada
				S :		OUT STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Resultado da operaçao
				Cout :	OUT STD_LOGIC);								-- Indica se houve overflow durante após operação
	END COMPONENT;
	
	COMPONENT Display 
		PORT (W,X,Y,Z: 		IN STD_LOGIC;				-- Bits do número a ser mostrado no display (Hexadeciaml)
				A,B,C,D,E,F,G:	OUT STD_LOGIC);			-- Segmentos do display que serão acesos
	END COMPONENT;
	
	SIGNAL C	: STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Para mostrar o resultado no display
	SIGNAL C2: STD_LOGIC_VECTOR (15 DOWNTO 0);		-- Para verificar o término da soma/subtraçao

BEGIN

	-- Informa qual a operação que será/(está sendo) realizada	(1 soma e 0 subtraçao)
	Led_operacao <= NOT Operacao;
	
	-- Digitos do primeiro número
	dA0 : Display PORT MAP (A(15),A(14),A(13),A(12),		A1(6),A1(5),A1(4),A1(3),A1(2),A1(1),A1(0));
	dA1 : Display PORT MAP (A(11),A(10),A(9) ,A(8) ,		A2(6),A2(5),A2(4),A2(3),A2(2),A2(1),A2(0));
	dA2 : Display PORT MAP (A(7) ,A(6) ,A(5) ,A(4) ,		A3(6),A3(5),A3(4),A3(3),A3(2),A3(1),A3(0));
	dA3 : Display PORT MAP (A(3) ,A(2) ,A(1) ,A(0) ,		A4(6),A4(5),A4(4),A4(3),A4(2),A4(1),A4(0));
	
	-- Digitos do segundo número
	dB0 : Display PORT MAP (B(15),B(14),B(13),B(12),		B1(6),B1(5),B1(4),B1(3),B1(2),B1(1),B1(0));
	dB1 : Display PORT MAP (B(11),B(10),B(9) ,B(8) ,		B2(6),B2(5),B2(4),B2(3),B2(2),B2(1),B2(0));
	dB2 : Display PORT MAP (B(7) ,B(6) ,B(5) ,B(4) ,		B3(6),B3(5),B3(4),B3(3),B3(2),B3(1),B3(0));
	dB3 : Display PORT MAP (B(3) ,B(2) ,B(1) ,B(0) ,		B4(6),B4(5),B4(4),B4(3),B4(2),B4(1),B4(0));

	-- Realizando a operação
	sAB : Somador_Subtrator PORT MAP (A, B ,Operacao ,C , Cout);
	-- Mandando o resultado para a saída
	S <= C;
	
	-- Digitos do número resultante da operação
	dS0 : Display PORT MAP (C(15),C(14),C(13),C(12),		S1(6),S1(5),S1(4),S1(3),S1(2),S1(1),S1(0));
	dS1 : Display PORT MAP (C(11),C(10),C(9) ,C(8) ,		S2(6),S2(5),S2(4),S2(3),S2(2),S2(1),S2(0));
	dS2 : Display PORT MAP (C(7) ,C(6) ,C(5) ,C(4) ,		S3(6),S3(5),S3(4),S3(3),S3(2),S3(1),S3(0));
	dS3 : Display PORT MAP (C(3) ,C(2) ,C(1) ,C(0) ,		S4(6),S4(5),S4(4),S4(3),S4(2),S4(1),S4(0));
	
	-- Verifica se a operação já foi finalizada ( Observação:  não sei se funciona ) 
	PROCESS (C) IS 
		BEGIN
			C2 <= C;
			IF (C = C2) THEN
				Led_termino <= '1';
			ElSE
				Led_termino <= '0';
			END IF;
		END PROCESS;
END arq;