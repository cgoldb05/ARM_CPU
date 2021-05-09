library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity controlTest is 
end controlTest;

architecture synth of controlTest is

component mainDecoder is
port(
	func : in std_logic_vector(5 downto 0);
    op : in std_logic_vector(1 downto 0);
    Rd : in std_logic_vector(3 downto 0);
    memtoReg : out std_logic;
    memW : out std_logic;
    regW : out std_logic;
    ALUSrc : out std_logic;
    immSrc : out std_logic_vector(1 downto 0);
    PCSrc : out std_logic
);
end component;

signal func : std_logic_vector(5 downto 0);
signal op : std_logic_vector(1 downto 0);
signal memtoReg : std_logic;
signal memW : std_logic;
signal regW : std_logic;
signal ALUSrc : std_logic;
signal immSrc : std_logic_vector(1 downto 0);
signal PCSrc : std_logic;
signal Rd : std_logic_vector(3 downto 0);

begin
    	mD : mainDecoder port map(func => func, op => op, Rd => Rd, memtoReg => memtoReg, memW => memW, regW => regW, ALUSrc => ALUSrc, immSrc => immSrc, PCSrc => PCSrc);

	process is
	begin
		--testing mainDecoder 
		func <= "011110";
		op <= "00";
		wait for 10 ns;
		if (memtoReg = '0' and memW = '0' and ALUSrc = '0' and regW = '1' and immSrc = "00")then 
			report "success";
		else
			report "failed";
			report "memtoReg: " & to_string(memtoReg);
			report "memW: " & to_string(memW);
			report "ALUSrc: " & to_string(ALUSrc);
			report "regW: " & to_string(regW);
			report "immSrc: " & to_string(immSrc);
		end if;
		
		func <= "111110";
		op <= "00";
		wait for 10 ns;
		if (memtoReg = '0' and memW = '0' and ALUSrc = '1' and immSrc = "00" and regW = '1')then 
			report "success";
		else
			report "failed";
			report "memtoReg: " & to_string(memtoReg);
			report "memW: " & to_string(memW);
			report "ALUSrc: " & to_string(ALUSrc);
			report "immSrc: " & to_string(immSrc);
			report "regW: " & to_string(regW);
		end if;
		
		
		op <= "01";
		wait for 10 ns;
		if (memW = '1' and ALUSrc = '1' and immSrc = "01" and regW = '0')then 
			report "success";
		else
			report "failed";
			report "memW: " & to_string(memW);
			report "ALUSrc: " & to_string(ALUSrc);
			report "immSrc: " & to_string(immSrc);
			report "regW: " & to_string(regW);
		end if;
		
		func <= "111111";
		op <= "01";
		wait for 10 ns;
		if (memtoReg = '1' and memW = '0' and ALUSrc = '1' and immSrc = "01" and regW = '1')then 
			report "success";
		else
			report "failed";
			report "memtoReg: " & to_string(memtoReg);
			report "memW: " & to_string(memW);
			report "ALUSrc: " & to_string(ALUSrc);
			report "immSrc: " & to_string(immSrc);
			report "regW: " & to_string(regW);
		end if;
		
		
		op <= "10";
		wait for 10 ns;
		if (memtoReg = '0' and memW = '0' and ALUSrc = '1' and immSrc = "10" and regW = '0')then 
			report "success";
		else
			report "failed";
			report "memW: " & to_string(memW);
			report "ALUSrc: " & to_string(ALUSrc);
			report "immSrc: " & to_string(immSrc);
			report "regW: " & to_string(regW);
			report "memtoReg: " & to_string(memtoReg);
		end if;	
		
		
		--testing pc updates
		Rd <= "1010";
		wait for 10 ns;
		if (PCSrc = '0') then 
			report "success PC";
		else
			report "failed";
			report "PCSrc: " & to_string(PCSrc);
		end if;
		
		Rd <= "1011";
		wait for 10 ns;
		if (PCSrc = '0') then 
			report "success PC";
		else
			report "failed";
			report "PCSrc: " & to_string(PCSrc);
		end if;
		
		Rd <= "1110";
		wait for 10 ns;
		if (PCSrc = '1') then 
			report "success PC";
		else
			report "failed";
			report "PCSrc: " & to_string(PCSrc);
		end if;
		
		
		Rd <= "0000";
		wait for 10 ns;
		if (PCSrc = '0') then 
			report "success PC";
		else
			report "failed";
			report "PCSrc: " & to_string(PCSrc);
		end if;
		wait;
	end process;
end synth;