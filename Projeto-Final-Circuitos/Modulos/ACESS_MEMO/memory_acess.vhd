LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY memory_acess IS
    PORT (
       clk:					IN STD_LOGIC;
		 Operar:				IN STD_LOGIC;
       Clear:				IN STD_LOGIC;
		 instrucao:			IN STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 
		 endereco_atual:	OUT STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 cod_op:				OUT STD_LOGIC_VECTOR( 3 DOWNTO 0 );
		 end_reg:			OUT STD_LOGIC_VECTOR( 2 DOWNTO 0 );
		 constante:			OUT STD_LOGIC_VECTOR( 15 DOWNTO 0 );
		 
		 salvar_memo:		OUT STD_LOGIC;
		 load:				OUT STD_LOGIC;
		 sel_entr_Banco:	OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 );
		 sel_saida_Banco:	OUT STD_LOGIC_VECTOR( 1 DOWNTO 0 )
    );
END memory_acess;

ARCHITECTURE arch OF memory_acess IS

	SIGNAL operacao : STD_LOGIC_VECTOR( 3 DOWNTO 0 );

BEGIN
	
	PROCESS ( clk, instrucao, operacao )
	VARIABLE constador_instrucoes: STD_LOGIC_VECTOR( 15 DOWNTO 0 ) := "0000000000000000";
	VARIABLE reg_atual: STD_LOGIC_VECTOR( 1 DOWNTO 0 ) := "00";
	BEGIN
		IF ( clk'EVENT AND clk = '1' ) THEN
			operacao <= instrucao(15) & instrucao(14) & instrucao(13) & instrucao(12);
			
			IF ( Operar = '1') THEN
				constador_instrucoes := constador_instrucoes + 1;
				reg_atual := "00";
			ELSIF ( Clear = '1' ) THEN 
				constador_instrucoes := "0000000000000000";
				reg_atual := "00";
			END IF;
		
			load <= '0';
			salvar_memo <= '0';
			sel_saida_Banco <= "00";
			sel_entr_Banco <= "00";
			end_reg <= "000";
			
			IF ( operacao = "0000" OR operacao = "0001" OR operacao = "0010" OR operacao = "0011" OR operacao = "0100") THEN
				IF ( reg_atual = "00") THEN 
					end_reg <= instrucao(8) & instrucao(7) & instrucao(6);
					reg_atual := "01";
					load <= '0';
					sel_saida_Banco <= "00";
				ELSIF ( reg_atual = "01") THEN 
					end_reg <= instrucao(5) & instrucao(4) & instrucao(3);
					reg_atual := "10";
					load <= '0';
					sel_saida_Banco <= "01";
				ELSIF ( reg_atual = "10") THEN 	
					end_reg <= instrucao(11) & instrucao(10) & instrucao(9);
					reg_atual := "11";
					load <= '1';
					sel_entr_Banco <= "00";
				ELSE
					end_reg <= "000";
				END IF;
			ELSIF	( operacao = "0101" OR operacao = "0110" ) THEN
				IF ( reg_atual = "00") THEN 
					end_reg <= instrucao(5) & instrucao(4) & instrucao(3);
					reg_atual := "01";
					load <= '0';
					sel_saida_Banco <= "00";
				ELSIF ( reg_atual = "01") THEN 
					end_reg <= instrucao(11) & instrucao(10) & instrucao(9);
					reg_atual := "10";
					load <= '1';
					sel_entr_Banco <= "00";
				ELSE
					end_reg <= "000";
				END IF;
			ELSIF	( operacao = "1000" ) THEN
				IF ( reg_atual = "00") THEN 
					end_reg <= instrucao(5) & instrucao(4) & instrucao(3);
					load <= '0';
					sel_saida_Banco <= "00";
					reg_atual := "01";
				ELSIF ( reg_atual = "01") THEN
					sel_saida_Banco <= "10";
					reg_atual := "10";
				ELSIF ( reg_atual = "10") THEN
					end_reg <= instrucao(11) & instrucao(10) & instrucao(9);
					IF (instrucao(8 DOWNTO 0) = "000000000") THEN
						sel_entr_Banco <= "10";
					ELSE
						sel_entr_Banco <= "01";
					END IF;
					
					load <= '1';
					reg_atual := "11";
				ELSE
					end_reg <= "000";
				END IF;
				
			ELSIF	( operacao = "1001" ) THEN
				IF ( reg_atual = "00") THEN 
					end_reg <= instrucao(5) & instrucao(4) & instrucao(3);
					load <= '0';
					sel_saida_Banco <= "00";
					reg_atual := "01";
				ELSIF ( reg_atual = "01") THEN
					sel_saida_Banco <= "10";
					reg_atual := "10";
				ELSIF ( reg_atual = "10") THEN
					end_reg <= instrucao(11) & instrucao(10) & instrucao(9);
					sel_saida_Banco <= "11";
					salvar_memo <= '1';
					reg_atual := "11";
				ELSE
					end_reg <= "000";
				END IF;
				
			ELSIF	( operacao = "1110" ) THEN
				IF ( reg_atual = "00") THEN 
					end_reg <= instrucao(5) & instrucao(4) & instrucao(3);
					load <= '0';
					sel_saida_Banco <= "00";
					reg_atual := "01";
				ELSIF ( reg_atual = "01") THEN
					sel_saida_Banco <= "10";
					reg_atual := "10";
				ELSIF ( reg_atual = "10") THEN
					end_reg <= instrucao(11) & instrucao(10) & instrucao(9);
					sel_entr_Banco <= "00";
					load <= '1';
					reg_atual := "11";
				ELSE
					end_reg <= "000";
				END IF;
			ELSE
				load <= '0';
				salvar_memo <= '0';
				end_reg <= "000";
			END IF;
		END IF;
		
		constante <= "0000000000" & instrucao(5) & instrucao(4) & instrucao(3) & instrucao(2) & instrucao(1) & instrucao(0);
		cod_op <= operacao;
		endereco_atual <= constador_instrucoes;
		
	END PROCESS;
    
END arch;