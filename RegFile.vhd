library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity RegFile is
port(clk:in std_logic:='0';
RegWrite:in std_logic:='0';
Rreg1:in std_logic_vector(3 downto 0):=(others=>'0');
Rreg2:in std_logic_vector(3 downto 0):=(others=>'0');
Wreg:in std_logic_vector(3 downto 0):=(others=>'0');
Wdata:in std_logic_vector(31 downto 0):=(others=>'0');
Rdata1:out std_logic_vector(31 downto 0):=(others=>'0');
Rdata2:out std_logic_vector(31 downto 0):=(others=>'0'));
end RegFile;
architecture IR_behave of RegFile is
type reg is array(0 to 15) of std_logic_vector(31 downto 0);
signal M:reg:=(others=>(others=>'0'));
signal rst1:std_logic:='1';
begin
--process(clk,rst1,RegWrite,Rreg1,Rreg2,Wreg,Wdata)
process(clk,rst1,RegWrite)
begin
if (rst1='1') then
M(0)<= X"00000000";
M(1)<= X"00000001";
M(2)<= X"00000002";
M(3)<= X"00000003";
M(4)<= X"00000004";
M(5)<= X"00000005";
M(6)<= X"00000006";
M(7)<= X"00000007";
M(8)<= X"00000008";
M(9)<= X"00000009";
M(10)<= X"0000000A";
M(11)<= X"0000000B";
M(12)<= X"0000000C";
M(13)<= X"0000000D";
M(14)<= X"0000000E";
rst1<='0';
end if;

if (rising_edge(clk)) then
Rdata1<=M(to_integer(unsigned(Rreg1)));
Rdata2<=M(to_integer(unsigned(Rreg2)));
end if;

 if (RegWrite='1') then
		M(to_integer(unsigned(Wreg))) <= Wdata;
		
 end if;
end process;
end IR_behave;
