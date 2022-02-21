-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

--ALU entity
entity ALU IS
	PORT(
    	op1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        op2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        carryin: IN STD_LOGIC;
        carryout: OUT STD_LOGIC;
    	op: IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
END entity;

--ALU Architecture
Architecture BEV of ALU IS

Signal Hui: STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal Hue: STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal Hao: STD_LOGIC_VECTOR(31 DOWNTO 0);
Signal cin: STD_LOGIC;
Signal cout: STD_LOGIC;
Signal Temp: STD_LOGIC_VECTOR(32 DOWNTO 0);
Signal Temp1: STD_LOGIC_VECTOR(32 DOWNTO 0);
Signal Temp2: STD_LOGIC_VECTOR(32 DOWNTO 0);

begin 
Hui<=op1;
Hue<=op2;
cin<=carryin;
Temp1(32)<='0';
Temp2(32)<='0';
Temp1(31 downto 0)<=Hui;
Temp2(31 downto 0)<=Hue;

PROCESS(op1,op2,carryin,op)
Begin

	IF(op="0000")THEN
      Hao <= Hui and Hue; --AND operation
    ELSIF(op="0001")THEN
      Hao <= Hui xor Hue; --EOR operation
    ELSIF(op="0010")THEN
      Hao <= Hui + (not Hue) + 1; --Sub operation
    ELSIF(op="0011")THEN
      Hao <= (not Hui) + Hue + 1; --Rsub operation
    ELSIF(op="0100")THEN
      Hao <= Hui + Hue; --Add operation
    ELSIF(op="0101")THEN
      Temp <= Temp1 + Temp2 + cin; --Addc operation
      Hao <= Temp (31 downto 0);
      cout <= Temp(32);
    ELSIF(op="0110")THEN
      Temp <= Temp1 + (not Temp2) + cin; --Sbc operation
      Hao <= Temp(31 downto 0);
      cout <= Temp(32);
    ElSIF(op="0111")THEN
      Temp <= (not Temp1) + Temp2 + cin; --RSc operation
      Hao <= Temp(31 downto 0);
      cout <= Temp(32);
    ELSIF(op="1000")THEN
      Hao <= Hui and Hue; --tst operation
    ELSIF(op="1001")THEN
      Hao <= Hui xor Hue; --eor operation
    ELSIF(op="1010")THEN
      Hao <= Hui + (not Hue) + 1; --cmp operation
    ELSIF(op="1011")THEN
      Hao <= Hui + Hue; --cmn operation
    ELSIF(op="1100")THEN
      Hao <= Hui or Hue; --orr operation
    ELSIF(op = "1101")THEN
      Hao <= Hue; --mov operation
    ELSIF(op = "1110")THEN
      Hao <= Hui and (not Hue); --bic operation
    ELSE
      Hao <= not Hue; -- mvn operation
    END IF;
    END PROCESS;
result<=Hao;
carryout<=cout;
    
END BEV;