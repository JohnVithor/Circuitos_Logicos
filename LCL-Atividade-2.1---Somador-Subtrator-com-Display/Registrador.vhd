LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Registrador IS
	PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			clk_r, ld_r, escolhido_r: IN STD_LOGIC;
			saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
END;

ARCHITECTURE arch OF Registrador IS
BEGIN
	PROCESS (entrada_r, clk_r, ld_r, escolhido_r)
	BEGIN
		IF (escolhido_r = '1') THEN
			IF (clk_r'event AND clk_r = '1' AND ld_r = '1')	THEN
				saida_r <= entrada_r;
			END IF;
		END IF;
	END PROCESS;
END arch;