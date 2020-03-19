library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifidbuff is
port(
       clk: in std_logic;
       ir_input: in std_logic_vector(31 downto 0):=  (others =>'0');
       pc_input: in std_logic_vector(31 downto 0):=  (others =>'0'); 
       output: out std_logic_vector(31 downto 0):=  (others =>'0');
       output_pcaddr:out std_logic_vector(31 downto 0):= (others =>'0')
    );
end ifidbuff;
architecture buff of ifidbuff is
begin
 process(clk)
    begin
      if(falling_edge(clk)) then
        output <= ir_input;
        output_pcaddr <= pc_input;
     
      end if;
 end process;
end buff;
