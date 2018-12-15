library verilog;
use verilog.vl_types.all;
entity Projeto_final is
    port(
        Switches        : in     vl_logic_vector(15 downto 0);
        Reset           : in     vl_logic;
        Operar          : in     vl_logic;
        Validar         : in     vl_logic;
        clk             : in     vl_logic;
        LER_A           : in     vl_logic;
        LER_B           : in     vl_logic;
        Debug_A         : out    vl_logic_vector(15 downto 0);
        Debug_B         : out    vl_logic_vector(15 downto 0);
        D1              : out    vl_logic_vector(6 downto 0);
        D2              : out    vl_logic_vector(6 downto 0);
        D3              : out    vl_logic_vector(6 downto 0);
        D4              : out    vl_logic_vector(6 downto 0);
        LED_16          : out    vl_logic_vector(15 downto 0);
        LED_TERMINO     : out    vl_logic
    );
end Projeto_final;
