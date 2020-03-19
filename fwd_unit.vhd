library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity fwd_unit is
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
end fwd_unit;
architecture fwd_behave of fwd_unit is
begin

	 ForwardRs <=      "01" when ((EX_Mem_RegWrite='1') and (ID_EX_Rs = EX_Mem_Rd)and (EX_Mem_Rd /="0000")) else
	             
                     "10" when ((Mem_WB_RegWrite='1') and (ID_EX_Rs = Mem_WB_Rd) and (Mem_WB_Rd /="0000")) else
		
                     (others=>'0');
                
       ForwardRt <=    "00" when ((ID_EX_opcode="101" or ID_EX_opcode="110") and (EX_Mem_RegWrite='1') and EX_Mem_MemRead='1' and (ID_EX_Rt = EX_Mem_Rd)and (EX_Mem_Rd /="0000"))else
                       "00" when ((ID_EX_opcode="101" or ID_EX_opcode="110") and (Mem_WB_RegWrite='1') and Mem_WB_MemRead='1' and (ID_EX_Rt = Mem_WB_Rd)and (Mem_WB_Rd /="0000"))else
       
                       "01" when((EX_Mem_RegWrite='1') and (ID_EX_Rt = EX_Mem_Rd)and (EX_Mem_Rd /="0000")) else
		
	                    "10" when ((Mem_WB_RegWrite='1') and (ID_EX_Rt = Mem_WB_Rd)and (Mem_WB_Rd /="0000")) else
		
	             
                     (others=>'0');

end fwd_behave;
	

