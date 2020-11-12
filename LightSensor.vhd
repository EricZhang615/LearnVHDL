library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity LightSensor is
  port(
  LightSigIn: in STD_LOGIC;
  clk: in STD_LOGIC;

  LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0)
  );
end LightSensor;            --dark 1 light 0

architecture LightSensor_arch of LightSensor is
  type state_type is (init1,init2,init3,readIn,printS,printT,printA,printN,printD,printUndersc,printB,printY,clear);
  signal CurrentState,NextState : state_type := init1;

  begin
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
          if LightSigIn = '0' then
            NextState <= clear;
          else
            NextState <= printS;
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
          NextState <= readIn;
        when others =>
          NextState <= init1;
      end case;
    end process P1;

    P2:process(clk)
    begin
      if clk'event and clk = '1' then
        CurrentState <= NextState;
      end if;
    end process P2;
end LightSensor_arch;
