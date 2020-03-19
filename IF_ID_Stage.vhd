library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity IF_ID_Stage is 
port (clk:in std_logic;
        EX_Mem_Rd: in std_logic_vector(3 downto 0);
	EX_Mem_MemRead:in std_logic;
	EX_Mem_RegWrite: in std_logic;
	Mem_WB_RegWrite:in std_logic;
	Mem_WB_Rd: in std_logic_vector(3 downto 0);
	WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
	EX_Mem_Rd_data:in std_logic_vector(31 downto 0);
	ID_EX_Mem_Reg:out std_logic;
	ID_EX_Reg_dst: out std_logic;
	ID_EX_Mem_Write: out std_logic;
	ID_EX_Mem_Read: out std_logic;
	ID_EX_Reg_write: out std_logic;
	ID_EX_Alu_src: out std_logic;
	ID_EX_ALU_op: out std_logic_vector(2 downto 0);
	ID_EX_Rs_data:out std_logic_vector(31 downto 0);
	ID_EX_Rt_data:out std_logic_vector(31 downto 0);
	ID_EX_functional: out std_logic_vector(16 downto 0);
	ID_EX_immediate: out std_logic_vector(31 downto 0);
	ID_EX_Rd: out std_logic_vector(3 downto 0);
	ID_EX_Rt: out std_logic_vector(3 downto 0);
	ID_EX_Rs: out std_logic_vector(3 downto 0);
	id_ex_comparision:out std_logic;
  id_ex_branch_signal:out std_logic;
  id_ex_hz_out:out std_logic;
  opcode_out:out std_logic_vector(2 downto 0)
);
end IF_ID_Stage;
architecture behave of IF_ID_Stage is
component if_stage is
port( clk: in std_logic;
      hazard_input:in std_logic_vector(1 downto 0):=(others=>'0');
      hazard_input1:in std_logic;
      branch_input:in std_logic_vector(31 downto 0):=(others=>'0');
      jump_in: in std_logic_vector(31 downto 0):=(others=>'0');
      ifid_pc4:out std_logic_vector(31 downto 0):=(others=>'0');
      ifid_ir:out std_logic_vector(31 downto 0):=(others=>'0')
     );
end component;
component ID_stage is
port(clk: in std_logic;
	IF_ID_buffer_opcode: in std_logic_vector(2 downto 0);
	IF_ID_buffer_Rs: in std_logic_vector(3 downto 0);
	IF_ID_buffer_Rt: in std_logic_vector(3 downto 0);
	IF_ID_buffer_Rd: in std_logic_vector(3 downto 0);
	IF_ID_buffer_Funct:in std_logic_vector(16 downto 0);
	IF_ID_buffer_immediate:in std_logic_vector(20 downto 0);
	pc_4_in: in std_logic_vector(31 downto 0);
	EX_Mem_Rd: in std_logic_vector(3 downto 0);
	EX_Mem_MemRead:in std_logic;
	EX_Mem_RegWrite: in std_logic;
	Mem_WB_RegWrite:in std_logic;
	Mem_WB_Rd: in std_logic_vector(3 downto 0);
	WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
	EX_Mem_Rd_data:in std_logic_vector(31 downto 0);
	ID_EX_Mem_Reg:out std_logic;
	ID_EX_Reg_dst: out std_logic;
	ID_EX_Mem_Write: out std_logic;
	ID_EX_Mem_Read: out std_logic;
	ID_EX_Reg_write: out std_logic;
	ID_EX_Alu_src: out std_logic;
	ID_EX_ALU_op: out std_logic_vector(2 downto 0);
	ID_EX_Rs_data:out std_logic_vector(31 downto 0);
	ID_EX_Rt_data:out std_logic_vector(31 downto 0);
	ID_EX_functional: out std_logic_vector(16 downto 0);
	ID_EX_immediate: out std_logic_vector(31 downto 0);
	ID_EX_Rd: out std_logic_vector(3 downto 0);
	ID_EX_Rt: out std_logic_vector(3 downto 0);
	ID_EX_Rs: out std_logic_vector(3 downto 0);
	IM_select:out std_logic;
	pc_mux:out std_logic_vector(1 downto 0);
	branch_address:out std_logic_vector(31 downto 0);
	id_ex_comparision:out std_logic;
  id_ex_branch_signal:out std_logic;
  id_ex_hz_out:out std_logic;
  jump_out:out std_logic_vector(31 downto 0);
  opcode_out:out std_logic_vector(2 downto 0));
end component;
signal hazard_input:std_logic_vector(1 downto 0);
signal hazard_input1:std_logic;
signal branch_input:std_logic_vector(31 downto 0);
signal ifid_pc4,ifid_ir,jump_out:std_logic_vector(31 downto 0);
begin
X1:if_stage port map( clk,hazard_input,hazard_input1, branch_input,jump_out,ifid_pc4,ifid_ir);
X2:ID_stage port map(clk,ifid_ir(31 downto 29),ifid_ir(28 downto 25),ifid_ir(24 downto 21), ifid_ir(20 downto 17),ifid_ir(16 downto 0),ifid_ir(20 downto 0),
   ifid_pc4,EX_Mem_Rd,EX_Mem_MemRead,EX_Mem_RegWrite,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_Rd_data,ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,
   ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,ID_EX_ALU_op,ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_functional,ID_EX_immediate,ID_EX_Rd,ID_EX_Rt,ID_EX_Rs,
   hazard_input1,hazard_input, branch_input,id_ex_comparision,id_ex_branch_signal,id_ex_hz_out,jump_out,opcode_out);
end behave;