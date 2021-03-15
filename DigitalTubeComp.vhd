library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity DigitalTubeComp is           --将需的数码管信号集中 并按照时钟扫描输出
  port(
  clk: in STD_LOGIC;
  TubeDisp7In: in STD_LOGIC_VECTOR(6 downto 0); --输入数码管信号
  TubeDisp6In: in STD_LOGIC_VECTOR(6 downto 0);
  TubeDisp1In: in STD_LOGIC_VECTOR(6 downto 0);
  TubeDisp0In: in STD_LOGIC_VECTOR(6 downto 0);
  TubeDispOut: out STD_LOGIC_VECTOR(6 downto 0);  --选通输出数码管信号
  TubeDispScan: out STD_LOGIC_VECTOR(7 downto 0)  --数码管扫描信号
  );
end DigitalTubeComp;

architecture DigitalTubeComp_arch of DigitalTubeComp is
  signal scan_cnt: integer range 0 to 3;

begin
  P1:process(clk)             --模4计数
  begin
    if rising_edge(clk) then
      if scan_cnt = 3 then		--bits counter mods 3
				scan_cnt <= 0;
			else
				scan_cnt <= scan_cnt+1;
			end if;
    end if;
  end process P1;

  P2:process(scan_cnt)        --按照计数器选通信号 并输出扫描驱动信号
  begin
    case scan_cnt is
      when 0 => TubeDispScan <= "01111111"; TubeDispOut <= TubeDisp7In;
      when 1 => TubeDispScan <= "10111111"; TubeDispOut <= TubeDisp6In;
      when 2 => TubeDispScan <= "11111101"; TubeDispOut <= TubeDisp1In;
      when 3 => TubeDispScan <= "11111110"; TubeDispOut <= TubeDisp0In;
      when others => null;
    end case;
  end process P2;

end DigitalTubeComp_arch;
