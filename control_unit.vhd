library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity control_unit is
port(clk: in std_logic;
     op_code: in std_logic_vector(2 downto 0);
     Mem_Reg: out std_logic;
     Reg_dst: out std_logic;
     Mem_Write: out std_logic;
     Mem_Read: out std_logic;
     Reg_write: out std_logic;
     Alu_src: out std_logic;
     branch_signal:out std_logic;
     ALU_op: out std_logic_vector(2 downto 0));
end control_unit;
architecture cntrl_behave of control_unit is
signal op: std_logic_vector(2 downto 0);
begin
op<= op_code;
process(clk)
begin
if (rising_edge(clk)) then
case op is
--R format opcode
when "000" =>
Mem_Reg <= '0';
Mem_Write <= '0';
Mem_Read <= '0';
Reg_write <= '1';
Alu_src <= '0';
branch_signal <= '0';
Reg_dst <= '0';
ALU_op <= "010";
--ANDI
when "101" =>
Mem_Reg <= '0';
Mem_write <='0';
Mem_Read <= '0';
Reg_write <= '1';
Alu_src <= '1';
branch_signal <= '0';
Reg_dst <= '1';
ALU_op <= "110";
--SUBI
when "110" =>
Mem_Reg <= '0';
Mem_write <='0';
Mem_Read <= '0';
Reg_write <= '1';
Alu_src <= '1';
branch_signal <= '0';
Reg_dst <= '1';
ALU_op <= "011";
--BEQ
when "001" =>
Mem_Reg <= '0';
Mem_write <='0';
Mem_Read <= '0';
Reg_write <= '0';
Alu_src <= '0';
branch_signal <= '1';
Reg_dst <= '0';
ALU_op <= "001";
--LW
when "010" =>
Mem_Reg <= '1';
Mem_write <='0';
Mem_Read <= '1';
Reg_write <= '1';
Alu_src <= '1';
branch_signal <= '0';
Reg_dst <= '1';
ALU_op <= "000";
--SW
when "011" =>
Mem_Reg <= '0';
Mem_write <='1';
Mem_Read <= '0';
Reg_write <= '0';
Alu_src <= '1';
branch_signal <= '0';
Reg_dst <= '1';
ALU_op <= "000";
--JUMP
when "100" =>
Mem_Reg <= '0';
Mem_write <='0';
Mem_Read <= '0';
Reg_write <= '0';
Alu_src <= '0';
branch_signal <= '0';
Reg_dst <= '0';
ALU_op <= "XXX";
when others=>
end case;
end if;
end process;
end cntrl_behave;
