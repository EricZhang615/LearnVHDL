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
  TubeDisp7Out: out STD_LOGIC_VECTOR(6 downto 0);
  TubeDisp6Out: out STD_LOGIC_VECTOR(6 downto 0);
  TubeDisp1Out: out STD_LOGIC_VECTOR(6 downto 0);
  TubeDisp0Out: out STD_LOGIC_VECTOR(6 downto 0)
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

  component DigitalTubeCounter
    port(
    CountSec: in STD_LOGIC_VECTOR(5 downto 0);
    TubeCode7Out: out STD_LOGIC_VECTOR(3 downto 0);
    TubeCode6Out: out STD_LOGIC_VECTOR(3 downto 0);
    TubeCode1Out: out STD_LOGIC_VECTOR(3 downto 0);
    TubeCode0Out: out STD_LOGIC_VECTOR(3 downto 0)
    );
  end component;

  component DigitalTube
    port(
    TubeCodeIn: in STD_LOGIC_VECTOR(3 downto 0);
    TubeDispOut: out STD_LOGIC_VECTOR(6 downto 0)
    );
  end component;


  signal clk_1s: STD_LOGIC;
  signal ts: STD_LOGIC_VECTOR(2 downto 0);
  signal cs: STD_LOGIC_VECTOR(5 downto 0);
  signal TubeCode7: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode6: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode1: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode0: STD_LOGIC_VECTOR(3 downto 0);


begin
  crossover:crossover1000 port map(clk=>clk,rst=>rst,clkout=>clk_1s);
  maincounter:counter port map(clk=>clk_1s,rst=>rst,TrafficState=>ts,CountSec=>cs);
  DTC:DigitalTubeCounter port map(CountSec=>cs,TubeCode7Out=>TubeCode7,TubeCode6Out=>TubeCode6,TubeCode1Out=>TubeCode1,TubeCode0Out=>TubeCode0);
  DT7:DigitalTube port map(TubeCodeIn=>TubeCode7,TubeDispOut=>TubeDisp7Out);
  DT6:DigitalTube port map(TubeCodeIn=>TubeCode6,TubeDispOut=>TubeDisp6Out);
  DT1:DigitalTube port map(TubeCodeIn=>TubeCode1,TubeDispOut=>TubeDisp1Out);
  DT0:DigitalTube port map(TubeCodeIn=>TubeCode0,TubeDispOut=>TubeDisp0Out);
  dot_array:dotdisp port map(clk=>clk,TrafficState=>ts,row=>row,col_r=>col_r,col_g=>col_g);
end TrafficLightsControl_arch;
