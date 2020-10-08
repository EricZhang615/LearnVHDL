library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;				--import libraries

entity keybrd is
		port(
		clk:in std_logic;							--10us
		iptrow: in std_logic_vector(3 downto 0);		--输入扫描行信号
		outcol: out std_logic_vector(3 downto 0); 	--输出扫描列信号
		outsgn:out std_logic_vector(6 downto 0);		--输出数码管信号
		outbeep:out std_logic												--输出蜂鸣器序列
		);
end keybrd;

architecture keybrd_arch of keybrd is
signal clk_10ms:std_logic;											--低频时钟，当外部时钟为10us时此时钟为10ms
signal scancol:std_logic_vector(3 downto 0);		--扫描列信号的中间量，用于键值判断
signal data:std_logic_vector(3 downto 0);				--存储键值
signal scancnt: integer range 0 to 3;						--扫描计数
signal d:std_logic:='0';												--指示当前有无按键按下

signal beep1:std_logic:='0';										--音频信号
signal beep2:std_logic:='0';
signal beep3:std_logic:='0';
signal beep4:std_logic:='0';
signal beep5:std_logic:='0';
signal beep6:std_logic:='0';
signal beep7:std_logic:='0';
signal beep8:std_logic:='0';
signal beep9:std_logic:='0';
signal beep10:std_logic:='0';
signal beep11:std_logic:='0';
signal beep12:std_logic:='0';
signal beep13:std_logic:='0';
signal beep14:std_logic:='0';
signal beep15:std_logic:='0';
signal beep16:std_logic:='0';

begin

CLK10ms:process(clk)					--1000分频器，用于驱动列扫描信号
	variable c: integer range 0 to 499:= 0;
	begin
		if rising_edge(clk) then
			if c=499 then
				clk_10ms <= not clk_10ms;
				c:=0;
			else
				c:=c+1;
			end if;
		end if;
	end process CLK10ms;

B990hz:process(clk)						--以下16个process用于生成音频信号
	variable c16: integer range 0 to 49:= 0;
	begin
		if rising_edge(clk) then
			if c16=49 then
				beep16 <= not beep16;
				c16:=0;
			else
				c16:=c16+1;
			end if;
		end if;
	end process B990hz;

B880hz:process(clk)
	variable c15: integer range 0 to 56:= 0;
	begin
		if rising_edge(clk) then
			if c15=56 then
				beep15 <= not beep15;
				c15:=0;
			else
				c15:=c15+1;
			end if;
		end if;
	end process B880hz;

B792hz:process(clk)
	variable c14: integer range 0 to 62:= 0;
	begin
		if rising_edge(clk) then
			if c14=62 then
				beep14 <= not beep14;
				c14:=0;
			else
				c14:=c14+1;
			end if;
		end if;
	end process B792hz;

B704hz:process(clk)
	variable c13: integer range 0 to 70:= 0;
	begin
		if rising_edge(clk) then
			if c13=70 then
				beep13 <= not beep13;
				c13:=0;
			else
				c13:=c13+1;
			end if;
		end if;
	end process B704hz;

B660hz:process(clk)
	variable c12: integer range 0 to 75:= 0;
	begin
		if rising_edge(clk) then
			if c12=75 then
				beep12 <= not beep12;
				c12:=0;
			else
				c12:=c12+1;
			end if;
		end if;
	end process B660hz;

B594hz:process(clk)
	variable c11: integer range 0 to 83:= 0;
	begin
		if rising_edge(clk) then
			if c11=83 then
				beep11 <= not beep11;
				c11:=0;
			else
				c11:=c11+1;
			end if;
		end if;
	end process B594hz;

B528hz:process(clk)
	variable c10: integer range 0 to 94:= 0;
	begin
		if rising_edge(clk) then
			if c10=94 then
				beep10 <= not beep10;
				c10:=0;
			else
				c10:=c10+1;
			end if;
		end if;
	end process B528hz;

B495hz:process(clk)
	variable c9: integer range 0 to 100:= 0;
	begin
		if rising_edge(clk) then
			if c9=100 then
				beep9 <= not beep9;
				c9:=0;
			else
				c9:=c9+1;
			end if;
		end if;
	end process B495hz;

B440hz:process(clk)
	variable c8: integer range 0 to 113:= 0;
	begin
		if rising_edge(clk) then
			if c8=113 then
				beep8 <= not beep8;
				c8:=0;
			else
				c8:=c8+1;
			end if;
		end if;
	end process B440hz;

B396hz:process(clk)
	variable c7: integer range 0 to 125:= 0;
	begin
		if rising_edge(clk) then
			if c7=125 then
				beep7 <= not beep7;
				c7:=0;
			else
				c7:=c7+1;
			end if;
		end if;
	end process B396hz;

B352hz:process(clk)
	variable c6: integer range 0 to 141:= 0;
	begin
		if rising_edge(clk) then
			if c6=141 then
				beep6 <= not beep6;
				c6:=0;
			else
				c6:=c6+1;
			end if;
		end if;
	end process B352hz;

B330hz:process(clk)
	variable c5: integer range 0 to 154:= 0;
	begin
		if rising_edge(clk) then
			if c5=154 then
				beep5 <= not beep5;
				c5:=0;
			else
				c5:=c5+1;
			end if;
		end if;
	end process B330hz;

