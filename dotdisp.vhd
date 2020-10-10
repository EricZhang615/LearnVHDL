library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity dotdisp is
  port(
  clk: in STD_LOGIC;
  TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
  row: out STD_LOGIC_VECTOR(7 downto 0);		--output signal for selecting and scanning rows of the displayer
  col_r: out STD_LOGIC_VECTOR(7 downto 0);	--output signal for selecting columns of red lights
  col_g: out STD_LOGIC_VECTOR(7 downto 0)		--output signal for selecting columns of green lights
  );
end dotdisp;

architecture dotdisp_arch of dotdisp is
  signal scan_cnt: integer range 0 to 7;		--be used for counting rows

begin
  P1:process(clk)
  begin
    if rising_edge(clk) then
      if scan_cnt = 7 then		--row counter mods 8
				scan_cnt <= 0;
			else
				scan_cnt <= scan_cnt+1;
			end if;
    end if;
  end process P1;

  P2:process(scan_cnt,TrafficState)
  begin
    case TrafficState is
      when "000" => case scan_cnt is
        when 0 => row <= "01111111"; col_r <= "00000000"; col_g <= "01100000";
        when 1 => row <= "10111111"; col_r <= "00000011"; col_g <= "01100000";
        when 2 => row <= "11011111"; col_r <= "00000011"; col_g <= "00000000";
        when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00000000";
        when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00000000";
        when 5 => row <= "11111011"; col_r <= "11000000"; col_g <= "00000000";
        when 6 => row <= "11111101"; col_r <= "11000000"; col_g <= "00000110";
        when 7 => row <= "11111110"; col_r <= "00000000"; col_g <= "00000110";
        when others => null;
      end case;
      when "001" => case scan_cnt is
        when 0 => row <= "01111111"; col_r <= "01100000"; col_g <= "01100000";
        when 1 => row <= "10111111"; col_r <= "01100011"; col_g <= "01100000";
        when 2 => row <= "11011111"; col_r <= "00000011"; col_g <= "00000000";
        when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00000000";
        when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00000000";
        when 5 => row <= "11111011"; col_r <= "11000000"; col_g <= "00000000";
        when 6 => row <= "11111101"; col_r <= "11000110"; col_g <= "00000110";
        when 7 => row <= "11111110"; col_r <= "00000110"; col_g <= "00000110";
        when others => null;
      end case;
      when "010" => case scan_cnt is
        when 0 => row <= "01111111"; col_r <= "01100000"; col_g <= "00000000";
        when 1 => row <= "10111111"; col_r <= "01100000"; col_g <= "00000011";
        when 2 => row <= "11011111"; col_r <= "00000000"; col_g <= "00000011";
        when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00000000";
        when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00000000";
        when 5 => row <= "11111011"; col_r <= "00000000"; col_g <= "11000000";
        when 6 => row <= "11111101"; col_r <= "00000110"; col_g <= "11000000";
        when 7 => row <= "11111110"; col_r <= "00000110"; col_g <= "00000000";
        when others => null;
      end case;
      when "011" => case scan_cnt is
        when 0 => row <= "01111111"; col_r <= "01100000"; col_g <= "00000000";
        when 1 => row <= "10111111"; col_r <= "01100011"; col_g <= "00000011";
        when 2 => row <= "11011111"; col_r <= "00000011"; col_g <= "00000011";
        when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00000000";
        when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00000000";
        when 5 => row <= "11111011"; col_r <= "11000000"; col_g <= "11000000";
        when 6 => row <= "11111101"; col_r <= "11000110"; col_g <= "11000000";
        when 7 => row <= "11111110"; col_r <= "00000110"; col_g <= "00000000";
        when others => null;
      end case;
      when "100" => case scan_cnt is
        when 0 => row <= "01111111"; col_r <= "01100000"; col_g <= "00000000";
        when 1 => row <= "10111111"; col_r <= "01100011"; col_g <= "00000000";
        when 2 => row <= "11011111"; col_r <= "00000011"; col_g <= "00000000";
        when 3 => row <= "11101111"; col_r <= "00000000"; col_g <= "00000000";
        when 4 => row <= "11110111"; col_r <= "00000000"; col_g <= "00000000";
        when 5 => row <= "11111011"; col_r <= "11000000"; col_g <= "00000000";
        when 6 => row <= "11111101"; col_r <= "11000110"; col_g <= "00000000";
        when 7 => row <= "11111110"; col_r <= "00000110"; col_g <= "00000000";
        when others => null;
      end case;
      when others => null;
    end case;
  end process P2;

end dotdisp_arch;
