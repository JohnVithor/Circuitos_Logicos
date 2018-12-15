LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Display_F IS
	PORT (W,X,Y,Z: IN STD_LOGIC;
			F: OUT STD_LOGIC);
END;

ARCHITECTURE arch OF Display_F IS

SIGNAL aux_F: STD_LOGIC_VECTOR (4 DOWNTO 0);

BEGIN
	aux_F(0) <= NOT Y AND NOT Z;
	aux_F(1) <= W AND NOT X;
	aux_F(2) <= NOT W AND X AND NOT Y;
	aux_F(3) <= X AND NOT Z;
	aux_F(4) <= W AND Y;
			
	F <= aux_F(0) OR aux_F(1) OR aux_F(2) OR aux_F(3) OR aux_F(4);

END arch;