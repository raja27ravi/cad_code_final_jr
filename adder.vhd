library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_Std.all;

entity adder is
port(
     
     pc_input:in std_logic_vector(31 downto 0):=  (others =>'0');    
     adder_output:out std_logic_vector(31 downto 0):=  (others =>'0')
     );
end adder;
architecture add of adder is

begin
  
     adder_output<= std_logic_vector(unsigned(pc_input) + X"4");
    
end add;
    
