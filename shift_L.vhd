library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity shift_L is
port(
     shift2_in: in std_logic_vector(31 downto 0);
     shift2_out:out std_logic_vector(31 downto 0));
end shift_L;
architecture shift of shift_L is
begin
shift2_out <= shift2_in(29 downto 0)&"00";
end shift;