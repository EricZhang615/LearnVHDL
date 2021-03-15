library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity counter is
  port(
  clk: in STD_LOGIC;                --输入时钟
  rst: in STD_LOGIC;                --复位
  adjust: in STD_LOGIC;             --潮汐信号
  TrafficState: out STD_LOGIC_VECTOR(2 downto 0);   --交通状态 控制了整个系统当前的状态
  CountSec: out STD_LOGIC_VECTOR(5 downto 0)        --与交通状态绑定的当前计数码 用于部分模块的判定
  );
end counter;


architecture counter_arch of counter is
  signal cnt_tmp: integer range 0 to 42:=0;

begin
  P1:process(clk,rst)                               --模43计数器 计数到40或43都归零
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

  CountSec <= conv_std_logic_vector(cnt_tmp,6);     --转换格式方便模块间传输

  P2:process(cnt_tmp)
  begin                                   --adjust切换两种红绿灯时间间隔模式
    if adjust='0' then
      if cnt_tmp <= 14 then               --通过计数器输出不同时间段来规划当前交通状态
        TrafficState <= "000";            --状态1
      elsif cnt_tmp <= 19 then
        TrafficState <= "001";            --状态2
      elsif cnt_tmp <= 34 then
        TrafficState <= "010";            --状态3
      elsif cnt_tmp <= 39 then
        TrafficState <= "011";            --状态4
      else
        TrafficState <= "100";            --复位态
      end if;
    else
      if cnt_tmp <= 9 then
        TrafficState <= "000";
      elsif cnt_tmp <= 14 then
        TrafficState <= "001";
      elsif cnt_tmp <= 34 then
        TrafficState <= "010";
      elsif cnt_tmp <= 39 then
        TrafficState <= "011";
      else
        TrafficState <= "100";
      end if;
    end if;
  end process P2;

end counter_arch;
