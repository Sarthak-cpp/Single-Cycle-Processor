LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
    USE IEEE.NUMERIC_STD.ALL;

-- Register Design
Entity RegisterFiles IS
	PORT(
    	rad1: IN STD_LOGIC_VECTOR(3 downto 0);
        rad2: IN STD_LOGIC_VECTOR(3 downto 0);
        wad: IN STD_LOGIC_VECTOR(3 downto 0);
        Clk: IN STD_LOGIC;
        RW: IN STD_LOGIC;
        wd: IN STD_LOGIC_VECTOR(31 downto 0);
        Rd1: OUT STD_LOGIC_VECTOR(31 downto 0);
        Rd2: OUT STD_LOGIC_VECTOR(31 downto 0)
        );
END ENTITY;

-- Register Architecture
ARCHITECTURE BEV OF RegisterFiles IS

TYPE MEM IS ARRAY (15 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MEMORY : MEM;
SIGNAL ADDR1 : INTEGER RANGE 0 TO 15;
SIGNAL ADDR2 : INTEGER RANGE 0 TO 15;
SIGNAL ADDR3 : INTEGER RANGE 0 TO 15;

Begin
	Process(Clk)
    Begin
    ADDR1<=CONV_INTEGER(rad1);
    ADDR2<=CONV_INTEGER(rad2);
    IF(RW = '1')THEN
    	IF(rising_edge(Clk))THEN
        	ADDR3<=CONV_INTEGER(wad);
            MEMORY(ADDR3)<=wd;
        End IF;
    End If;
    Rd1<=MEMORY(ADDR1);
    Rd2<=MEMORY(ADDR2);
  End Process;
End BEV;
    
    	

        