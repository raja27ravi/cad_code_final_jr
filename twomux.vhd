library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity twomux is
port (
      
      sel : in std_logic:='0';
      input_1: in std_logic_vector(31 downto 0):=  (others =>'0');
      input_2: in std_logic_vector(31 downto 0):=  (others =>'0');
      output_2mux : out std_logic_vector(31 downto 0):=  (others =>'0')
      );
end twomux;

architecture mux of twomux is
begin

output_2mux <= input_1 when sel = '0' else

       input_2 when sel = '1';
 
end mux;
   
