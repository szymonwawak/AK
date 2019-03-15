	 ORG 800H  
	 LXI H,O1  
	 RST 3  
	 RST 5  
	 MOV B,D  
	 MOV C,E  
	 LXI H,PZ  
	 RST 3  
	 RST 2  
	 CPI 6EH  
	 JZ 81EH  
	 CPI 2DH  
	 JZ 82FH  
	 CPI 2BH  
	 JZ 864H  
	 JMP 80AH  
NEGACJA 	 MOV A,C  
	 CMA  
	 MOV C,A  
	 MOV A,B  
	 CMA  
	 MOV B,A  
	 LXI H,WYN  
	 RST 3  
	 MOV A,B  
	 RST 4  
	 MOV A,C  
	 RST 4  
	 JMP 800H  
ODEJMOWANIE 	 LXI H,O2  
	 RST 3  
	 RST 5  
	 STC  
	 CMC  
	 MOV A,C  
	 SUB E  
	 MOV E,A  
	 MOV A,B  
	 SBB D  
	 MOV D,A  
	 LXI H,WYN  
	 RST 3  
	 JC 84AH  
BEZ PRZENIESIENIA 	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 JMP 800H  
PRZENIESIENIE 	 MOV A,E  
	 CMA  
	 INR A  
	 MOV E,A  
	 MOV A,D  
ZU2MZ 	 JNZ 857H  
	 CMA  
	 INR A  
	 JMP 858H  
	 CMA  
	 MOV D,A  
	 LXI H,MIN  
	 RST 3  
	 MOV A,D  
	 RST 4  
	 MOV A,E  
	 RST 4  
	 JMP 800H  
	 LXI H,O2  
DODAWANIE 	 RST 3  
	 RST 5  
	 MOV L,C  
	 MOV H,B  
	 DAD D  
	 JC 87CH  
	 MOV C,L  
	 MOV B,H  
	 LXI H,WYN  
	 RST 3  
	 MOV A,B  
	 RST 4  
	 MOV A,C  
	 RST 4  
	 JMP 800H  
	 MOV C,L  
	 MOV B,H  
	 LXI H,WYN  
	 RST 3  
	 LXI H,D1  
	 RST 3  
	 MOV A,B  
	 RST 4  
	 MOV A,C  
	 RST 4  
	 JMP 800H  
WYN 	 DB 10,13,'Wynik:','@'                      
MIN 	 DB ' -','@'                     
D1 	 DB '1','@'                      
PZ 	 DB 10,13,'Podaj znak'10,13,'@'                     
O1 	 DB 10,13,'Podaj pierwszy operand: '10,13,'@'                 
O2 	 DB 10,13,'Podaj drugi operand: '10,13,'@'                 
