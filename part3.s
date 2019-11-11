/******************************************************************************
* file: part3.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*
#### Part 3
Convert a given eight-digit packed binary-coded-decimal number in the
**BCDNUM** variable into a 32-bit number in a **NUMBER** variable.

For example:

|         |           |             |
|:-------:|:---------:|:-----------:|
|  Input: |   BCDNUM  |   92529679  |
|  Output:|   NUMBER  |   0x0583E40F|

*/
  @BSS SECTION
	  .bss
		NUMBER: .word 0x0

  @DATA SECTION
      .data
		BCDNUM: .ascii "92529679"

  @ TEXT section
      .text

.globl _main

_main:
	LDR R0,=BCDNUM 					@ load the address of BCDNUM 
	MOV R1, #0x0 					@ use as counter 
	MOV R2, #0x0 					@ to hold temp result
	LDR R3, =0xA					@ initialize with 10 to shift temp result by one position
LOOP:
	LDRB R4, [R0], #1 			
	AND R4, R4, #0x0F 			     @ Extract digit 
	MOV R5, R2
	MLA R2, R5, R3, R4				 @ shift and add current element
	ADD R1, R1, #1 				     
	CMP R1, #8					 	@ check end of string 
	BNE LOOP					 
	B EXIT

EXIT:
	LDR R6,=NUMBER 
	STR R2, [R6] 				
	SWI 0x11					
	.end

