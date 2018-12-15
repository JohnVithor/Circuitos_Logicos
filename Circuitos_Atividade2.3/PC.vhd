LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY PC IS
	PORT	(	clk: 			IN STD_LOGIC;
				LER_A: 		IN STD_LOGIC;
				LER_B:		IN STD_LOGIC;
				INI_DIV:		IN STD_LOGIC;
				FIM_DIV:		IN STD_LOGIC;
				load_A:		OUT STD_LOGIC;
				load_B:		OUT STD_LOGIC;
				clear:		OUT STD_LOGIC;
				operar:		OUT STD_LOGIC
			);
END;

ARCHITECTURE arch OF PC IS
TYPE estado IS ( EM_ESPERA, LENDO_A, LENDO_B, OPERANDO );
SIGNAL E : estado := EM_ESPERA ;
BEGIN
	PROCESS ( clk, LER_A, LER_B, INI_DIV, FIM_DIV,  E )
	BEGIN
		IF (clk'event AND clk = '1') THEN
			CASE E IS
			WHEN EM_ESPERA =>
				IF ( LER_A = '1' AND LER_B = '0' ) THEN
					E <= LENDO_A;
				ELSIF ( LER_A = '0' AND LER_B = '1' ) THEN
					E <= LENDO_B;
				ELSIF ( INI_DIV = '1' ) THEN
					E <= OPERANDO;
					clear <= '1';
				ELSE
					E <= EM_ESPERA;
				END IF;
			WHEN LENDO_A =>
				E <= EM_ESPERA;
			WHEN LENDO_B =>
				E <= EM_ESPERA;
			WHEN OTHERS =>
				IF ( FIM_DIV = '1' ) THEN
					E <= EM_ESPERA;
				ELSE
					E <= OPERANDO;
				END IF;
			END CASE;
		END IF;
		IF ( E = EM_ESPERA ) THEN
			load_A <= '0';
			load_B <= '0';
			clear <= '0';
			operar <= '0';
		ELSIF ( E = LENDO_A ) THEN
			load_A <= '1';
			load_B <= '0';
			clear <= '0';
			operar <= '0';
		ELSIF ( E = LENDO_B ) THEN
			load_A <= '0';
			load_B <= '1';
			clear <= '0';
			operar <= '0';
		ELSE
			load_A <= '0';
			load_B <= '0';
			clear <= '0';
			operar <= '1';
		END IF;
	END PROCESS;
END arch;
