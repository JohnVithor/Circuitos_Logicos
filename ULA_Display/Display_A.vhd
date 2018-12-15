LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_A IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			A: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_A IS

SIGNAL aux_A: STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN
	aux_A(0) <= W AND NOT Z;
	aux_A(1) <= Y AND NOT Z;
	aux_A(2) <= NOT W AND Y;
	aux_A(3) <= X AND Y;
	aux_A(4) <= NOT W AND X AND Z;
	aux_A(5) <= NOT W AND NOT X AND NOT Z;
	aux_A(6) <= W AND NOT X AND NOT Y;

	A <= NOT (aux_A(0) OR aux_A(1) OR aux_A(2) OR aux_A(3) OR aux_A(4) OR aux_A(5) OR aux_A(6));

END arch;