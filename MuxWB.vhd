-- 2 input mux in Wb stage to select Read Data / ALU output

library ieee;

use IEEE.std_logic_1164.all;

use IEEE.numeric_std.all;

 

entity MuxWB is

  port(

    Mem_Reg: in std_logic:='0';

    Output_ALUW, ReadDataW: in std_logic_vector(31 downto 0):=(others=>'0');

    ResultW: out std_logic_vector(31 downto 0):=(others=>'0')

  );

end MuxWB;

 

architecture Behavioral of MuxWB is

begin

  ResultW <= Output_ALUW  when  Mem_Reg='0' else

             ReadDataW when Mem_Reg='1' else

             (others=>'0');

end Behavioral;
