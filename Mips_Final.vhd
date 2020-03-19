library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Mips_Final is 
port (clk:in std_logic;
jump_in:in std_logic_vector(31 downto 0));
end Mips_Final;
architecture behave of Mips_Final is
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
	branch_address:out std_logic_vector(31 downto 0));
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
        EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0')   	
);
end component;
component mips_memory is
 port(
      clk: in std_logic;
      mem_write : in std_logic:='0';
      mem_read : in std_logic:='0';
      alu_meminput : in std_logic_vector(31 downto 0):=(others=>'0');
      data_input : in std_logic_vector(31 downto 0):=(others=>'0');
      mem_output : out std_logic_vector(31 downto 0):=(others=>'0')
     );
end component;
component memwbbuff is
port(
     clk:in std_logic;
     reg_write:in std_logic:='0';
     mem_reg:in std_logic:='0';
     alu_output:in std_logic_vector(31 downto 0):=(others=>'0');
     mem_output:in std_logic_vector(31 downto 0):=(others=>'0');
     EX_Mem_Reg_Rd: in std_logic_vector(3 downto 0):=(others=>'0');
     out_regwrite:out std_logic:='0';
     out_memreg:out std_logic:='0';
     out_aluoutput:out std_logic_vector(31 downto 0):=(others=>'0');
     Mem_WB_Reg_Rd: out std_logic_vector(3 downto 0):=(others=>'0');
     out_memoutput:out std_logic_vector(31 downto 0):=(others=>'0')
    );
end component;
component twomux is
port (
      
      sel : in std_logic;
      input_1: in std_logic_vector(31 downto 0);
      input_2: in std_logic_vector(31 downto 0);
      output_2mux : out std_logic_vector(31 downto 0)
      );
end component;
signal hazard_input:std_logic_vector(1 downto 0);
signal ID_EX_ALU_op:std_logic_vector(2 downto 0);
signal EX_Mem_Rd,Mem_WB_Rd,ID_EX_Rd,ID_EX_Rt,ID_EX_Rs: std_logic_vector(3 downto 0);
signal hazard_input1,EX_Mem_MemRead,EX_Mem_RegWrite,Mem_WB_RegWrite,ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,ID_EX_Mem_Read,ID_EX_Reg_write,
ID_EX_Alu_src,EX_Mem_memreg,EX_Mem_memwrite,Mem_WB_memReg: std_logic;
signal branch_input,ifid_pc4,ifid_ir,WB_Mux_Wdata,EX_Mem_Rd_data,ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_immediate,
EX_Mem_aluoutput,EX_Mem_Rdata2,mem_output,out_aluoutput,out_memoutput: std_logic_vector(31 downto 0);
signal ID_EX_functional: std_logic_vector(16 downto 0);
begin
X1:if_stage port map( clk,hazard_input,hazard_input1, branch_input,jump_in,ifid_pc4,ifid_ir);
X2:ID_stage port map(clk,ifid_ir(31 downto 29),ifid_ir(28 downto 25),ifid_ir(24 downto 21), ifid_ir(20 downto 17),ifid_ir(16 downto 0),ifid_ir(20 downto 0),
   ifid_pc4,EX_Mem_Rd,EX_Mem_MemRead,EX_Mem_RegWrite,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_Rd_data,ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,
   ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,ID_EX_ALU_op,ID_EX_Rs_data,ID_EX_Rt_data,ID_EX_functional,ID_EX_immediate,ID_EX_Rd,ID_EX_Rt,ID_EX_Rs,
   hazard_input1,hazard_input, branch_input);
X3:EX_Stage port map(clk,ID_EX_Mem_Reg,ID_EX_Reg_dst,ID_EX_Mem_Write,ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Alu_src,ID_EX_ALU_op,ID_EX_Rs_data,
   ID_EX_Rt_data,ID_EX_functional,ID_EX_immediate,ID_EX_Rd,ID_EX_Rt,ID_EX_Rs,Mem_WB_RegWrite,Mem_WB_Rd,WB_Mux_Wdata,EX_Mem_MemRead,EX_Mem_RegWrite,
   EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_aluoutput,EX_Mem_Rdata2,EX_Mem_Rd);
X4:mips_memory port map(clk,EX_Mem_memwrite,EX_Mem_MemRead,EX_Mem_aluoutput,EX_Mem_Rdata2,mem_output);
X5:memwbbuff port map(clk,EX_Mem_RegWrite,EX_Mem_memreg,EX_Mem_aluoutput,mem_output,EX_Mem_Rd,Mem_WB_RegWrite,Mem_WB_memReg,out_aluoutput,Mem_WB_Rd,
   out_memoutput);
X6:twomux port map(Mem_WB_memReg,out_aluoutput,out_memoutput,WB_Mux_Wdata);
end behave;