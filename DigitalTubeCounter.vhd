library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity DigitalTubeCounter is        --数码管计数模块 实现按照当前交通状态和时钟输出确定的数码管信号
  port(
  CountSec: in STD_LOGIC_VECTOR(5 downto 0);  --主模块当前计数值
  adjust: in STD_LOGIC;                       --当前adjust切换两种红绿灯时间间隔模式
  TubeCode7Out: out STD_LOGIC_VECTOR(3 downto 0); --输出数码管要显示的数字二进制值
  TubeCode6Out: out STD_LOGIC_VECTOR(3 downto 0);
  TubeCode1Out: out STD_LOGIC_VECTOR(3 downto 0);
  TubeCode0Out: out STD_LOGIC_VECTOR(3 downto 0)
  );
end DigitalTubeCounter;

architecture DigitalTubeCounter_arch of DigitalTubeCounter is


begin
  P1:process(CountSec,adjust)     --依据主模块当前计数值输出要显示的数字二进制值
  begin
    if adjust = '0' then
    case CountSec is
      --红 绿
      when "000000" => TubeCode7Out <= "0010"; TubeCode6Out <= "0000"; TubeCode1Out <= "0001"; TubeCode0Out <= "0101";--20 15
      when "000001" => TubeCode7Out <= "0001"; TubeCode6Out <= "1001"; TubeCode1Out <= "0001"; TubeCode0Out <= "0100";--19 14
      when "000010" => TubeCode7Out <= "0001"; TubeCode6Out <= "1000"; TubeCode1Out <= "0001"; TubeCode0Out <= "0011";--18 13
      when "000011" => TubeCode7Out <= "0001"; TubeCode6Out <= "0111"; TubeCode1Out <= "0001"; TubeCode0Out <= "0010";--17 12
      when "000100" => TubeCode7Out <= "0001"; TubeCode6Out <= "0110"; TubeCode1Out <= "0001"; TubeCode0Out <= "0001";
      when "000101" => TubeCode7Out <= "0001"; TubeCode6Out <= "0101"; TubeCode1Out <= "0001"; TubeCode0Out <= "0000";
      when "000110" => TubeCode7Out <= "0001"; TubeCode6Out <= "0100"; TubeCode1Out <= "0000"; TubeCode0Out <= "1001";
      when "000111" => TubeCode7Out <= "0001"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "1000";
      when "001000" => TubeCode7Out <= "0001"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0111";
      when "001001" => TubeCode7Out <= "0001"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0110";--11 06
      when "001010" => TubeCode7Out <= "0001"; TubeCode6Out <= "0000"; TubeCode1Out <= "0000"; TubeCode0Out <= "0101";--10 05
      when "001011" => TubeCode7Out <= "0000"; TubeCode6Out <= "1001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0100";
      when "001100" => TubeCode7Out <= "0000"; TubeCode6Out <= "1000"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "001101" => TubeCode7Out <= "0000"; TubeCode6Out <= "0111"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "001110" => TubeCode7Out <= "0000"; TubeCode6Out <= "0110"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";--06 01
      --红 黄
      when "001111" => TubeCode7Out <= "0000"; TubeCode6Out <= "0101"; TubeCode1Out <= "0000"; TubeCode0Out <= "0101";--05 05
      when "010000" => TubeCode7Out <= "0000"; TubeCode6Out <= "0100"; TubeCode1Out <= "0000"; TubeCode0Out <= "0100";
      when "010001" => TubeCode7Out <= "0000"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "010010" => TubeCode7Out <= "0000"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "010011" => TubeCode7Out <= "0000"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";--01 01
      --绿 红
      when "010100" => TubeCode1Out <= "0010"; TubeCode0Out <= "0000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0101";--15 20
      when "010101" => TubeCode1Out <= "0001"; TubeCode0Out <= "1001"; TubeCode7Out <= "0001"; TubeCode6Out <= "0100";
      when "010110" => TubeCode1Out <= "0001"; TubeCode0Out <= "1000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0011";
      when "010111" => TubeCode1Out <= "0001"; TubeCode0Out <= "0111"; TubeCode7Out <= "0001"; TubeCode6Out <= "0010";
      when "011000" => TubeCode1Out <= "0001"; TubeCode0Out <= "0110"; TubeCode7Out <= "0001"; TubeCode6Out <= "0001";
      when "011001" => TubeCode1Out <= "0001"; TubeCode0Out <= "0101"; TubeCode7Out <= "0001"; TubeCode6Out <= "0000";
      when "011010" => TubeCode1Out <= "0001"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "1001";
      when "011011" => TubeCode1Out <= "0001"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "1000";
      when "011100" => TubeCode1Out <= "0001"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0111";
      when "011101" => TubeCode1Out <= "0001"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0110";
      when "011110" => TubeCode1Out <= "0001"; TubeCode0Out <= "0000"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";
      when "011111" => TubeCode1Out <= "0000"; TubeCode0Out <= "1001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "100000" => TubeCode1Out <= "0000"; TubeCode0Out <= "1000"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "100001" => TubeCode1Out <= "0000"; TubeCode0Out <= "0111"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "100010" => TubeCode1Out <= "0000"; TubeCode0Out <= "0110"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";
      --黄 红
      when "100011" => TubeCode1Out <= "0000"; TubeCode0Out <= "0101"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";--05 05
      when "100100" => TubeCode1Out <= "0000"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "100101" => TubeCode1Out <= "0000"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "100110" => TubeCode1Out <= "0000"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "100111" => TubeCode1Out <= "0000"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";
      --复位态
      when "101000" => TubeCode7Out <= "0000"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";--03 03
      when "101001" => TubeCode7Out <= "0000"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";--02 02
      when "101010" => TubeCode7Out <= "0000"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";--01 01
      when others => null;
    end case;
    else
    case CountSec is
      --红 绿
      when "000000" => TubeCode1Out <= "0001"; TubeCode0Out <= "0000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0101";--15 10
      when "000001" => TubeCode1Out <= "0000"; TubeCode0Out <= "1001"; TubeCode7Out <= "0001"; TubeCode6Out <= "0100";--14 09
      when "000010" => TubeCode1Out <= "0000"; TubeCode0Out <= "1000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0011";
      when "000011" => TubeCode1Out <= "0000"; TubeCode0Out <= "0111"; TubeCode7Out <= "0001"; TubeCode6Out <= "0010";
      when "000100" => TubeCode1Out <= "0000"; TubeCode0Out <= "0110"; TubeCode7Out <= "0001"; TubeCode6Out <= "0001";
      when "000101" => TubeCode1Out <= "0000"; TubeCode0Out <= "0101"; TubeCode7Out <= "0001"; TubeCode6Out <= "0000";
      when "000110" => TubeCode1Out <= "0000"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "1001";
      when "000111" => TubeCode1Out <= "0000"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "1000";
      when "001000" => TubeCode1Out <= "0000"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0111";
      when "001001" => TubeCode1Out <= "0000"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0110";
      --红 黄
      when "001010" => TubeCode1Out <= "0000"; TubeCode0Out <= "0101"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";--05 05
      when "001011" => TubeCode1Out <= "0000"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "001100" => TubeCode1Out <= "0000"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "001101" => TubeCode1Out <= "0000"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "001110" => TubeCode1Out <= "0000"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";
      --绿 红
      when "001111" => TubeCode7Out <= "0010"; TubeCode6Out <= "0000"; TubeCode1Out <= "0010"; TubeCode0Out <= "0101";--20 25
      when "010000" => TubeCode7Out <= "0001"; TubeCode6Out <= "1001"; TubeCode1Out <= "0010"; TubeCode0Out <= "0100";
      when "010001" => TubeCode7Out <= "0001"; TubeCode6Out <= "1000"; TubeCode1Out <= "0010"; TubeCode0Out <= "0011";
      when "010010" => TubeCode7Out <= "0001"; TubeCode6Out <= "0111"; TubeCode1Out <= "0010"; TubeCode0Out <= "0010";
      when "010011" => TubeCode7Out <= "0001"; TubeCode6Out <= "0110"; TubeCode1Out <= "0010"; TubeCode0Out <= "0001";
      when "010100" => TubeCode1Out <= "0010"; TubeCode0Out <= "0000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0101";
      when "010101" => TubeCode1Out <= "0001"; TubeCode0Out <= "1001"; TubeCode7Out <= "0001"; TubeCode6Out <= "0100";
      when "010110" => TubeCode1Out <= "0001"; TubeCode0Out <= "1000"; TubeCode7Out <= "0001"; TubeCode6Out <= "0011";
      when "010111" => TubeCode1Out <= "0001"; TubeCode0Out <= "0111"; TubeCode7Out <= "0001"; TubeCode6Out <= "0010";
      when "011000" => TubeCode1Out <= "0001"; TubeCode0Out <= "0110"; TubeCode7Out <= "0001"; TubeCode6Out <= "0001";
      when "011001" => TubeCode1Out <= "0001"; TubeCode0Out <= "0101"; TubeCode7Out <= "0001"; TubeCode6Out <= "0000";
      when "011010" => TubeCode1Out <= "0001"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "1001";
      when "011011" => TubeCode1Out <= "0001"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "1000";
      when "011100" => TubeCode1Out <= "0001"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0111";
      when "011101" => TubeCode1Out <= "0001"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0110";
      when "011110" => TubeCode1Out <= "0001"; TubeCode0Out <= "0000"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";
      when "011111" => TubeCode1Out <= "0000"; TubeCode0Out <= "1001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "100000" => TubeCode1Out <= "0000"; TubeCode0Out <= "1000"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "100001" => TubeCode1Out <= "0000"; TubeCode0Out <= "0111"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "100010" => TubeCode1Out <= "0000"; TubeCode0Out <= "0110"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";--01 06
      --黄 红
      when "100011" => TubeCode1Out <= "0000"; TubeCode0Out <= "0101"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";--05 05
      when "100100" => TubeCode1Out <= "0000"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "100101" => TubeCode1Out <= "0000"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "100110" => TubeCode1Out <= "0000"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "100111" => TubeCode1Out <= "0000"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";--01 01
      --复位态
      when "101000" => TubeCode7Out <= "0000"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "101001" => TubeCode7Out <= "0000"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "101010" => TubeCode7Out <= "0000"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";
      when others => null;
    end case;
    end if;
  end process P1;
end DigitalTubeCounter_arch;
