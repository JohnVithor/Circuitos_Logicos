LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_D IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			D: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_D IS

SIGNAL aux_D: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
	aux_D(0) <= W AND NOT Y;
	aux_D(1) <= NOT X AND Y AND Z;
	aux_D(2) <= NOT W AND NOT X AND NOT Z;
	aux_D(3) <= X AND Y AND NOT Z;
	aux_D(4) <= X AND NOT Y AND Z;
	
	D <= NOT (aux_D(0) OR aux_D(1) OR aux_D(2) OR aux_D(3) or aux_D(4));

END arch;