library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;				--import libraries

entity crossover1000 is							--define entity.
		port (
		clk: in STD_LOGIC;					--input signal
		rst: in STD_LOGIC;
		clkout: out STD_LOGIC				--output signal
		);
end crossover1000;

architecture crossover1000_arch of crossover1000 is	--define architecture
signal clk_tmp: STD_LOGIC:='1';
begin
   process(clk,rst)
	 variable c: integer range 0 to 499:= 0;
 	 begin
		if rst = '1' then
			clk_tmp <= '1';
			c:=0;
		else
		if rising_edge(clk) then
 			if c=499 then
 				clk_tmp <= not clk_tmp;
 				c:=0;
 			else
 				c:=c+1;
 			end if;
 		end if;
	end if;
   end process;
	clkout <= clk_tmp;
end;
