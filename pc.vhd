library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 entity pc is
  port(
       clk: in std_logic;
       mux_input:in std_logic_vector(31 downto 0):=(others=>'0');
       pc_output:out std_logic_vector(31 downto 0):=(others=>'0')
      );
 end pc;
architecture counter of pc is
begin
 process(clk)
   begin
    if(rising_edge(clk)) then
     pc_output<=mux_input;
  
    end if;
end process;
end counter;
  
