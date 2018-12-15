LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY PO IS
	PORT	(	clk: 			IN STD_LOGIC;
				Numero: 		IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				load_A:		IN STD_LOGIC;
				load_B:		IN STD_LOGIC;
				clear:		IN STD_LOGIC;
				operar:		IN STD_LOGIC;
				FIM_DIV:		OUT STD_LOGIC;
				Quociente:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
				test:			OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);
END;

ARCHITECTURE arch OF PO IS

	COMPONENT Registrador
		PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				clk_r, ld_r: IN STD_LOGIC;
				saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
	END COMPONENT;
	
	SIGNAL A: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL B: STD_LOGIC_VECTOR(15 DOWNTO 0);
	
	SIGNAL contador_subtracoes : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL nova_subtracao : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	
BEGIN

	j0 : Registrador PORT MAP( Numero, clk, load_A, A );
	j1 : Registrador PORT MAP( Numero, clk, load_B, B );
	
	PROCESS( clk, Numero, load_A, load_B, clear, operar , A, B , contador_subtracoes )
	VARIABLE temp: STD_LOGIC_VECTOR(15 DOWNTO 0) := A;
	BEGIN
		IF ( operar = '1' ) THEN
			temp := temp - B;
			nova_subtracao <= contador_subtracoes + 1;
			test <= temp;
		END IF;
		IF ( temp < B ) THEN
			FIM_DIV <= '1';
		ELSE
			FIM_DIV <= '0';
		END IF;
	END PROCESS;
	
	Q0 : Registrador PORT MAP( nova_subtracao, clk, operar OR clear, contador_subtracoes );
	
	Quociente <= contador_subtracoes;
	
END arch;