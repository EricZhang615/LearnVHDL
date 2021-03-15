library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;				--import libraries

entity LightSensor is               --光信号输入与显示器输出模块
  port(                             --当监测到在红灯时有人靠近就会在显示器上显示警告语句
  LightSigIn: in STD_LOGIC;         --输入光信号 无人为0 有人为1
  clk: in STD_LOGIC;
  TrafficState: in STD_LOGIC_VECTOR(2 downto 0);
  clk_8ms: out STD_LOGIC;
  LCDSigOut: out STD_LOGIC_VECTOR(9 downto 0)   --LCD屏幕驱动信号
  );
end LightSensor;

architecture LightSensor_arch of LightSensor is
  --定义驱动状态
  type state_type is (init1,init2,init3,readIn,readIn2,printS,
  printT,printA,printN,printD,printUndersc,printB,printY,clear);
  signal CurrentState,NextState : state_type := init1;
  signal clk_tmp: STD_LOGIC:='1';
  begin
    process(clk)        --八分频
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

    clk_8ms <= clk_tmp;
    --两段式状态机
    P1:process(CurrentState,LightSigIn)
    begin
      case( CurrentState ) is

        when init1 =>                 --设置8位格式 单行显示 5*7
          LCDSigOut <= "0000110000";
          NextState <= init2;
        when init2 =>                 --整体显示 关光标 光标不闪烁
          LCDSigOut <= "0000001100";
          NextState <= init3;
        when init3 =>                 --输入方式 光标右移 整体不移位
          LCDSigOut <= "0000000110";
          NextState <= clear;
        when clear =>                 --清屏
          LCDSigOut <= "0000000001";
          NextState <= readIn;
        when readIn =>                --读入等待状态
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
        when printS =>                --S
          LCDSigOut <= "1001010011";
          NextState <= printT;
        when printT =>                --T
          LCDSigOut <= "1001010100";
          NextState <= printA;
        when printA =>                --A
          LCDSigOut <= "1001000001";
          NextState <= printN;
        when printN =>                --N
          LCDSigOut <= "1001001110";
          NextState <= printD;
        when printD =>                --D
          LCDSigOut <= "1001000100";
          NextState <= printUndersc;
        when printUndersc =>          --_
          LCDSigOut <= "1001011111";
          NextState <= printB;
        when printB =>                --B
          LCDSigOut <= "1001000010";
          NextState <= printY;
        when printY =>                --Y
          LCDSigOut <= "1001011001";
          NextState <= readIn2;
        when readIn2 =>               --显示完成 等待清屏指令
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

    P2:process(clk_tmp)                 --切换至下一状态
    begin
      if clk_tmp'event and clk_tmp = '0' then
        CurrentState <= NextState;
      end if;
    end process P2;
end LightSensor_arch;
