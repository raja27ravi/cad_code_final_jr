library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Final is
port(clk:in std_logic:='0'
  );
end entity;
architecture behave of Final is
component add4 is
  port(clk:std_logic;
  Mem_WB_regwrite:in std_logic;
  WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
  regwrite_out:out std_logic;
  memreg_out:out std_logic;
  mem_out:out std_logic_vector(31 downto 0);
  Mem_WB_aluoutput:out std_logic_vector(31 downto 0);
  Mem_WB_Rd:out std_logic_vector(3 downto 0)
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

signal WB_Mux_Wdata,mem_out,Mem_WB_aluoutput:std_logic_vector(31 downto 0);
signal regwrite_out,memreg_out,Mem_WB_regwrite:std_logic;
signal Mem_WB_Rd:std_logic_vector(3 downto 0);

begin
X1:add4 port map(clk,Mem_WB_regwrite,WB_Mux_Wdata,regwrite_out,memreg_out,mem_out,Mem_WB_aluoutput,Mem_WB_Rd);
X2:twomux port map(memreg_out,Mem_WB_aluoutput,mem_out,WB_Mux_Wdata);
Mem_WB_regwrite<=regwrite_out;
end behave;