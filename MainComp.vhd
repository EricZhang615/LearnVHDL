library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity TrafficLightsControl is
  port(
  clk: in STD_LOGIC;
  rst: in STD_LOGIC;
  adjust: in STD_LOGIC;
  LightSens: in STD_LOGIC;

  row: out STD_LOGIC_VECTOR(7 downto 0);
  col_r: out STD_LOGIC_VECTOR(7 downto 0);	--output signal for selecting columns of red lights
  col_g: out STD_LOGIC_VECTOR(7 downto 0);		--output signal for selecting columns of green lights
  --TubeDisp7Out: out STD_LOGIC_VECTOR(6 downto 0);
  --TubeDisp6Out: out STD_LOGIC_VECTOR(6 downto 0);
  --TubeDisp1Out: out STD_LOGIC_VECTOR(6 downto 0);
  --TubeDisp0Out: out STD_LOGIC_VECTOR(6 downto 0)
  TubeDispOut: out STD_LOGIC_VECTOR(6 downto 0);
  TubeDispScan: out STD_LOGIC_VECTOR(7 downto 0);
  BeepOut: out STD_LOGIC;
  --TestSigOut: out STD_LOGIC
  LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0);
  LCDEnable: out STD_LOGIC
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
    adjust: in STD_LOGIC;
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
    adjust: in STD_LOGIC;
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

  component DigitalTubeComp is
    port(
    clk: in STD_LOGIC;
    TubeDisp7In: in STD_LOGIC_VECTOR(6 downto 0);
    TubeDisp6In: in STD_LOGIC_VECTOR(6 downto 0);
    TubeDisp1In: in STD_LOGIC_VECTOR(6 downto 0);
    TubeDisp0In: in STD_LOGIC_VECTOR(6 downto 0);
    TubeDispOut: out STD_LOGIC_VECTOR(6 downto 0);
    TubeDispScan: out STD_LOGIC_VECTOR(7 downto 0)
    );
  end component;

  component Stabilizer
    port(
    clk: in STD_LOGIC;
    InputButton: in STD_LOGIC;
    OutputButton: out STD_LOGIC
    );
  end component;

  component Beep
    port(
    clk: in STD_LOGIC;
    TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
    BeepSig: out STD_LOGIC
    );
  end component;

  component LightSensor
    port(
    LightSigIn: in STD_LOGIC;
    clk: in STD_LOGIC;
    TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
    --TestSigOut: out STD_LOGIC;
    clk_4s: out STD_LOGIC;
    LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0)
    --LCDEnable: out STD_LOGIC
    );
  end component;



  signal rst_stb: STD_LOGIC;
  signal clk_1s: STD_LOGIC;
  signal ts: STD_LOGIC_VECTOR(2 downto 0);
  signal cs: STD_LOGIC_VECTOR(5 downto 0);
  signal TubeCode7: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode6: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode1: STD_LOGIC_VECTOR(3 downto 0);
  signal TubeCode0: STD_LOGIC_VECTOR(3 downto 0);

  signal TubeDisp7Sig: STD_LOGIC_VECTOR(6 downto 0);
  signal TubeDisp6Sig: STD_LOGIC_VECTOR(6 downto 0);
  signal TubeDisp1Sig: STD_LOGIC_VECTOR(6 downto 0);
  signal TubeDisp0Sig: STD_LOGIC_VECTOR(6 downto 0);


begin

  stab:Stabilizer port map(clk=>clk,InputButton=>rst,OutputButton=>rst_stb);
  crossover:crossover1000 port map(clk=>clk,rst=>rst_stb,clkout=>clk_1s);
  maincounter:counter port map(clk=>clk_1s,rst=>rst_stb,adjust=>adjust,TrafficState=>ts,CountSec=>cs);
  DTC:DigitalTubeCounter port map(CountSec=>cs,adjust=>adjust,TubeCode7Out=>TubeCode7,TubeCode6Out=>TubeCode6,TubeCode1Out=>TubeCode1,TubeCode0Out=>TubeCode0);
  DT7:DigitalTube port map(TubeCodeIn=>TubeCode7,TubeDispOut=>TubeDisp7Sig);
  DT6:DigitalTube port map(TubeCodeIn=>TubeCode6,TubeDispOut=>TubeDisp6Sig);
  DT1:DigitalTube port map(TubeCodeIn=>TubeCode1,TubeDispOut=>TubeDisp1Sig);
  DT0:DigitalTube port map(TubeCodeIn=>TubeCode0,TubeDispOut=>TubeDisp0Sig);
  DigTube:DigitalTubeComp port map(clk=>clk,TubeDisp7In=>TubeDisp7Sig,TubeDisp6In=>TubeDisp6Sig,TubeDisp1In=>TubeDisp1Sig,TubeDisp0In=>TubeDisp0Sig,TubeDispOut=>TubeDispOut,TubeDispScan=>TubeDispScan);
  dot_array:dotdisp port map(clk=>clk,TrafficState=>ts,row=>row,col_r=>col_r,col_g=>col_g);
  BP:Beep port map(clk=>clk,TrafficState=>ts,BeepSig=>BeepOut);
  LS:LightSensor port map(LightSigIn=>LightSens,clk=>clk,TrafficState=>ts,LCDSigOut=>LCDSigOut,clk_4s=>LCDEnable);
end TrafficLightsControl_arch;
