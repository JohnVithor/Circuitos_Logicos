LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_B IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			B: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_B IS

SIGNAL aux_B: STD_LOGIC_VECTOR (5 DOWNTO 0);

BEGIN
	aux_B(0) <= NOT W AND NOT X;
	aux_B(1) <= NOT X AND NOT Y;
	aux_B(2) <= NOT W AND NOT Y AND NOT Z;
	aux_B(3) <= NOT W AND Y AND Z;
	aux_B(4) <= W AND NOT Y AND Z;
	aux_B(5) <= NOT X AND Y AND NOT Z;
	
	B <= NOT (aux_B(0) OR aux_B(1) OR aux_B(2) OR aux_B(3) OR aux_B(4) OR aux_B(5));

END arch;