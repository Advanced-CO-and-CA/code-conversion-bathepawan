/******************************************************************************
* file: part2.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
### Part 2
Convert a given eight ASCII characters in the variable **STRING** to an 8-bit
binary number in the variable **NUMBER**. Clear the byte variable **ERROR** if all
the ASICC characters are either ASCII **“1”** or ASCII **“0”**; otherwise set **ERROR**
to all ones ***(0xFF)***.

For example:

|         |        | Test A       | Test B    |
|---------|--------|--------------|-----------|
| Input:  | STRING | 31('1')      | 31('1')   |
|         |        | 31('1')      | 31('1')   |
|         |        | 30('0')      | 30('0')   |
|         |        | 31('1')      | 31('1')   |
|         |        | 30('0')      | 30('0')   |
|         |        | 30('0')      | 37('7')   |
|         |        | 31('1')      | 31('1')   |
|         |        | 31('1')      | 31('1')   |
|         |        | 30('0')      | 30('0')   |
| Output: | NUMBER | D2(11010010) | 00        |
|         |        | 0(No Error)  | FF(Error) |

*/
  @BSS SECTION
	  .bss
		NUMBER: .word 0x0
		ERROR: .word 0x0

  @DATA SECTION
      .data
		STRING: .word 0x31
				.word 0x31
				.word 0x30        
				.word 0x31
				.word 0x30        
				.word 0x37        
				.word 0x31
				.word 0x30  
  @ TEXT section
      .text

.globl _main

_main:		EOR R0, R0, R0
			EOR R5, R5, R5 
			LDR R1, =STRING        @ Load string address in R1
			MOV R2, #8  			@ To keep track of string length
			
ITERATE:
			LDR R3, [R1], #4       
			CMP R3, #0x30      
			BLT FLAG_ERROR			    @ if less than 0x30 , flag error
			CMP R3, #0x31		   
			BGT FLAG_ERROR              @ If greater than 0x31, flag error
			AND R3, R3, #0x0F;      @ Extract digit
			MOV R0, R0, LSL #1;     
			ORR R0, R0, R3         @ Perform logical OR extracted bit
			SUBS R2, R2, #1;        
			BNE ITERATE				@ Continue if 0 is not reached
			B EXIT					


FLAG_ERROR:      MOV R5, #0xFF;          @ If error occurred, store 0xFF as Error
			EOR R0, R0, R0         @ Clear the value of number


EXIT:								@Store Error and Number 
			LDR R4, =NUMBER        
			STR R0, [R4]		    
			LDR R4, =ERROR         
			STR R5, [R4]			
			SWI 0x11
    		.end
