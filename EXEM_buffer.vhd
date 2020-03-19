library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_Std.all;
entity exembuff is
port (
       clk:in std_logic;
       mem_read:in std_logic:='0';
       reg_write:in std_logic:='0';
       mem_reg:in std_logic:='0';
       mem_write: in std_logic:='0';
       alu_output:in std_logic_vector(31 downto 0):= (others=>'0');
       mux_Rd:in std_logic_vector(3 downto 0):= (others=>'0');
       ID_EX_Rdata2:in std_logic_vector(31 downto 0):= (others=>'0');
       out_memread: out std_logic:='0';
       out_regwrite: out std_logic:='0';
       out_memreg:out std_logic:='0';
       out_memwrite:out std_logic:='0';
       out_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
       out_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0');
       out_EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0') 
     );
end exembuff;
architecture buff of exembuff is
begin
 process(clk)
    begin
     if(falling_edge(clk)) then
     out_memread <= mem_read;
     out_regwrite <= reg_write;
     out_memreg <= mem_reg;
     out_memwrite <= mem_write;
     out_aluoutput <= alu_output;
     out_Rdata2<=ID_EX_Rdata2;
     out_EX_Mem_Rd<=mux_Rd;
     end if;
   end process;
end buff;
