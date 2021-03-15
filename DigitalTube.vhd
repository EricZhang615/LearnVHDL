library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity DigitalTube is
  port(
  TubeCodeIn: in STD_LOGIC_VECTOR(3 downto 0);      --输入信号 指示要输出的数字
  TubeDispOut: out STD_LOGIC_VECTOR(6 downto 0)     --输出信号 驱动对应数码管以显示数字
  );
end DigitalTube;

architecture DigitalTube_arch of DigitalTube is

begin
  P1:process(TubeCodeIn)
  begin
    case TubeCodeIn is                               --case语句实现数码管译码电路
      when "0000" => TubeDispOut <= "1111110";--0
      when "0001" => TubeDispOut <= "0110000";--1
      when "0010" => TubeDispOut <= "1101101";--2
      when "0011" => TubeDispOut <= "1111001";--3
      when "0100" => TubeDispOut <= "0110011";--4
      when "0101" => TubeDispOut <= "1011011";--5
      when "0110" => TubeDispOut <= "1011111";--6
      when "0111" => TubeDispOut <= "1110000";--7
      when "1000" => TubeDispOut <= "1111111";--8
      when "1001" => TubeDispOut <= "1111011";--9
      when "1010" => TubeDispOut <= "1110111";--A
      when "1011" => TubeDispOut <= "0011111";--b
      when "1100" => TubeDispOut <= "1001110";--C
      when "1101" => TubeDispOut <= "0111101";--d
      when "1110" => TubeDispOut <= "1001111";--E
      when "1111" => TubeDispOut <= "1000111";--F
      when others => null;
    end case;
  end process P1;
end DigitalTube_arch;
