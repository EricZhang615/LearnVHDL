library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity Stabilizer is
  port(
  clk: in STD_LOGIC;
  InputButton: in STD_LOGIC;
  OutputButton: out STD_LOGIC
  );
end Stabilizer;

architecture Stabilizer_arch of Stabilizer is
  signal tmp1, tmp2: STD_LOGIC;
  signal clk_10ms: STD_LOGIC:='1';

begin
  crossover:process(clk)
  variable c: integer range 0 to 4:=0;
  begin
    if rising_edge(clk) then
      if c=4 then
        clk_10ms <= not clk_10ms;
        c:=0;
      else
        c:=c+1;
      end if;
    end if;
  end process crossover;

  stab:process(clk_10ms)
  begin
    if (clk'EVENT and clk='0') then
      tmp2 <= tmp1;
      tmp1 <= InputButton;
    end if;
  end process stab;

  OutputButton <= clk_10ms and tmp1 and (not tmp2);

end Stabilizer_arch;
