-- Dupla:
-- Joao Victor Venceslau Coelho
-- Josivan Medeiros da Silva Gois

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modulo_saida is
    port (
        clock  	: in std_logic;
        end_alg   : in std_logic;
		  result		: in std_logic_vector( 15 downto 0 );
        t_alg 		: in std_logic_vector( 1 downto 0 );
		  
        D1,D2,D3,D4	: out STD_LOGIC_VECTOR (6 DOWNTO 0);		-- Displays para os numeros
		  saida_LED		: out std_logic_vector( 15 downto 0 );		-- Mostra os bits do numero e outras informacoes
		  LED_Alg		: out std_logic	-- Indica que o algoritmo terminou
    );
end modulo_saida;

architecture arch of modulo_saida is

COMPONENT Display 
	PORT (W,X,Y,Z: 		IN STD_LOGIC;				-- Bits do número a ser mostrado no display (Hexadeciaml)
			A,B,C,D,E,F,G:	OUT STD_LOGIC);			-- Segmentos do display que serão acesos
END COMPONENT;

COMPONENT Registrador
	PORT ( entrada_r : IN STD_LOGIC_VECTOR (15 DOWNTO 0);	-- Numero a ser registrado
			clk_r, ld_r, escolhido_r: IN STD_LOGIC;			-- Clock, indica se a entrada será registrada, indica se o registrador é o certo
			saida_r : OUT STD_LOGIC_VECTOR (15 DOWNTO 0) ); -- Numero atualmente registrado / novo numero registrado
END COMPONENT;

begin
	-- Precisa criar component registrador
	-- reg_cont : PORT MAP ();
    process ( clock, result )
    begin
        if ( clock'event and clock = '1' ) then
            -- Fim de algoritmo mostra o resultado e indica fim de algoritmo
            if ( end_alg = '1' ) then
                LED_alg <= '1'; 
					 saida_LED <= result;
				-- 
				elsif ( t_alg = "00" ) then
					saida_LED(0) <= '1';
            end if;
        end if;
    end process;
	 
	 -- Digitos do número a ser mostrado
	dS0 : Display PORT MAP (result(15),result(14),result(13),result(12),		D1(6),D1(5),D1(4),D1(3),D1(2),D1(1),D1(0));
	dS1 : Display PORT MAP (result(11),result(10),result(9) ,result(8) ,		D2(6),D2(5),D2(4),D2(3),D2(2),D2(1),D2(0));
	dS2 : Display PORT MAP (result(7) ,result(6) ,result(5) ,result(4) ,		D3(6),D3(5),D3(4),D3(3),D3(2),D3(1),D3(0));
	dS3 : Display PORT MAP (result(3) ,result(2) ,result(1) ,result(0) ,		D4(6),D4(5),D4(4),D4(3),D4(2),D4(1),D4(0));
	 
end arch;