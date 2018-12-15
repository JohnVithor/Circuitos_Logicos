LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_C IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			C: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_C IS

SIGNAL aux_C: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
	aux_C(0) <= NOT Y AND Z;
	aux_C(1) <= W AND NOT X;
	aux_C(2) <= NOT W AND X;
	aux_C(3) <= NOT W AND NOT Y;
	aux_C(4) <= NOT W AND Z;
	
	C <= aux_C(0) OR aux_C(1) OR aux_C(2) OR aux_C(3) OR aux_C(4);

END arch;