library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity threemux is
port (
      
      sel : in std_logic_vector(1 downto 0);
      input_1 : in std_logic_vector ( 31 downto 0);
      input_2: in std_logic_vector (31 downto 0);
      input_3 : in std_logic_vector (31 downto 0);
      output_mux : out std_logic_vector (31 downto 0)
     );
end threemux;
architecture mux of threemux is
begin

output_mux <= input_1 when sel = "00" else

       input_2 when sel = "01" else

       input_3 when sel = "10";
end mux;
  
