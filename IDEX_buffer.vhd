library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity idexbuff is
port(
     clk:in std_logic;
     alu_op:in std_logic_vector(2 downto 0):=(others=>'X');
     mem_read,alu_select,reg_dest,reg_write,mem_reg,mem_write:in std_logic:='0';
     reg_rt,reg_rd,reg_rs:in std_logic_vector(3 downto 0):=(others=>'0');
     func_op:in std_logic_vector(16 downto 0):=(others=>'0');
     reg1_value,reg2_value,offset:in std_logic_vector(31 downto 0):=(others=>'0');
     out_aluop:out std_logic_vector(2 downto 0);
     out_memread,out_aluselect,out_regdest,out_regwrite,out_memreg,out_memwrite:out std_logic:='0';
     out_regrt,out_regrd,out_regrs:out std_logic_vector(3 downto 0);
     out_funcop:out std_logic_vector(16 downto 0);
     out_reg1value,out_reg2value,out_offset:out std_logic_vector(31 downto 0);
     comparision:in std_logic;
     branch_signal:in std_logic;
     id_ex_comparision:out std_logic;
     id_ex_branch_signal:out std_logic;
     hz_in:in std_logic;
     hz_out:out std_logic;
     opcode_in:in std_logic_vector(2 downto 0);
     opcode_out:out std_logic_vector(2 downto 0)
    );
end idexbuff;
architecture buff of idexbuff is
begin
 process(clk)
  begin
    if(falling_edge(clk)) then
      out_aluop<=alu_op;
      out_memread<=mem_read;
      out_aluselect<=alu_select;
      out_regdest<=reg_dest;
      out_regwrite<=reg_write;
      out_memreg<=mem_reg;
      out_memwrite<=mem_write;
      out_regrt<=reg_rt;
      out_regrd<=reg_rd;
      out_regrs<=reg_rs;
      out_funcop<=func_op;
      out_reg1value<=reg1_value;
      out_reg2value<=reg2_value;
      out_offset<=offset; 
      id_ex_comparision<=comparision;
      id_ex_branch_signal<=branch_signal;
      hz_out<=hz_in;
      opcode_out<=opcode_in;
      
      
    end if;
 end process;
end buff;
    
     