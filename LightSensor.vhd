library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity LightSensor is
  port(
  LightSigIn: in STD_LOGIC;
  clk: in STD_LOGIC;
  TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
  clk_4s: out STD_LOGIC;
  LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0)
  );
end LightSensor;            --dark 1 light 0

architecture LightSensor_arch of LightSensor is
  type state_type is (init1,init2,init3,readIn,readIn2,printS,printT,printA,printN,printD,printUndersc,printB,printY,clear);
  signal CurrentState,NextState : state_type := init1;
  signal clk_tmp: STD_LOGIC:='1';
  begin
    process(clk)
 	  variable c: integer range 0 to 3:= 0;
  	begin
 		   if rising_edge(clk) then
  			  if c=3 then
  				   clk_tmp <= not clk_tmp;
  				   c:=0;
  			  else
  				   c:=c+1;
  			  end if;
       end if;
    end process;

    clk_4s <= clk_tmp;

    P1:process(CurrentState,LightSigIn)
    begin
      case( CurrentState ) is

        when init1 =>
          LCDSigOut <= "0000110000";
          NextState <= init2;
        when init2 =>
          LCDSigOut <= "0000001100";
          NextState <= init3;
        when init3 =>
          LCDSigOut <= "0000000110";
          NextState <= clear;
        when clear =>
          LCDSigOut <= "0000000001";
          NextState <= readIn;
        when readIn =>
          LCDSigOut <= "0000000110";
          if LightSigIn = '0' then
            NextState <= readIn;
          else
            if TrafficState="000" or TrafficState="001" then
              NextState <= printS;
            else
              NextState <= readIn;
            end if;
          end if;
        when printS =>
          LCDSigOut <= "1001010011";
          NextState <= printT;
        when printT =>
          LCDSigOut <= "1001010100";
          NextState <= printA;
        when printA =>
          LCDSigOut <= "1001000001";
          NextState <= printN;
        when printN =>
          LCDSigOut <= "1001001110";
          NextState <= printD;
        when printD =>
          LCDSigOut <= "1001000100";
          NextState <= printUndersc;
        when printUndersc =>
          LCDSigOut <= "1001011111";
          NextState <= printB;
        when printB =>
          LCDSigOut <= "1001000010";
          NextState <= printY;
        when printY =>
          LCDSigOut <= "1001011001";
          NextState <= readIn2;
        when readIn2 =>
          LCDSigOut <= "0000000110";
          if TrafficState="000" or TrafficState="001" then
            if LightSigIn = '0' then
              NextState <= clear;
            else
              NextState <= readIn2;
            end if;
          else
            NextState <= clear;
          end if;

        when others =>
          NextState <= init1;
      end case;
    end process P1;

    P2:process(clk_tmp)
    begin
      if clk_tmp'event and clk_tmp = '0' then
        CurrentState <= NextState;
      end if;
    end process P2;
end LightSensor_arch;
