library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity FDEMW_stage is
  port(clk:std_logic;
  jump_in:in std_logic_vector(31 downto 0)
  );
end FDEMW_stage;
architecture behave of FDEMW_stage is
component IF_ID_EX_stage is
  port(clk:in std_logic;
  jump_in:in std_logic_vector(31 downto 0);
  Mem_WB_RegWrite:in std_logic;
  Mem_WB_Rd: in std_logic_vector(3 downto 0);
  WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
  EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0');
  EX_Mem_memread: out std_logic:='0';
  EX_Mem_RegWrite:out std_logic:='0';
  EX_Mem_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
  EX_Mem_memreg:out std_logic:='0';
  EX_Mem_memwrite:out std_logic:='0';
  EX_Mem_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0')
  );
end component; 

component mems is
port(
     clk:in std_logic;
     mem_read,reg_write,mem_reg,mem_write:in std_logic:='0';
     alu_output,mux1_decode:in std_logic_vector(31 downto 0):=(others=>'0');
     mux2_decode:in std_logic_vector(3 downto 0):=(others=>'0');
     regwrite_out,memreg_out:out std_logic;
     mem_out,alu_out:out std_logic_vector(31 downto 0):=(others=>'0');
     mux2_out:out std_logic_vector(3 downto 0):=(others=>'0')
   );
end component;

component twomux is
port (
      
    sel : in std_logic;
      input_1: in std_logic_vector(31 downto 0);
      input_2: in std_logic_vector(31 downto 0);
      output_2mux : out std_logic_vector(31 downto 0)
      );
end component;

signal Mem_WB_RegWrite,EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_memreg,EX_Mem_memwrite,regwrite_out,memreg_out: std_logic;
signal Mem_WB_Rd,EX_Mem_Rd: std_logic_vector(3 downto 0);
signal WB_Mux_Wdata,EX_Mem_aluoutput,EX_Mem_Rdata2,mem_out:std_logic_vector(31 downto 0);
begin
X1:IF_ID_EX_stage port map(clk,jump_in,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_Rd,EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_aluoutput,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_Rdata2);
X2:mems port map(clk,EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_aluoutput,EX_Mem_Rdata2,EX_Mem_Rd,regwrite_out,memreg_out,mem_out,EX_Mem_aluoutput,Mem_WB_Rd);
X3:twomux port map(EX_Mem_memreg,EX_Mem_aluoutput,mem_out,WB_Mux_Wdata);
end behave;
