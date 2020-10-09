library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;				--import libraries

entity crossover10 is							--define entity.
		port (
		clk: in STD_LOGIC;					--input signal
		clkout: out STD_LOGIC;				--output signal
		countout: out STD_LOGIC_VECTOR(3 downto 0)
		);
end crossover10;

architecture crossover10_arch of crossover10 is	--define architecture
signal count: integer range 0 to 9;
begin
   process(clk)
   begin
	if (clk'event and clk='1') then				--judge the rising edge
	  if (count = 9) then				--zero the counter when reach 9
		 count <= 0;
	  else
	     count <= count + 1;			--count
	  end if;
	  if count <= 4 then 				--switch the signal when counts 5
  		 clkout <= '0';
	  else 
		 clkout <= '1';
	  end if;
	  countout <= conv_std_logic_vector(count,4);
	end if;
   end process;
end;