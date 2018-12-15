LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Banco_Reg IS
	PORT (reg_alvo: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			clk, load: IN STD_LOGIC;
			entrada: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
			saida: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END;

ARCHITECTURE arch OF Banco_Reg IS
	COMPONENT Registrador
		PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				clk_r, ld_r, escolhido_r: IN STD_LOGIC;
				saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) );
	END COMPONENT;
	
	SIGNAL reg_alvo_aux: STD_LOGIC_VECTOR (3 DOWNTO 0);
	
	SIGNAL reg_0: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_1: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_2: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_3: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_4: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_5: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_6: STD_LOGIC_VECTOR (15 DOWNTO 0);
	SIGNAL reg_7: STD_LOGIC_VECTOR (15 DOWNTO 0);
	
BEGIN
	i0: Registrador PORT MAP (entrada, clk, load, reg_alvo(0), reg_0);
	i1: Registrador PORT MAP (entrada, clk, load, reg_alvo(1), reg_1);
	i2: Registrador PORT MAP (entrada, clk, load, reg_alvo(2), reg_2);
	i3: Registrador PORT MAP (entrada, clk, load, reg_alvo(3), reg_3);
	i4: Registrador PORT MAP (entrada, clk, load, reg_alvo(4), reg_4);
	i5: Registrador PORT MAP (entrada, clk, load, reg_alvo(5), reg_5);
	i6: Registrador PORT MAP (entrada, clk, load, reg_alvo(6), reg_6);
	i7: Registrador PORT MAP (entrada, clk, load, reg_alvo(7), reg_7);
	
	WITH reg_alvo SELECT
		reg_alvo_aux <= "0000" WHEN "00000001",
							 "0001" WHEN "00000010",
							 "0010" WHEN "00000100",
							 "0011" WHEN "00001000",
							 "0100" WHEN "00010000",
							 "0101" WHEN "00100000",
							 "0110" WHEN "01000000",
							 "0111" WHEN "10000000",
							 "1111" WHEN OTHERS;
	
	WITH reg_alvo_aux SELECT
		saida <= reg_0 WHEN "0000",
					reg_1 WHEN "0001",
					reg_2 WHEN "0010",
					reg_3 WHEN "0011",
					reg_4 WHEN "0100",
					reg_5 WHEN "0101",
					reg_6 WHEN "0110",
					reg_7 WHEN "0111",
					"0000000000000000" WHEN OTHERS;
END arch;