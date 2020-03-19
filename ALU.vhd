library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
port (
       input_1 : in std_logic_vector (31 downto 0);
       input_2 : in std_logic_vector (31 downto 0);
       ALU_control : in std_logic_vector (2 downto 0);
       ALU_output : out std_logic_vector ( 31 downto 0)
      );

end ALU;

architecture alu of ALU is

  begin

        with ALU_control select

          ALU_output <= std_logic_vector(unsigned(input_1) and unsigned(input_2)) when "000",
                        std_logic_vector(signed(input_1) - signed(input_2)) when "001",
                        std_logic_vector(unsigned(input_1) xor unsigned(input_2)) when "010",
                        std_logic_vector(signed(input_1) + signed(input_2))  when "110",
                        "00000000000000000000000000000000"  when others;
end alu;  
         
       
