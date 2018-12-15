LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_G IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			G: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_G IS

SIGNAL aux_G: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
	aux_G(0) <= W AND NOT X;
	aux_G(1) <= Y AND NOT Z;
	aux_G(2) <= W AND Z;
	aux_G(3) <= NOT W AND X AND NOT Y;
	aux_G(4) <= NOT X AND Y;
	
	G <= NOT (aux_G(0) OR aux_G(1) OR aux_G(2) OR aux_G(3) OR aux_G(4));

END arch;