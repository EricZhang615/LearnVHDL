library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity LightSensor is
  port(
  LightSigIn: in STD_LOGIC;
  clk: in STD_LOGIC;
  TestSigOut: out STD_LOGIC;

  LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0);
  LCDEnable: out STD_LOGIC
  );
end LightSensor;            --dark 1 light 0

architecture LightSensor_arch of LightSensor is
  signal tmp1: STD_LOGIC:='1';
begin

  process
  begin
    if tmp1 = '1' then
      LCDEnable <= '1';
      LCDSigOut <= "0000000110";
    else
      null;
    end if;
    wait until rising_edge(clk);
  end process;

  process
  begin
    if tmp1 = '1' then
      LCDSigOut <= "0000001100";
    else
      null;
    end if;
    wait until rising_edge(clk);
  end process;

  process
  begin
    if tmp1 = '1' then
      LCDSigOut <= "0000111011";
    else
      null;
    end if;
    wait until rising_edge(clk);
  end process;

  process
  begin
    if tmp1 = '1' then
      LCDSigOut <= "0000000001";
    else
      null;
    end if;
    wait until rising_edge(clk);
  end process;

  tmp1 <= '0';

  P1 : process(LightSigIn)
  begin
    TestSigOut <= LightSigIn;
  end process;

  LCDSigOut <= "0010000000";
  --wait until rising_edge(clk);

  Disp : process
  begin
    if LightSigIn = '1' then

      LCDSigOut <= "1001010011";


      -- LCDSigOut <= "0010000001";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001010100";
      -- wait until rising_edge(clk);
      --
      -- LCDSigOut <= "0010000010";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001000001";
      -- wait until rising_edge(clk);
      --
      -- LCDSigOut <= "0010000011";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001001110";
      -- wait until rising_edge(clk);
      --
      -- LCDSigOut <= "0010000100";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001000100";
      -- wait until rising_edge(clk);
      --
      --
      -- LCDSigOut <= "0010000101";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1000100000";
      -- wait until rising_edge(clk);
      --
      --
      -- LCDSigOut <= "0010000110";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001000010";
      -- wait until rising_edge(clk);
      --
      -- LCDSigOut <= "0010000111";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "1001011001";
      -- wait until rising_edge(clk);
    else
      -- LCDSigOut <= "0000000001";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "0000000001";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "0000000001";
      -- wait until rising_edge(clk);
      -- LCDSigOut <= "0000000001";
      -- wait until rising_edge(clk);
      null;
    end if;
    wait until rising_edge(clk);
  end process;



end LightSensor_arch;
