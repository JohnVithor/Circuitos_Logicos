library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_comandos is
    generic (
        DATA_WIDTH : integer := 16;
        ADDR_WIDTH : integer := 16
    );
    port (
        clock  : in std_logic;
        wren   : in std_logic;
        addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
        data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end ram_comandos;

architecture ram_arch of ram_comandos is
    type ram_t is array (0 to 2**ADDR_WIDTH - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);

    signal ram_image : ram_t := (

-- Algoritmo 1
		0  => 	"1000000000000000",
		1  => 	"1000001000000000",
		2  => 	"0110010000111111",
		3  => 	"0110000010111111",
		4  => 	"0101010001111111",
		5  => 	"0101011010111111",
		6  => 	"0000010011001111",
		7  => 	"0101011010111111",
		8  => 	"0000001011000111",
		9  => 	"1001001000000000",

-- Algoritmo 2
        10 =>	"1000001000000000",
        11 =>	"1000010000000000",
        12 =>	"1000011000000000",
        13 =>	"1110001001000000",
        14 =>	"0101010111010000",
        15 =>	"0110011111011000",
        16 =>	"0000001001010000",
        17 =>	"0001001001011000",

-- Algoritmo 3
		18 =>	"1000000000000000"
		19 =>	"1000001000000000"
		20 =>	"0011010000000111"
		21 =>	"0010011010001111"

-- Algoritmo 4
        22 =>	"1000001000000000",
        23 =>	"0110010111001000",
        24 =>	"0110010111010000",
        25 =>	"0000001001010000",

-- Comandos não utilizados
        26 =>	"1111000000000000",
        27 =>	"1111000000000000",
        28 =>	"1111000000000000",
        29 =>	"1111000000000000",
        30 =>	"1111000000000000",
        31 =>	"1111000000000000",
        32 =>	"1111000000000000",
        33 =>	"1111000000000000",
        others => "1111000000000000"
    );
begin
    process (clock)
    begin
        if clock'event and clock = '1' then
            data_o <= ram_image(to_integer(unsigned(addr)));

            if wren = '1' then
                ram_image(to_integer(unsigned(addr))) <= data_i;
            end if;
        end if;
    end process;
end ram_arch;
