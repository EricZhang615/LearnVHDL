library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity TrafficLightsControl is
  port(
  clk: in STD_LOGIC;
  rst: in STD_LOGIC;
  TS: out STD_LOGIC_VECTOR(2 downto 0);
  CS: out STD_LOGIC_VECTOR(5 downto 0)
  );
end TrafficLightsControl;

architecture TrafficLightsControl_arch of TrafficLightsControl is
  component crossover1000
    port(
    clk: in STD_LOGIC;
    rst: in STD_LOGIC;
    clkout: out STD_LOGIC
    );
  end component;

  component counter
    port(
    clk: in STD_LOGIC;
    rst: in STD_LOGIC;
    TrafficState: out STD_LOGIC_VECTOR(2 downto 0);
    CountSec: out STD_LOGIC_VECTOR(5 downto 0)
    );
  end component;

  signal clk_1s: STD_LOGIC;

begin
  crossover:crossover1000 port map(clk=>clk,rst=>rst,clkout=>clk_1s);
  counter:counter port map(clk=>clk_1s,rst=>rst,TrafficState=>TS,CountSec=>CS);
end TrafficLightsControl_arch;
