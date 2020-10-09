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

begin
   process(clk,rst)
	 variable c: integer range 0 to 499:= 0;
 	 begin
		if rst = '1' then
			clkout <= '1';
			c:=0;
		else
		if rising_edge(clk) then
 			if c=499 then
 				clkout <= not clkout;
 				c:=0;
 			else
 				c:=c+1;
 			end if;
 		end if;
	end if;
   end process;
end;
