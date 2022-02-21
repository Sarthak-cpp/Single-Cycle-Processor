LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
    USE IEEE.NUMERIC_STD.ALL;

--Data Memory Design
Entity DataMemory IS
	Port(
    	add: IN STD_LOGIC_VECTOR(5 downto 0);
        wdd: IN STD_LOGIC_VECTOR(31 downto 0);
        Clk: IN STD_LOGIC;
        rd: OUT STD_LOGIC_VECTOR(31 downto 0);
        MW: IN STD_LOGIC_VECTOR(3 downto 0)
        );
End Entity;

--DataMemory Architecture
Architecture BEV of DataMemory IS

TYPE MEM IS ARRAY (63 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEMORY : MEM;
SIGNAL ADDR1 : INTEGER RANGE 0 TO 63;

Begin
	Process(Clk)
    Begin
    ADDR1<=CONV_INTEGER(add);
    rd<=MEMORY(ADDR1);
    IF(rising_edge(Clk))Then
    	IF(MW="0001")THEN
        	MEMORY(ADDR1)(7 downto 0)<=wdd(7 downto 0);
        ELSIF(MW="0010")THEN
        	MEMORY(ADDR1)(15 downto 8)<=wdd(15 downto 8);
        ELSIF(MW="0100")THEN
        	MEMORY(ADDR1)(23 downto 16)<=wdd(23 downto 16);
        ELSIF(MW="1000")THEN
        	MEMORY(ADDR1)(31 downto 24)<=wdd(31 downto 24);
        ELSIF(MW="0011")THEN
        	MEMORY(ADDR1)(15 downto 0)<=wdd(15 downto 0);
        ELSIF(MW="0110")THEN
        	MEMORY(ADDR1)(23 downto 8)<=wdd(23 downto 8);
        ELSIF(MW="1100")THEN
        	MEMORY(ADDR1)(31 downto 16)<=wdd(31 downto 16);
        ELSIF(MW="0111")THEN
        	MEMORY(ADDR1)(23 downto 0)<=wdd(23 downto 0);
        ELSIF(MW="1110")THEN
        	MEMORY(ADDR1)(31 downto 8)<=wdd(31 downto 8);
        ELSIF(MW="1111")THEN
        	MEMORY(ADDR1)<=wdd;
        ELSIF(MW="0101")THEN
        	MEMORY(ADDR1)(23 downto 16)<=wdd(23 downto 16);
            MEMORY(ADDR1)(7 downto 0)<=wdd(7 downto 0);
        ELSIF(MW="1001")THEN
        	MEMORY(ADDR1)(31 downto 24)<=wdd(31 downto 24);
            MEMORY(ADDR1)(7 downto 0)<=wdd(7 downto 0);
        ELSIF(MW="1010")THEN
        	MEMORY(ADDR1)(31 downto 24)<=wdd(31 downto 24);
            MEMORY(ADDR1)(15 downto 8)<=wdd(15 downto 8);
        ELSIF(MW="1011")THEN
        	MEMORY(ADDR1)(31 downto 24)<=wdd(31 downto 24);
            MEMORY(ADDR1)(15 downto 0)<=wdd(15 downto 0);
        ELSIF(MW="1101")THEN
        	MEMORY(ADDR1)(31 downto 16)<=wdd(31 downto 16);
            MEMORY(ADDR1)(7 downto 0)<=wdd(7 downto 0);
        END IF;
     End If;
  End Process;
END BEV;