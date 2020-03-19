library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity alu_control is
port (
      alu_op: in std_logic_vector(2 downto 0):=(others=>'X');
      func_op: in std_logic_vector(16 downto 0):=(others=>'0');
      alu_cntrl: out std_logic_vector(2 downto 0)
      );
end alu_control;
architecture control_alu of alu_control is
begin
 
    alu_cntrl <="000"  when(alu_op ="010" and func_op = "00000000000001000") else
                "001"  when(alu_op ="010" and func_op="00000000000001001") else
                "010"  when(alu_op="010" and func_op ="00000000000001010" )else
                "110"  when(alu_op="010" and func_op ="00000000000000010" )else
                "000"  when(alu_op="110") else
                "001"  when(alu_op="011") else
                "001"  when(alu_op="001") else
                "110"  when(alu_op="000") else
                (others=>'0');
 end control_alu;        