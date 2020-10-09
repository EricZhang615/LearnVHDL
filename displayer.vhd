library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;				--import libraries

entity dot_array is 						--define entity
		port(
		clk: in STD_LOGIC;				--input clock, 1ms period
		reset: in STD_LOGIC;			--asynchronous reset. '1' is valid. 
		row: out STD_LOGIC_VECTOR(7 downto 0);		--output signal for selecting and scanning rows of the displayer
		col_r: out STD_LOGIC_VECTOR(7 downto 0);	--output signal for selecting columns of red lights
		col_g: out STD_LOGIC_VECTOR(7 downto 0)		--output signal for selecting columns of green lights
		);
end dot_array;

architecture dot_array_arch of dot_array is 	--define architecture
signal scan_cnt: integer range 0 to 7;		--be used for counting rows
signal letter_cnt: integer range 0 to 6;	--be used for counting letters
signal clk_1s: std_logic:='1';				--generate the low frequency clock, 1s period


begin
	P1:process(clk)							--crossover 1000, generates low frequency clock for change the letter on displayer
	variable c: integer range 0 to 499:= 0;	--clk_1s has 1 second period if clk has 1ms period.
	begin
		if rising_edge(clk) then
			if c=499 then
				clk_1s <= not clk_1s;
				c:=0;
			else
				c:=c+1;
			end if;
		end if;
	end process P1;
	
	P2:process(clk,reset)					--count for scanning the displayer, driven by clk directly
	begin
		if reset = '1' then				--if reset, clear the counter
			scan_cnt <= 0;
		elsif clk'EVENT and clk='1' then
			if scan_cnt = 7 then		--row counter mods 8
				scan_cnt <= 0;
			else
				scan_cnt <= scan_cnt+1;
			end if;
		end if;
	end process P2;
	
	P3:process(clk_1s,reset)				--count for changing the letters, driven by clk_1s
	begin									
		if reset = '1' then				--if reset, clear the counter
			letter_cnt <= 0;
		elsif clk_1s'EVENT and clk_1s='1' then
			if letter_cnt = 6 then
				letter_cnt <= 0;		--letters counter mods 7
			else
				letter_cnt <= letter_cnt+1;
			end if;
		end if;
	end process P3;
	
	P4:process(scan_cnt,letter_cnt,reset)			--output signal by scan_cnt and letter_cnt
	begin									--the output letters are"BUPTZZY"
		if reset = '1' then
			row <= "11111111";
		else
		case letter_cnt is
			when 0 => case scan_cnt is		--B(red)
						when 0 => row <= "01111111"; col_r <= "00111110"; col_g <= "00000000";
						when 1 => row <= "10111111"; col_r <= "01000110"; col_g <= "00000000";
						when 2 => row <= "11011111"; col_r <= "01000110"; col_g <= "00000000";
						when 3 => row <= "11101111"; col_r <= "00111110"; col_g <= "00000000";
						when 4 => row <= "11110111"; col_r <= "01000110"; col_g <= "00000000";
						when 5 => row <= "11111011"; col_r <= "01000110"; col_g <= "00000000";
						when 6 => row <= "11111101"; col_r <= "01000110"; col_g <= "00000000";
						when 7 => row <= "11111110"; col_r <= "00111110"; col_g <= "00000000";
						when others => null;
						end case;
			when 1 => case scan_cnt is		--U(green)
						when 0 => row <= "01111111"; col_r <= "00000000"; col_g <= "11000110";
						when 1 => row <= "10111111"; col_r <= "00000000"; col_g <= "11000110";
						when 2 => row <= "11011111"; col_r <= "00000000"; col_g <= "11000110";
						when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "11000110";
						when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "11000110";
						when 5 => row <= "11111011"; col_r <= "00000000"; col_g <= "11000110";
						when 6 => row <= "11111101"; col_r <= "00000000"; col_g <= "11111110";
						when 7 => row <= "11111110"; col_r <= "00000000"; col_g <= "01111100";
						when others => null;
						end case;
			when 2 => case scan_cnt is		--P(red)
						when 0 => row <= "01111111"; col_r <= "00111110"; col_g <= "00000000";
						when 1 => row <= "10111111"; col_r <= "01000110"; col_g <= "00000000";
						when 2 => row <= "11011111"; col_r <= "01000110"; col_g <= "00000000";
						when 3 => row <= "11101111"; col_r <= "01000110"; col_g <= "00000000";
						when 4 => row <= "11110111"; col_r <= "00111110"; col_g <= "00000000";
						when 5 => row <= "11111011"; col_r <= "00000110"; col_g <= "00000000";
						when 6 => row <= "11111101"; col_r <= "00000110"; col_g <= "00000000";
						when 7 => row <= "11111110"; col_r <= "00000110"; col_g <= "00000000";
						when others => null;
						end case;
			when 3 => case scan_cnt is		--T(green)
						when 0 => row <= "01111111"; col_r <= "00000000"; col_g <= "11111111";
						when 1 => row <= "10111111"; col_r <= "00000000"; col_g <= "11111111";
						when 2 => row <= "11011111"; col_r <= "00000000"; col_g <= "00011000";
						when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00011000";
						when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00011000";
						when 5 => row <= "11111011"; col_r <= "00000000"; col_g <= "00011000";
						when 6 => row <= "11111101"; col_r <= "00000000"; col_g <= "00011000";
						when 7 => row <= "11111110"; col_r <= "00000000"; col_g <= "00011000";
						when others => null;
						end case;
			when 4 => case scan_cnt is		--Z(yellow)
						when 0 => row <= "01111111"; col_r <= "11111111"; col_g <= "11111111";
						when 1 => row <= "10111111"; col_r <= "01111111"; col_g <= "01111111";
						when 2 => row <= "11011111"; col_r <= "00100000"; col_g <= "00100000";
						when 3 => row <= "11101111"; col_r <= "00010000"; col_g <= "00010000";
						when 4 => row <= "11110111"; col_r <= "00001000"; col_g <= "00001000";
						when 5 => row <= "11111011"; col_r <= "00000100"; col_g <= "00000100";
						when 6 => row <= "11111101"; col_r <= "11111110"; col_g <= "11111110";
						when 7 => row <= "11111110"; col_r <= "11111111"; col_g <= "11111111";
						when others => null;
						end case;
			when 5 => case scan_cnt is		--Z(red)
						when 0 => row <= "01111111"; col_r <= "11111111"; col_g <= "00000000";
						when 1 => row <= "10111111"; col_r <= "01111111"; col_g <= "00000000";
						when 2 => row <= "11011111"; col_r <= "00100000"; col_g <= "00000000";
						when 3 => row <= "11101111"; col_r <= "00010000"; col_g <= "00000000";
						when 4 => row <= "11110111"; col_r <= "00001000"; col_g <= "00000000";
						when 5 => row <= "11111011"; col_r <= "00000100"; col_g <= "00000000";
						when 6 => row <= "11111101"; col_r <= "11111110"; col_g <= "00000000";
						when 7 => row <= "11111110"; col_r <= "11111111"; col_g <= "00000000";
						when others => null;
						end case;
			when 6 => case scan_cnt is		--Y(green)
						when 0 => row <= "01111111"; col_r <= "00000000"; col_g <= "00000000";
						when 1 => row <= "10111111"; col_r <= "00000000"; col_g <= "11000011";
						when 2 => row <= "11011111"; col_r <= "00000000"; col_g <= "01100110";
						when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00111100";
						when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00011000";
						when 5 => row <= "11111011"; col_r <= "00000000"; col_g <= "00011000";
						when 6 => row <= "11111101"; col_r <= "00000000"; col_g <= "00011000";
						when 7 => row <= "11111110"; col_r <= "00000000"; col_g <= "00011000";
						when others => null;
						end case;
			when others => null;
		end case;
		end if;
	end process P4;
end;
	
			
				

		