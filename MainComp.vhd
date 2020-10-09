library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity TrafficLightsControl is
  port(
  clk: in STD_LOGIC;
  rst: in STD_LOGIC;
  test_output: out STD_LOGIC
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

begin
  crossover:crossover1000 port map(clk=>clk,rst=>rst,clkout=>test_output);
end TrafficLightsControl_arch;
