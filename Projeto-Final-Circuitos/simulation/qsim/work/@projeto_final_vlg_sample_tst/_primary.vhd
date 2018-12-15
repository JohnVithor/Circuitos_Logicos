library verilog;
use verilog.vl_types.all;
entity Projeto_final_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        LER_A           : in     vl_logic;
        LER_B           : in     vl_logic;
        Operar          : in     vl_logic;
        Reset           : in     vl_logic;
        Switches        : in     vl_logic_vector(15 downto 0);
        Validar         : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Projeto_final_vlg_sample_tst;
