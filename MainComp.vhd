library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity TrafficLightsControl is
  port(
  clk: in STD_LOGIC;
  rst: in STD_LOGIC;
  row: out STD_LOGIC_VECTOR(7 downto 0);
  col_r: out STD_LOGIC_VECTOR(7 downto 0);	--output signal for selecting columns of red lights
  col_g: out STD_LOGIC_VECTOR(7 downto 0);		--output signal for selecting columns of green lights
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

  component dotdisp
    port(
    clk: in STD_LOGIC;
    TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
    row: out STD_LOGIC_VECTOR(7 downto 0);		--output signal for selecting and scanning rows of the displayer
    col_r: out STD_LOGIC_VECTOR(7 downto 0);	--output signal for selecting columns of red lights
    col_g: out STD_LOGIC_VECTOR(7 downto 0)		--output signal for selecting columns of green lights
    );
  end component;

  signal clk_1s: STD_LOGIC;
  signal ts: STD_LOGIC_VECTOR(2 downto 0);

begin
  crossover:crossover1000 port map(clk=>clk,rst=>rst,clkout=>clk_1s);
  maincounter:counter port map(clk=>clk_1s,rst=>rst,TrafficState=>ts,CountSec=>CS);
  dot_array:dotdisp port map(clk=>clk,TrafficState=>ts,row=>row,col_r=>col_r,col_g=>col_g);
end TrafficLightsControl_arch;
