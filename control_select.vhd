library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity control_select is
port(cntrl_Mux:in std_logic;
     Mem_Reg: in std_logic;
     Reg_dst: in std_logic;
     Mem_Write: in std_logic;
     Mem_Read: in std_logic;
     Reg_write: in std_logic;
     Alu_src: in std_logic;
     branch_signal:in std_logic;
     ALU_op: in std_logic_vector(2 downto 0);
     cntrlMem_Reg: out std_logic;
     cntrlReg_dst: out std_logic;
     cntrlMem_Write: out std_logic;
     cntrlMem_Read: out std_logic;
     cntrlReg_write: out std_logic;
     cntrlAlu_src: out std_logic;
     cntrlbranch_signal:out std_logic;
     cntrlALU_op: out std_logic_vector(2 downto 0));
end control_select;
architecture behave of control_select is
begin
cntrlMem_Reg<=Mem_Reg  when cntrl_Mux='0' else
	      '0';
cntrlReg_dst<=Reg_dst  when cntrl_Mux='0' else
		'0';
cntrlMem_Write<=Mem_Write when cntrl_Mux='0' else
		'0';
cntrlMem_Read<=Mem_Read when cntrl_Mux='0' else
		'0';
cntrlReg_write<=Reg_write when cntrl_Mux='0' else
		'0';
cntrlAlu_src<=Alu_src when cntrl_Mux='0' else
		'0';
cntrlbranch_signal<=branch_signal when cntrl_Mux='0' else
		'0';
cntrlALU_op<=ALU_op when cntrl_Mux='0' else
		"000"; 
end behave;
