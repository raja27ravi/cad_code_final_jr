library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mems is
port(
     clk:in std_logic;
     mem_read,reg_write,mem_reg,mem_write:in std_logic:='0';
     alu_output,mux1_decode:in std_logic_vector(31 downto 0):=(others=>'0');
     mux2_decode:in std_logic_vector(3 downto 0):=(others=>'0');
     regwrite_out,memreg_out:out std_logic;
     mem_out,alu_out:out std_logic_vector(31 downto 0):=(others=>'0');
     mux2_out:out std_logic_vector(3 downto 0):=(others=>'0');
     Mem_WB_MemRead:out std_logic
   );
end mems;
architecture mem of mems is
component mips_memory is
 port(
      clk: in std_logic;
      mem_write : in std_logic:='0';
      mem_read : in std_logic:='0';
      alu_meminput : in std_logic_vector(31 downto 0):=(others=>'0');
      data_input : in std_logic_vector(31 downto 0):=(others=>'0');
      mem_output : out std_logic_vector(31 downto 0):=(others=>'0')
     );
end component;

component memwbbuff is
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
end component;
signal smem_out: std_logic_vector(31 downto 0);
begin
x1 : mips_memory port map(clk,mem_write,mem_read,alu_output,mux1_decode,smem_out);
x2 : memwbbuff port map (clk,reg_write,mem_reg,alu_output,smem_out,mux2_decode,regwrite_out,memreg_out,alu_out,mux2_out,mem_out,mem_read,Mem_WB_MemRead);
end mem;
