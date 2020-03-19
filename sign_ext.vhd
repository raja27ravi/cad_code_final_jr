library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity sign_ext is
port(
     sign_in:in std_logic_vector(20 downto 0);
     sign_out:out std_logic_vector(31 downto 0));
end sign_ext;
architecture sign of sign_ext is
begin
   sign_out <= "11111111111" & sign_in(20 downto 0) when sign_in(20)='1' else
               "00000000000" & sign_in(20 downto 0);
end sign;