B297hz:process(clk)
	variable c4: integer range 0 to 167:= 0;
	begin
		if rising_edge(clk) then
			if c4=167 then
				beep4 <= not beep4;
				c4:=0;
			else
				c4:=c4+1;
			end if;
		end if;
	end process B297hz;

B264hz:process(clk)
	variable c3: integer range 0 to 188:= 0;
	begin
		if rising_edge(clk) then
			if c3=100 then
				beep3 <= not beep3;
				c3:=0;
			else
				c3:=c3+1;
			end if;
		end if;
	end process B264hz;

B247hz:process(clk)
	variable c2: integer range 0 to 201:= 0;
	begin
		if rising_edge(clk) then
			if c2=201 then
				beep2 <= not beep2;
				c2:=0;
			else
				c2:=c2+1;
			end if;
		end if;
	end process B247hz;

B220hz:process(clk)
	variable c1: integer range 0 to 226:= 0;
	begin
		if rising_edge(clk) then
			if c1=226 then
				beep1 <= not beep1;
				c1:=0;
			else
				c1:=c1+1;
			end if;
		end if;
	end process B220hz;

P1:process(clk_10ms)				--列扫描信号计数
	begin
		if clk_10ms'EVENT and clk_10ms='1' then
			if scancnt = 3 then		--模4
				scancnt <= 0;
			else
				scancnt <= scancnt+1;
			end if;
		end if;
	end process P1;

P2:process(scancnt)					--将计数结果转化为扫描信号
	begin
		case scancnt is
			when 0=>scancol<="0111";
			when 1=>scancol<="1011";
			when 2=>scancol<="1101";
			when 3=>scancol<="1110";
		end case;
	end process P2;
outcol<=scancol;		--输出值不能再次用来进行后续键值判断，所以用中间量传递信号，后续用中间量进行判断

P3:process(scancol,iptrow)		--首先判断当前扫描的列，然后比对行信号是否有被拉低电平的。
	begin												--如果有，则再根据列就能判断位置，从而决定键值，并告知后续模块有按键被按下
		if scancol="0111" then		--如果没有，则不改变键值，并告知后续模块没有按键被按下。
			case iptrow is
				when "0111"=>data<="0000";d<='1';
				when "1011"=>data<="0100";d<='1';
				when "1101"=>data<="1000";d<='1';
				when "1110"=>data<="1100";d<='1';
				when others=>d<='0';
			end case;
		elsif scancol="1011" then
			case iptrow is
				when "0111"=>data<="0001";d<='1';
				when "1011"=>data<="0101";d<='1';
				when "1101"=>data<="1001";d<='1';
				when "1110"=>data<="1101";d<='1';
				when others=>d<='0';
			end case;
		elsif scancol="1101" then
			case iptrow is
				when "0111"=>data<="0010";d<='1';
				when "1011"=>data<="0110";d<='1';
				when "1101"=>data<="1010";d<='1';
				when "1110"=>data<="1110";d<='1';
				when others=>d<='0';
			end case;
		elsif scancol="1110" then
			case iptrow is
				when "0111"=>data<="0011";d<='1';
				when "1011"=>data<="0111";d<='1';
				when "1101"=>data<="1011";d<='1';
				when "1110"=>data<="1111";d<='1';
				when others=>d<='0';
			end case;
		else
			null;
		end if;
	end process P3;

P4:process(d,data)					--输出数码管信号，当有按键被按下时根据键值输出
	begin											--没有按键被按下时，保持原状态不改变
		if d='0' then
			null;
		elsif d='1' then
			case data is
				when "0000"=>outsgn<="1111110";--0
				when "0001"=>outsgn<="0110000";--1
				when "0010"=>outsgn<="1101101";--2
				when "0011"=>outsgn<="1111001";--3
				when "0100"=>outsgn<="0110011";--4
				when "0101"=>outsgn<="1011011";--5
				when "0110"=>outsgn<="1011111";--6
				when "0111"=>outsgn<="1110000";--7
				when "1000"=>outsgn<="1111111";--8
				when "1001"=>outsgn<="1111011";--9
				when "1010"=>outsgn<="1110111";--A
				when "1011"=>outsgn<="0011111";--b
				when "1100"=>outsgn<="1001110";--C
				when "1101"=>outsgn<="0111101";--d
				when "1110"=>outsgn<="1001111";--E
				when "1111"=>outsgn<="1000111";--F
			end case;
		end if;
	end process P4;

P5:process(d,data)				--输出蜂鸣器序列，当有按键被按下时根据键值输出
	begin										--没有时不输出
		if d='0' then
			outbeep<='0';
		elsif d='1' then
			case data is
				when "0000"=>outbeep<=beep1;--0
				when "0001"=>outbeep<=beep2;--1
				when "0010"=>outbeep<=beep3;--2
				when "0011"=>outbeep<=beep4;--3
				when "0100"=>outbeep<=beep5;--4
				when "0101"=>outbeep<=beep6;--5
				when "0110"=>outbeep<=beep7;--6
				when "0111"=>outbeep<=beep8;--7
				when "1000"=>outbeep<=beep9;--8
				when "1001"=>outbeep<=beep10;--9
				when "1010"=>outbeep<=beep11;--A
				when "1011"=>outbeep<=beep12;--b
				when "1100"=>outbeep<=beep13;--C
				when "1101"=>outbeep<=beep14;--d
				when "1110"=>outbeep<=beep15;--E
				when "1111"=>outbeep<=beep16;--F
			end case;
		end if;
	end process P5;
end;
