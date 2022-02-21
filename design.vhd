library IEEE;
use IEEE.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity SingleCycleProcessor is
	PORT(
    	Clk,Reset: IN STD_LOGIC
        );
end entity;

architecture BEV of SingleCycleProcessor is

component PC is
	PORT(
    	curr: IN STD_LOGIC_VECTOR(31 downto 0);
        Clk: IN STD_LOGIC;
        Predicate: IN STD_LOGIC;
        Offset: IN STD_LOGIC_VECTOR(23 downto 0)
        );
end component;

component ProgramMemory is
	PORT(
    	ad: IN STD_LOGIC_VECTOR(5 downto 0);
        ins: OUT STD_LOGIC_VECTOR(31 downto 0)
        );
End component;

component ALU is
	PORT(
    	op1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        op2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        result: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        carryin: IN STD_LOGIC;
        carryout: OUT STD_LOGIC;
    	op: IN STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
end component;

component RegisterFiles is
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
END component;


component ConditionChecker is
	PORT(
    	Z: IN STD_LOGIC;
        Cond: IN STD_LOGIC_VECTOR(1 downto 0);
        Predicate: OUT STD_LOGIC
        );
END component;

component Flags is
	PORT(
    	carryout: IN STD_LOGIC;
        result: IN STD_LOGIC_VECTOR(31 downto 0);
        op1: IN STD_LOGIC_VECTOR(31 downto 0);
        op2: IN STD_LOGIC_VECTOR(31 downto 0);
        S: IN STD_LOGIC;
        Z,N,V,C: OUT STD_LOGIC
 		);
end component;

component DataMemory is
	PORT(
    	add: IN STD_LOGIC_VECTOR(5 downto 0);
        wdd: IN STD_LOGIC_VECTOR(31 downto 0);
        Clk: IN STD_LOGIC;
        rd: OUT STD_LOGIC_VECTOR(31 downto 0);
        MW: IN STD_LOGIC_VECTOR(3 downto 0)
        );
End component;

Signal curr,ins,op1,op2,result,wd,Rd1,Rd2,wdd,rd: STD_LOGIC_VECTOR(31 downto 0);
Signal MW,rad1,rad2,wad,op: STD_LOGIC_VECTOR(3 downto 0);
Signal ad,add: STD_LOGIC_VECTOR(5 downto 0);
Signal S,Z,N,V,C,carryout,Predicate,carryin,RW: STD_LOGIC;
Signal Offset: STD_LOGIC_VECTOR(23 downto 0);
Signal Cond: STD_LOGIC_VECTOR(1 downto 0);
signal F: std_logic_vector (1 downto 0);
signal Ubit, Lbit : std_logic;
signal Imm : std_logic_vector (7 downto 0);

begin
comp1: PC port map(curr,Clk,Predicate,Offset);
comp2: Flags port map(carryout,result,op1,op2,S,Z,N,V,C);
comp3: DataMemory port map(add,wdd,Clk,rd,MW);
comp4: ProgramMemory port map(ad,ins);
comp5: RegisterFiles port map(rad1,rad2,wad,Clk,RW,wd,Rd1,Rd2);
comp6: ALU port map(op1,op2,result,carryin,carryout,op);
comp7: ConditionChecker port map(Z,Cond,Predicate);


F <= ins(27 downto 26);
Cond <= ins(29 downto 28);
Ubit <= ins(23);
Lbit <= ins(20);
op<=ins(24 downto 21);
Imm <= ins(7 downto 0);
Offset <= ins(23 downto 0);

process(Clk,reset)
begin
	If(reset = '1')THEN
    	curr<="00000000000000000000000000000000";
    Elsif(rising_edge(Clk))THEN
    	ad<=curr(7 downto 2);
        F <= ins(27 downto 26);
		Cond <= ins(29 downto 28);
		Ubit <= ins(23);
		Lbit <= ins(20);
		op<=ins(24 downto 21);
		Imm <= ins(7 downto 0);
		Offset <= ins(23 downto 0);
        rad1<=ins(19 downto 16);
        IF(F = "00")THEN
        rad2<=ins(3 downto 0);
        ELSE rad2<=ins(15 downto 12);
        end if;
        wad<= ins(15 downto 12);
        IF(ins(25) = '0')THEN
        	op2<=Rd2;
        Else op2(31 downto 12) <= "00000000000000000000";
        	 op2(11 downto 0) <= ins(11 downto 0);
        end if;
        op1<=Rd1;
        add<=result(7 downto 2);
        wdd<=Rd2;
        If(F = "00")THEN
        	wd<=result;
        Else wd<=rd;
    	end if;
	End if;
    end process;
end BEV;