library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity EX_Stage is
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
end EX_Stage;
architecture behave of EX_Stage is
component fwd_unit is
port(
      EX_Mem_RegWrite: in std_logic;
      Mem_WB_RegWrite: in std_logic;
      ID_EX_Rs:in std_logic_vector(3 downto 0);
      ID_EX_Rt:in std_logic_vector(3 downto 0);
      EX_Mem_Rd: in std_logic_vector(3 downto 0);
      Mem_WB_Rd: in std_logic_vector(3 downto 0);
      ForwardRs:out std_logic_vector(1 downto 0);
      ForwardRt:out std_logic_vector(1 downto 0);
      EX_Mem_MemRead:in std_logic;
      ID_EX_opcode:in std_logic_vector(2 downto 0);
      Mem_WB_MemRead:in std_logic);
end component;
component alu_control is
port (
      alu_op: in std_logic_vector(2 downto 0):=(others=>'X');
      func_op: in std_logic_vector(16 downto 0):=(others=>'0');
      alu_cntrl: out std_logic_vector(2 downto 0)
      );
end component;
component ALU is
port ( 
       input_1 : in std_logic_vector (31 downto 0);
       input_2 : in std_logic_vector (31 downto 0);
       ALU_control : in std_logic_vector (2 downto 0);
       ALU_output : out std_logic_vector ( 31 downto 0)
      );

end component;
component mux_address is
port (
      
      sel : in std_logic;
      input_1: in std_logic_vector(3 downto 0);
      input_2: in std_logic_vector(3 downto 0);
      output_2mux : out std_logic_vector(3 downto 0)
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
component threemux is
port (
      
      sel : in std_logic_vector(1 downto 0);
      input_1 : in std_logic_vector ( 31 downto 0);
      input_2: in std_logic_vector (31 downto 0);
      input_3 : in std_logic_vector (31 downto 0);
      output_mux : out std_logic_vector (31 downto 0)
     );
end component;
component exembuff is
port (
       clk:in std_logic;
       mem_read:in std_logic:='0';
       reg_write:in std_logic:='0';
       mem_reg:in std_logic:='0';
       mem_write: in std_logic:='0';
       alu_output:in std_logic_vector(31 downto 0):= (others=>'0');
       mux_Rd:in std_logic_vector(3 downto 0):= (others=>'0');
       ID_EX_Rdata2:in std_logic_vector(31 downto 0):= (others=>'0');
       out_memread: out std_logic:='0';
       out_regwrite: out std_logic:='0';
       out_memreg:out std_logic:='0';
       out_memwrite:out std_logic:='0';
       out_aluoutput: out std_logic_vector(31 downto 0):= (others=>'0');
       out_Rdata2:out std_logic_vector(31 downto 0):= (others=>'0');
       out_EX_Mem_Rd:out std_logic_vector(3 downto 0):= (others=>'0') 
     );
end component;
signal EX_Mem_regwrite_signal,EX_Mem_memread_signal:std_logic;
signal ForwardRs,ForwardRt:std_logic_vector(1 downto 0);
signal alu_cntrl:std_logic_vector(2 downto 0);
signal mux_Rd,EX_Mem_Rd_signal:std_logic_vector(3 downto 0);
signal alu_output,mux_normal_data2,mux_out_Rs,mux_out_Rt,EX_Mem_aluoutput_signal:std_logic_vector(31 downto 0);
signal hz_signal_alu,alu_mux_out:std_logic_vector(31 downto 0);
begin
X1:fwd_unit port map(EX_Mem_regwrite_signal,Mem_WB_RegWrite,ID_EX_Rs,ID_EX_Rt,EX_Mem_Rd_signal,Mem_WB_Rd,ForwardRs,ForwardRt,EX_Mem_memread_signal,opcode_in,Mem_WB_MemRead);
X2:alu_control port map(ID_EX_ALU_op,ID_EX_functional,alu_cntrl);
X3:ALU port map(mux_out_Rs,mux_out_Rt,alu_cntrl,alu_output);
X4:mux_address port map(ID_EX_Reg_dst,ID_EX_Rd,ID_EX_Rt,mux_Rd);
X5:twomux port map(ID_EX_Alu_src,ID_EX_Rt_data,ID_EX_immediate,mux_normal_data2);
X6:threemux port map(ForwardRs,ID_EX_Rs_data,EX_Mem_aluoutput_signal,Mem_WB_aluoutput,mux_out_Rs);
X7:threemux port map(ForwardRt,mux_normal_data2,EX_Mem_aluoutput_signal,Mem_WB_aluoutput,mux_out_Rt);
X8:exembuff port map(clk,ID_EX_Mem_Read,ID_EX_Reg_write,ID_EX_Mem_Reg,ID_EX_Mem_Write,alu_mux_out,mux_Rd,ID_EX_Rt_data,
EX_Mem_memread_signal,EX_Mem_regwrite_signal,EX_Mem_memreg,EX_Mem_memwrite,EX_Mem_aluoutput_signal,EX_Mem_Rdata2,EX_Mem_Rd_signal);
X9:twomux port map(id_ex_hz_out,alu_output,hz_signal_alu,alu_mux_out);
EX_Mem_regwrite<=EX_Mem_regwrite_signal;
EX_Mem_Rd<=EX_Mem_Rd_signal;
EX_Mem_aluoutput<=EX_Mem_aluoutput_signal;
EX_Mem_memread<=EX_Mem_memread_signal;
hz_signal_alu<=X"00000000";
end behave;