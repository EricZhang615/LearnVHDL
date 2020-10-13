library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity DigitalTubeCounter is
  port(
  CountSec: in STD_LOGIC_VECTOR(5 downto 0);
  TubeCode7Out: out STD_LOGIC_VECTOR(3 downto 0);
  TubeCode6Out: out STD_LOGIC_VECTOR(3 downto 0);
  TubeCode1Out: out STD_LOGIC_VECTOR(3 downto 0);
  TubeCode0Out: out STD_LOGIC_VECTOR(3 downto 0)
  );
end DigitalTubeCounter;

architecture DigitalTubeCounter_arch of DigitalTubeCounter is


begin
  P1:process(CountSec)
  begin
    case CountSec is
      when "000000" => TubeCode7Out <= "0010"; TubeCode6Out <= "0000"; TubeCode1Out <= "0001"; TubeCode0Out <= "0101";
      when "000001" => TubeCode7Out <= "0001"; TubeCode6Out <= "1001"; TubeCode1Out <= "0001"; TubeCode0Out <= "0100";
      when "000010" => TubeCode7Out <= "0001"; TubeCode6Out <= "1000"; TubeCode1Out <= "0001"; TubeCode0Out <= "0011";
      when "000011" => TubeCode7Out <= "0001"; TubeCode6Out <= "0111"; TubeCode1Out <= "0001"; TubeCode0Out <= "0010";
      when "000100" => TubeCode7Out <= "0001"; TubeCode6Out <= "0110"; TubeCode1Out <= "0001"; TubeCode0Out <= "0001";
      when "000101" => TubeCode7Out <= "0001"; TubeCode6Out <= "0101"; TubeCode1Out <= "0001"; TubeCode0Out <= "0000";
      when "000110" => TubeCode7Out <= "0001"; TubeCode6Out <= "0100"; TubeCode1Out <= "0000"; TubeCode0Out <= "1001";
      when "000111" => TubeCode7Out <= "0001"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "1000";
      when "001000" => TubeCode7Out <= "0001"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0111";
      when "001001" => TubeCode7Out <= "0001"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0110";

      when "001010" => TubeCode7Out <= "0001"; TubeCode6Out <= "0000"; TubeCode1Out <= "0000"; TubeCode0Out <= "0101";
      when "001011" => TubeCode7Out <= "0000"; TubeCode6Out <= "1001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0100";
      when "001100" => TubeCode7Out <= "0000"; TubeCode6Out <= "1000"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "001101" => TubeCode7Out <= "0000"; TubeCode6Out <= "0111"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "001110" => TubeCode7Out <= "0000"; TubeCode6Out <= "0110"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";
      when "001111" => TubeCode7Out <= "0000"; TubeCode6Out <= "0101"; TubeCode1Out <= "0000"; TubeCode0Out <= "0101";
      when "010000" => TubeCode7Out <= "0000"; TubeCode6Out <= "0100"; TubeCode1Out <= "0000"; TubeCode0Out <= "0100";
      when "010001" => TubeCode7Out <= "0000"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "010010" => TubeCode7Out <= "0000"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "010011" => TubeCode7Out <= "0000"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";

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
      when "100010" => TubeCode1Out <= "0000"; TubeCode0Out <= "0110"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";
      when "100011" => TubeCode1Out <= "0000"; TubeCode0Out <= "0101"; TubeCode7Out <= "0000"; TubeCode6Out <= "0101";
      when "100100" => TubeCode1Out <= "0000"; TubeCode0Out <= "0100"; TubeCode7Out <= "0000"; TubeCode6Out <= "0100";
      when "100101" => TubeCode1Out <= "0000"; TubeCode0Out <= "0011"; TubeCode7Out <= "0000"; TubeCode6Out <= "0011";
      when "100110" => TubeCode1Out <= "0000"; TubeCode0Out <= "0010"; TubeCode7Out <= "0000"; TubeCode6Out <= "0010";
      when "100111" => TubeCode1Out <= "0000"; TubeCode0Out <= "0001"; TubeCode7Out <= "0000"; TubeCode6Out <= "0001";


      when "101000" => TubeCode7Out <= "0000"; TubeCode6Out <= "0011"; TubeCode1Out <= "0000"; TubeCode0Out <= "0011";
      when "101001" => TubeCode7Out <= "0000"; TubeCode6Out <= "0010"; TubeCode1Out <= "0000"; TubeCode0Out <= "0010";
      when "101010" => TubeCode7Out <= "0000"; TubeCode6Out <= "0001"; TubeCode1Out <= "0000"; TubeCode0Out <= "0001";
      when others => null;
    end case;
  end process P1;
end DigitalTubeCounter_arch;
