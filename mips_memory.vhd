library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_memory is
 port(
      clk: in std_logic;
      mem_write : in std_logic:='0';
      mem_read : in std_logic:='0';
      alu_meminput : in std_logic_vector(31 downto 0):=(others=>'0');
      data_input : in std_logic_vector(31 downto 0):=(others=>'0');
      mem_output : out std_logic_vector(31 downto 0):=(others=>'0')
     );
end mips_memory;
architecture behavioral of mips_memory is
signal memory_addr: std_logic_vector(31 downto 0);
type data_mem is array (0 to 31 ) of std_logic_vector (31 downto 0);
signal mem_location: data_mem :=((others=> (others=>'0')));
begin
 memory_addr <= alu_meminput(31 downto 0);
 process(clk)
 begin
   mem_location(8)<=X"00000006";
  if(rising_edge(clk)) then
    if (mem_write='1') then
     mem_location(to_integer(unsigned(memory_addr))) <= data_input;
    end if;
  end if;
 end process;
   mem_output <= mem_location(to_integer(unsigned(memory_addr))) when (mem_read='1') else x"00000000";
end behavioral;
      
