library verilog;
use verilog.vl_types.all;
entity Projeto_final_vlg_check_tst is
    port(
        D1              : in     vl_logic_vector(6 downto 0);
        D2              : in     vl_logic_vector(6 downto 0);
        D3              : in     vl_logic_vector(6 downto 0);
        D4              : in     vl_logic_vector(6 downto 0);
        Debug_A         : in     vl_logic_vector(15 downto 0);
        Debug_B         : in     vl_logic_vector(15 downto 0);
        LED_16          : in     vl_logic_vector(15 downto 0);
        LED_TERMINO     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end Projeto_final_vlg_check_tst;
