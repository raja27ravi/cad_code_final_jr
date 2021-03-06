library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memwbbuff is
port(
     clk:in std_logic;
     reg_write:in std_logic:='0';
     mem_reg:in std_logic:='0';
     alu_output:in std_logic_vector(31 downto 0):=(others=>'0');
     mem_output:in std_logic_vector(31 downto 0):=(others=>'0');
     EX_Mem_Reg_Rd: in std_logic_vector(3 downto 0):=(others=>'0');
     out_regwrite:out std_logic:='0';
     out_memreg:out std_logic:='0';
     out_aluoutput:out std_logic_vector(31 downto 0):=(others=>'0');
     Mem_WB_Reg_Rd: out std_logic_vector(3 downto 0):=(others=>'0');
     out_memoutput:out std_logic_vector(31 downto 0):=(others=>'0');
     Mem_WB_MemRead_in:in std_logic;
     Mem_WB_MemRead_out:out std_logic
    );
end memwbbuff;
architecture buff of memwbbuff is
begin
  process(clk)
    begin
      if(falling_edge(clk)) then
      out_regwrite<=reg_write;
      out_memreg<=mem_reg;
      out_aluoutput<=alu_output;
      Mem_WB_Reg_Rd<=EX_Mem_Reg_Rd;
      out_memoutput<=mem_output;
      Mem_WB_MemRead_out<=Mem_WB_MemRead_in;
      end if;
    end process;
end buff;