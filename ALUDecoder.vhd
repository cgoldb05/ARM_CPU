library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ALUDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    ALUOp : in std_logic;
    ALUControl : out std_logic_vector(3 downto 0);
    FlagW : out std_logic_vector(1 downto 0)
);
end ALUDecoder;


architecture synth of ALUDecoder is
signal S : std_logic;
signal cmd : std_logic_vector(3 downto 0);
begin
	cmd <= func (4 downto 1);
	S <= func(0);
	
	ALUControl <= cmd when (ALUOp = '1') else "0000";
	FlagW <= "00" when (ALUOp = '0' or S = '0') else                      
    		 "11" when (S = '1' and (cmd = "0011" or (cmd = "0100" or cmd = "0010"))) else  -- ADD, SUB, and RSB
           	 "10" when (S = '1' and (cmd = "1101" or (cmd = "0000" or cmd = "1100"))); -- AND, OR, and MOV
end synth;
