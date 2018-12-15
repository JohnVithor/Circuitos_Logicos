LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_E IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			E: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_E IS

SIGNAL aux_E: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
	aux_E(0) <= W AND X;
	aux_E(1) <= NOT X AND NOT Z;
	aux_E(2) <= W AND Y;
	aux_E(3) <= Y AND NOT Z;
	
	E <= aux_E(0) OR aux_E(1) OR aux_E(2) OR aux_E(3);

END arch;