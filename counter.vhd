library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity counter is
  port(
  clk: in STD_LOGIC;
  rst: in STD_LOGIC;
  TrafficState: out STD_LOGIC_VECTOR(2 downto 0);
  CountSec: out STD_LOGIC_VECTOR(5 downto 0)
  );
end counter;


architecture counter_arch of counter is
  signal cnt_tmp: integer range 0 to 42:=0;

begin
  P1:process(clk,rst)
  begin
    if rst = '1' then
      cnt_tmp <= 40;
    elsif rising_edge(clk) then
      if cnt_tmp = 42 or cnt_tmp = 39 then
        cnt_tmp <= 0;
      else
        cnt_tmp <= cnt_tmp + 1;
      end if;
    end if;
  end process P1;

  CountSec <= conv_std_logic_vector(cnt_tmp,6);

  P2:process(cnt_tmp)
  begin
    if cnt_tmp <= 14 then
      TrafficState <= "000";
    elsif cnt_tmp <= 19 then
      TrafficState <= "001";
    elsif cnt_tmp <= 34 then
      TrafficState <= "010";
    elsif cnt_tmp <= 39 then
      TrafficState <= "011";
    else
      TrafficState <= "100";
    end if;
  end process P2;

end counter_arch;
