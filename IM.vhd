library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity IM is
port(
IM_in: in std_logic_vector(31 downto 0):=(others=>'0');
IM_out: out std_logic_vector(31 downto 0):=(others=>'0'));
end IM;
architecture IM_behave of IM is
type instructions is array (0 to 43) of std_logic_vector(7 downto 0);
signal M: instructions;
begin

-- ADD R5 R9 R3
--M(0)<="00001011";
--M(1)<="00100110";
--M(2)<="00000000";
--M(3)<="00001000";
-- ADD R3 r1 r6
--M(4)<="00000110";
--M(5)<="00101100";
--M(6)<="00000000";
--M(7)<="00000010";
-- SUB R6 r5 r8 
--M(8)<="00001100";
--M(9)<="10110000";
--M(10)<="00000000";
--M(11)<="00001001";
-- XOR R1 R3 r9 
--M(12)<="00000010";
--M(13)<="01110010";
--M(14)<="00000000";
--M(15)<="00001010"; 
-- ADD R2 R1 R10
--M(16)<="00000100";
--M(17)<="00110100";
--M(18)<="00000000";
--M(19)<="00000010";
-- ADD R3 R2 R11
--M(20)<="00000110";
--M(21)<="01010110";
--M(22)<="00000000";
--M(23)<="00000010";
--Jump 
--M(24)<="10001000";
--M(25)<="00000000";
--M(26)<="00000000";
--M(27)<="00000000";

--XOR
--M(0)<="00000010";
--M(1)<="10101110";
--M(2)<="00000000";
--M(3)<="00001010";

--BEQ

--M(4)<="00101110";
--M(5)<="10000000";
--M(6)<="00000000";
--M(7)<="00000001";

--ADD

--M(8)<="00000110";
--M(9)<="01010110";
--M(10)<="00000000";
--M(11)<="00000010";

--LW

--M(12)<="01000101";
--M(13)<="01000000";
--M(14)<="00000000";
--M(15)<="00000110";

--BEQ
--M(16)<="00110100";
--M(17)<="11000000";
--M(18)<="00000000";
--M(19)<="00000001";

--ADD

--M(20)<="00000110";
--M(21)<="01010110";
--M(22)<="00000000";
--M(23)<="00000010";

--ADD

--M(24)<="00000110";
--M(25)<="01010110";
--M(26)<="00000000";
--M(27)<="00000010";

--AND
M(0)<="00000110";
M(1)<="11000100";
M(2)<="00000000";
M(3)<="00001000";

--SUB
M(4)<="00001100";
M(5)<="01001000";
M(6)<="00000000";
M(7)<="00001001";

--XOR
M(8)<="00000010";
M(9)<="10000100";
M(10)<="00000000";
M(11)<="00001010";

--BEQ
M(12)<="00111011";
M(13)<="11000000";
M(14)<="00000000";
M(15)<="00000010";
--ANDI
M(16)<="10100010";
M(17)<="11000000";
M(18)<="00000000";
M(19)<="00001100";

--LW
M(20)<="01000101";
M(21)<="01000000";
M(22)<="00000000";
M(23)<="00000110";

--SUBI
M(24)<="11010101";
M(25)<="01000000";
M(26)<="00000000";
M(27)<="00000011";

--ADD
M(28)<="00001101";
M(29)<="00010010";
M(30)<="00000000";
M(31)<="00000010";

--SW
M(32)<="01110101";
M(33)<="11100000";
M(34)<="00000000";
M(35)<="00000111";

--J
M(36)<="10000000";
M(37)<="00000000";
M(38)<="00000000";
M(39)<="00000100";


--ADD

M(40)<="00000110";
M(41)<="01010110";
M(42)<="00000000";
M(43)<="00000010";
IM_out<=M(to_integer(unsigned(IM_in))) & M(to_integer(unsigned(IM_in))+1) & 
M(to_integer(unsigned(IM_in))+2) & M(to_integer(unsigned(IM_in))+3);

end IM_behave; 
