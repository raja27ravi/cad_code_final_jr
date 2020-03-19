library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity IF_ID_EX_stage is
  port(clk:in std_logic;
  Mem_WB_RegWrite:in std_logic;
  Mem_WB_Rd: in std_logic_vector(3 downto 0);
  WB_Mux_Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
  EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0');
  EX_Mem_memread: out std_logic:='0';
  EX_Mem_RegWrite:out std_logic:='0';
  EX_Mem_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
  EX_Mem_memreg:out std_logic:='0';
  EX_Mem_memwrite:out std_logic:='0';
  EX_Mem_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0');
  Mem_WB_MemRead:in std_logic
  );
end IF_ID_EX_stage;
architecture behave of IF_ID_EX_stage is
component IF_ID_Stage is 
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
end component;
component EX_Stage is
port(clk:std_logic;
  ID_EX_Mem_Reg:in std_logic;
  ID_EX_Reg_dst: in std_logic;
  ID_EX_Mem_Write: in std_logic;
  ID_EX_Mem_Read: in std_logic;
  ID_EX_Reg_write: in std_logic;
  ID_EX_Alu_src: in std_logic;
  ID_EX_ALU_op: in std_logic_vector(2 downto 0);
  ID_EX_Rs_data:in std_logic_vector(31 downto 0);
  ID_EX_Rt_data:in std_logic_vector(31 downto 0);
  ID_EX_functional: in std_logic_vector(16 downto 0);
  ID_EX_immediate: in std_logic_vector(31 downto 0);
  ID_EX_Rd: in std_logic_vector(3 downto 0);
  ID_EX_Rt: in std_logic_vector(3 downto 0);
  ID_EX_Rs: in std_logic_vector(3 downto 0);
  Mem_WB_RegWrite: in std_logic; 
  Mem_WB_Rd: in std_logic_vector(3 downto 0);
  Mem_WB_aluoutput: in std_logic_vector(31 downto 0):= (others=>'0'); 
  EX_Mem_memread: out std_logic:='0';
  EX_Mem_regwrite: out std_logic:='0';
  EX_Mem_memreg:out std_logic:='0';
  EX_Mem_memwrite:out std_logic:='0';
  EX_Mem_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
  EX_Mem_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0');
  EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0');
  id_ex_hz_out:in std_logic;
  opcode_in:in std_logic_vector(2 downto 0);
  Mem_WB_MemRead:in std_logic 	
);
end component;
signal ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,id_ex_comparision,id_ex_branch_signal,EX_Mem_MemRead_signal,EX_Mem_RegWrite_signal,
       id_ex_hz_out :std_logic;
signal ID_EX_ALU_op,opcode:std_logic_vector(2 downto 0);
signal ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_immediate,EX_Mem_aluoutput_signal:std_logic_vector(31 downto 0);
signal ID_EX_functional: std_logic_vector(16 downto 0);
signal ID_EX_Rd,ID_EX_Rt,ID_EX_Rs,EX_Mem_Rd_signal:std_logic_vector(3 downto 0);
begin
X1: IF_ID_Stage port map(clk,EX_Mem_Rd_signal,EX_Mem_MemRead_signal,EX_Mem_RegWrite_signal,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_aluoutput_signal,ID_EX_Mem_Reg,ID_EX_Reg_dst,
    ID_EX_Mem_Write,ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,ID_EX_ALU_op,ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_functional,ID_EX_immediate,ID_EX_Rd,
    ID_EX_Rt,ID_EX_Rs,id_ex_comparision,id_ex_branch_signal,id_ex_hz_out,opcode);
X2:EX_Stage port map(clk,ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,ID_EX_ALU_op,ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_functional,
   ID_EX_immediate,ID_EX_Rd,ID_EX_Rt,ID_EX_Rs,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_memread_signal,EX_Mem_RegWrite_signal,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_aluoutput_signal,
   EX_Mem_Rdata2,EX_Mem_Rd_signal,id_ex_hz_out,opcode,Mem_WB_MemRead);
   EX_Mem_Rd<=EX_Mem_Rd_signal;
   EX_Mem_aluoutput<=EX_Mem_aluoutput_signal;
   EX_Mem_MemRead<=EX_Mem_MemRead_signal;
   EX_Mem_RegWrite<=EX_Mem_RegWrite_signal;
end behave;