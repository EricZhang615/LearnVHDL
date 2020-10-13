library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity Beep is
  port(
  clk: in STD_LOGIC;
  TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
  BeepSig: out STD_LOGIC
  );
end Beep;

architecture Beep_arch of Beep is
  signal alert: STD_LOGIC:='0';
  signal slowclk: STD_LOGIC:='0';
  signal fastclk: STD_LOGIC:='0';

begin
  P1:process(clk)
  variable c1: integer range 0 to 1:=0;
  begin
    if rising_edge(clk) then
      if c1=1 then
        alert <= not alert;
        c1:=0;
      else
        c1:=c1+1;
      end if;
    end if;
  end process P1;

  P2 : process(clk)
  variable c2: integer range 0 to 3:=0;
  variable c3: integer range 0 to 249:=0;
  begin
    if rising_edge(clk) then
      if c3=249 then
        if c2=3 then
          c2:=0;
        else
          c2:=c2+1;
        end if;
        c3:=0;
      else
        c3:=c3+1;
      end if;
    end if;
    case c2 is
      when 3 => slowclk <= '1';
      when others => slowclk <= '0';
    end case;
    case c2 is
      when 1 => fastclk <= '1';
      when 3 => fastclk <= '1';
      when others => fastclk <= '0';
    end case;
  end process P2;

  P3 : process(TrafficState)
  begin
    if TrafficState="000" or TrafficState="001" then
      BeepSig <= slowclk AND alert;
    elsif TrafficState="010" or TrafficState="011" then
      BeepSig <= fastclk AND alert;
    else
      BeepSig <= '0'; 
    end if;
  end process;
end Beep_arch;
