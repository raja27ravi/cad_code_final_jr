library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity branch_determine is
  port(  
    branch_determine: in std_logic:='0';
    input_1: in std_logic_vector(31 downto 0);
    input_2: in std_logic_vector(31 downto 0);
    branch_output: out std_logic
  );
end branch_determine;

architecture branch of branch_determine is
begin
    branch_output <='0' when ( branch_determine='1' and (input_1=input_2))  else
                    '1';
end branch;
