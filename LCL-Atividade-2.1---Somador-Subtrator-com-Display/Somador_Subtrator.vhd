LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Somador_Subtrator IS
	PORT ( 	A, B : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				Cin : IN STD_LOGIC;
				S : 	 OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
				Cout : OUT STD_LOGIC);
END;

ARCHITECTURE arq OF Somador_Subtrator IS
	COMPONENT FA
		PORT ( A, B, Cin: IN STD_LOGIC;
		S, Cout: OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL C: STD_LOGIC_VECTOR (15 DOWNTO 1);

BEGIN
	i0 : FA PORT MAP (A(0) , Cin xor B(0) , Cin ,	S(0) , C(1));
	i1 : FA PORT MAP (A(1) , Cin xor B(1) , C(1), 	S(1) , C(2));
	i2 : FA PORT MAP (A(2) , Cin xor B(2) , C(2), 	S(2) , C(3));
	i3 : FA PORT MAP (A(3) , Cin xor B(3) , C(3), 	S(3) , C(4));
	i4 : FA PORT MAP (A(4) , Cin xor B(4) , C(4), 	S(4) , C(5));
	i5 : FA PORT MAP (A(5) , Cin xor B(5) , C(5), 	S(5) , C(6));
	i6 : FA PORT MAP (A(6) , Cin xor B(6) , C(6), 	S(6) , C(7));
	i7 : FA PORT MAP (A(7) , Cin xor B(7) , C(7), 	S(7) , C(8));
	i8 : FA PORT MAP (A(8) , Cin xor B(8) , C(8), 	S(8) , C(9));
	i9 : FA PORT MAP (A(9) , Cin xor B(9) , C(9), 	S(9) , C(10));
	i10: FA PORT MAP (A(10), Cin xor B(10), C(10), 	S(10), C(11));
	i11: FA PORT MAP (A(11), Cin xor B(11), C(11), 	S(11), C(12));
	i12: FA PORT MAP (A(12), Cin xor B(12), C(12), 	S(12), C(13));
	i13: FA PORT MAP (A(13), Cin xor B(13), C(13), 	S(13), C(14));
	i14: FA PORT MAP (A(14), Cin xor B(14), C(14), 	S(14), C(15));
	i15: FA PORT MAP (A(15), Cin xor B(15), C(15), 	S(15), Cout);
END arq;