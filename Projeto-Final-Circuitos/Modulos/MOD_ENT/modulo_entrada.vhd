LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--  Módulo de entrada de operação 
ENTITY Modulo_entrada IS	
	PORT( Switches:		IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Reset :			IN STD_LOGIC;
			Operar :			IN STD_LOGIC;
			Validar :		IN STD_LOGIC;
			
--			Operacao:		IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			Clear:			OUT STD_LOGIC;
			Executar:		OUT STD_LOGIC;
			Valor:			OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
			
END;

ARCHITECTURE arch of Modulo_entrada IS

BEGIN

	Valor <= Switches WHEN Validar = '1' ELSE "0000000000000000";
	Clear <= Reset;
	Executar <= Operar;

END arch;
