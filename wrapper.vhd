-- wrapper

-- architectures:
-- RTL_test: example testing HPS inout register used as control signals
-- structure_driver_out_example_3: example using a driver output to generate variable width pulses
-- structure_driver_in_example_3: example using a driver input to read the width of an input pulse
-- structure_driver_example_3: example using both drivers in/out 

-- configuration:
-- use the configuration at the end of the file to select the architecture to implement.
-- Just change the architecture name.

library ieee;
use ieee.std_logic_1164.all;

entity wrapper is
	port (		
		CLK					: in std_logic;
		RST					: in std_logic;
		LED					: out std_logic_vector(7 downto 0);
		SW					: in std_logic_vector(3 downto 0);
		KEY					: in std_logic_vector(1 downto 0);
		from_GPIO_0_1_in	: in std_logic; -- peripheral input (RX)
		from_GPIO_0_0_inout	: in std_logic;	-- bidirectional peripheral input (S2C data)
		to_GPIO_0_0_inout	: out std_logic; -- bidirectional peripheral output (S2C data) 
		to_gpio_1_0_out		: out std_logic; -- peripheral output (TX)
		from_pio_reg_out	: in std_logic_vector(7 downto 0);
		from_pio_reg_inout	: in std_logic_vector(7 downto 0);
		to_pio_reg_in		: out std_logic_vector(7 downto 0);
		to_pio_reg_inout	: out std_logic_vector(7 downto 0) 
	);
end wrapper;



architecture I2C_driver of wrapper is
	
	component driver is
	port
	(
		-- Input ports
		CLK	: in  std_logic;
		RST	: in  std_logic;
		SDAin	: in  std_logic;

		-- Output ports
		SCL	: out  std_logic;
		SDAout	: out  std_logic;
		REGIN	: out std_logic_vector(7 downto 0);
		REGINOUT	: out std_logic_vector(7 downto 0)
	);
	end component;
			
begin	
	I_driver: driver 
		port map ( 					
			CLK							=> CLK,
			RST							=> RST,
			SDAin							=> from_GPIO_0_0_inout,	
			SDAout						=> to_GPIO_0_0_inout,	
			SCL							=> to_GPIO_1_0_out,
			REGIN							=> to_pio_reg_in,
			REGINOUT						=> to_pio_reg_inout
		);
end I2C_driver;



-- Configuration : use it to select the architecture to implement 

configuration cfg of wrapper is
	for I2C_driver -- HERE PUT YOUR ARCHITECTURE NAME 
	end for;
end cfg;
