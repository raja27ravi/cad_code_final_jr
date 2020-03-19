library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fourmux is
port (
      
      sel: in std_logic_vector(1 downto 0):=(others=>'0');
      input_1,input_2,input_3,input_4 : in std_logic_vector ( 31 downto 0):=(others=>'0'); 
      output_mux : out std_logic_vector (31 downto 0):=(others=>'0')
     );
end fourmux;
architecture mux of fourmux is
begin
  
 output_mux <= input_1 when sel = "00" else

       input_2 when sel = "01" else

       input_3 when sel = "10" else
       input_4 when sel="11" else
     (others=>'0');
end mux;
  
