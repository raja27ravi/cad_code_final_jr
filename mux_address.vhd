library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_address is
port (
      
      sel : in std_logic;
      input_1: in std_logic_vector(3 downto 0);
      input_2: in std_logic_vector(3 downto 0);
      output_2mux : out std_logic_vector(3 downto 0)
      );
end mux_address;

architecture mux of mux_address is
begin

output_2mux <= input_1 when sel = '0' else

       input_2 when sel = '1' else

     (others=>'0');
 
end mux;
