library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity add4 is
  port(clk:std_logic;
  Mem_WB_regwrite:in std_logic;
  WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
  regwrite_out:out std_logic;
  memreg_out:out std_logic;
  mem_out:out std_logic_vector(31 downto 0);
  Mem_WB_aluoutput:out std_logic_vector(31 downto 0);
  Mem_WB_Rd:out std_logic_vector(3 downto 0)
  );
end add4;
architecture behave of add4 is
component IF_ID_EX_stage is
  port(clk:in std_logic;
  Mem_WB_RegWrite:in std_logic;
  Mem_WB_Rd: in std_logic_vector(3 downto 0);
  WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
  EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0');
  EX_Mem_memread: out std_logic:='0';
  EX_Mem_RegWrite:out std_logic:='0';
  EX_Mem_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
  EX_Mem_memreg:out std_logic:='0';
  EX_Mem_memwrite:out std_logic:='0';
  EX_Mem_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0');
  Mem_WB_MemRead:in std_logic
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
     mux2_out:out std_logic_vector(3 downto 0):=(others=>'0');
     Mem_WB_MemRead:out std_logic
   );
end component;

signal EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_memreg,EX_Mem_memwrite,Mem_WB_MemRead: std_logic;
signal EX_Mem_Rd,Mem_WB_Rd_signal: std_logic_vector(3 downto 0);
signal EX_Mem_aluoutput,EX_Mem_Rdata2:std_logic_vector(31 downto 0);
begin
X1:IF_ID_EX_stage port map(clk,Mem_WB_regwrite,Mem_WB_Rd_signal,WB_Mux_Wdata,EX_Mem_Rd,EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_aluoutput,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_Rdata2,Mem_WB_MemRead);
X2:mems port map(clk,EX_Mem_memread,EX_Mem_RegWrite,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_aluoutput,EX_Mem_Rdata2,EX_Mem_Rd,regwrite_out,memreg_out,mem_out,Mem_WB_aluoutput,Mem_WB_Rd_signal,Mem_WB_MemRead);
Mem_WB_Rd<=Mem_WB_Rd_signal;
end behave;

