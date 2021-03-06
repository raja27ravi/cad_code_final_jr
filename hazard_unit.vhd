library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity hazard_unit is
port(
	opcode: in std_logic_vector(2 downto 0);
	ID_EX_MemRead: in std_logic;
	IF_ID_Rs: in std_logic_vector(3 downto 0);
	ID_EX_Rt: in std_logic_vector(3 downto 0);
	IF_ID_Rt: in std_logic_vector(3 downto 0);
	IM_select:out std_logic;
	cntrl_Mux: out std_logic;
	pc_Mux: out std_logic_vector(1 downto 0);
	comparision: in std_logic;
	branch_signal: in std_logic;
	ID_EX_Rd:in std_logic_vector(3 downto 0);
	ID_EX_RegWrite: in std_logic;
	EX_Mem_Rd: in std_logic_vector(3 downto 0);
	EX_Mem_MemRead:in std_logic;
	EX_Mem_RegWrite: in std_logic;
	Forward_branch_Rs: out std_logic_vector(1 downto 0);
	Forward_branch_Rt: out std_logic_vector(1 downto 0);
	Mem_WB_RegWrite:in std_logic;
	Mem_WB_Rd: in std_logic_vector(3 downto 0);
	id_ex_comparision:in std_logic;
  	id_ex_branch_signal:in std_logic;
  	opcode_feedback:in std_logic_vector(2 downto 0) );
end hazard_unit;
architecture behave_hu of hazard_unit is
begin
--data Hazard(LW-ALU)
	IM_select<='1' when (opcode="000" and ID_EX_MemRead='1' and ID_EX_RegWrite='1' and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) ) else
	
	           '1' when ((opcode="101" or opcode="110") and ID_EX_MemRead='1' and ID_EX_RegWrite='1' and (IF_ID_Rs=ID_EX_Rt)) else
		
--Control hazard
	'0' when(comparision='0' and branch_signal='1' and not((( IF_ID_Rs=ID_EX_Rd or IF_ID_Rt=ID_EX_Rd) and ID_EX_RegWrite='1') or 
           (((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') or 
           (((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1'))) else
		
--JUMP
	'0' when (opcode="100") else
	
	'0' when (opcode_feedback="100") else
		
		
--data hazard(ALU_BEQ)
	'1' when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='0' and ID_EX_RegWrite='1') else
		
--data hazard(LW_BEQ)	
	'1' when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') else
		
	'1' when( opcode="001"and ((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1') else
		
        '0';
		
--data Hazard(LW-ALU)
	cntrl_Mux<='1' when (opcode="000" and ID_EX_MemRead='1' and ID_EX_RegWrite='1'and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) ) else
		
		
	'1' when ((opcode="101" or opcode="110") and ID_EX_MemRead='1' and ID_EX_RegWrite='1'and (IF_ID_Rs=ID_EX_Rt)) else
		
		
--Control hazard
	'0' when(comparision='0' and branch_signal='1' and not((( IF_ID_Rs=ID_EX_Rd or IF_ID_Rt=ID_EX_Rd) and ID_EX_RegWrite='1') or 
           (((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') or 
           (((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1'))) else
	'1' when  (id_ex_comparision='0' and id_ex_branch_signal='1') else
		
--JUMP
	'1' when (opcode="100") else
	'1' when (opcode_feedback="100") else
		
--data hazard(ALU_BEQ)
	'1' when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='0' and ID_EX_RegWrite='1') else
		
	        
--data hazard(LW_BEQ)	
	'1' when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') else
		
	       
	'1' when( opcode="001"and ((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1') else
		
        '0';
	
--data Hazard(LW-ALU)
	pc_Mux<="11" when (opcode="000" and ID_EX_MemRead='1' and ID_EX_RegWrite='1' and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) ) else
		
	        "11" when ((opcode="101" or opcode="110") and ID_EX_MemRead='1' and ID_EX_RegWrite='1' and (IF_ID_Rs=ID_EX_Rt)) else
		
--Control hazard
	"00" when(comparision='0' and branch_signal='1' and not((( IF_ID_Rs=ID_EX_Rd or IF_ID_Rt=ID_EX_Rd) and ID_EX_RegWrite='1') or 
        (((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') or 
        (((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1'))) else
  "01" when (id_ex_comparision='0' and id_ex_branch_signal='1') else
		
		
--JUMP
	"00" when (opcode="100") else
	"10" when (opcode_feedback="100") else
		
--data hazard(ALU_BEQ)
	"11" when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rd) or (IF_ID_Rt=ID_EX_Rd)) and ID_EX_MemRead='0' and ID_EX_RegWrite='1') else
		
--data hazard(LW_BEQ)	
	"11" when ( opcode="001"and ((IF_ID_Rs=ID_EX_Rt) or (IF_ID_Rt=ID_EX_Rt)) and ID_EX_MemRead='1' and ID_EX_RegWrite='1') else
	
	"11" when( opcode="001"and ((IF_ID_Rs=EX_Mem_Rd) or (IF_ID_Rt=EX_Mem_Rd)) and EX_Mem_MemRead='1' and EX_Mem_RegWrite='1') else
	
       (others=>'0');
			

--LW_BEQ forwarding unit and ALU_BEQ forwarding unit
	
	Forward_branch_Rs <= "01" when (opcode="001" and (EX_Mem_RegWrite='1') and (IF_ID_Rs = EX_Mem_Rd)and (EX_Mem_Rd /="0000") and EX_Mem_MemRead='0') else
		
	"10" when(opcode="001" and (Mem_WB_RegWrite='1') and (IF_ID_Rs = Mem_WB_Rd) and (Mem_WB_Rd /="0000")) else
		
        (others=>'0');

       Forward_branch_Rt <= "01" when (opcode="001" and (EX_Mem_RegWrite='1') and (IF_ID_Rt = EX_Mem_Rd)and (EX_Mem_Rd /="0000") and EX_Mem_MemRead='0') else
		
	"10" when(opcode="001" and (Mem_WB_RegWrite='1') and (IF_ID_Rt = Mem_WB_Rd)and (Mem_WB_Rd /="0000")) else
		
        (others=>'0');
		
end behave_hu;
	
