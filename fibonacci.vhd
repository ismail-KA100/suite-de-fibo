LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
ENTITY fibonacci IS
GENERIC(M : integer:= 16 );
  Port (
    INIT,clk,enable: in std_logic;
    N : in std_logic_vector( 7 downto 0);
    suit: out std_logic_vector(15 downto 0);
    OVERFLOW: out std_logic);
end fibonacci;

architecture fib_i of fibonacci IS
BEGIN
  
   PROCESS (clk)
   variable T_1: std_logic_vector(M-1 downto 0):="0000000000000000";
   variable T_2: std_logic_vector(M-1 downto 0):="0000000000000001";
   variable T_3: std_logic_vector(M-1 downto 0):="0000000000000000";
   variable T_t: std_logic_vector(M-1 downto 0):="0000000000000001";
   variable test : std_logic;
   variable cnt : std_logic_vector( 7 downto 0):="00000000";
     BEGIN
   
if (clk'event and clk='1' ) then
       if INIT ='1' then
       T_t:= "00000000000000001";
         --T_2:= "00000000000000001";
         --T_3:= "00000000000000000";
        --T_1:= "00000000000000000";
      

elsif enable='1' then
       if(cnt<N) then
          T_t := T_1 + T_2;
        T_2:=T_1;
       T_3:=T_2;
          T_1:=T_t;
          cnt:= cnt + "00000001";
       else 
        
           T_t:= "00000000000000000";
           T_1:= "00000000000000000";
           T_2:= "00000000000000001";
           T_3:= "00000000000000000";
           cnt:= "00000000";
          
                END IF;
          END IF;
    END IF;
       
        if (T_2<T_1 )then
          test:='0';
       else 
        test:='1';
end if;
             suit <= T_t;
             OVERFLOW <= test;
  end process;
             


 END fib_i;


---------------------------------test bench--------------------------------------------------------

         
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

ENTITY fib_tb is
 GENERIC(M: integer:=16);
end fib_tb;

architecture fib_tb1 OF fib_tb is

SIGNAL INITT : std_logic:='1';
SIGNAL clkT : std_logic:='0';
SIGNAL en:  std_logic:='0';
SIGNAL    NT :  std_logic_vector( 7 downto 0);
SIGNAL   suitT: std_logic_vector(M-1 downto 0);
SIGNAL   OVERFLOWT:  std_logic;
component fibonacci
  Port (
    INIT,clk,enable: in std_logic;
    N : in std_logic_vector( 7 downto 0);
    suit: out std_logic_vector(M-1 downto 0);
    OVERFLOW: out std_logic);
end component;
BEGIN
dut:entity work.fibonacci(fib_i) port map( INIT=>INITT,clk=>clkT,enable=>en,N=>NT,suit=>suitT,OVERFLOW=>OVERFLOWT);
  clkT <= not(clkT) after 1 ns;
  INITT<= '0','1' after 120 ns;
  en<= '1' after 2 ns;
  NT<= "00011101";
end;