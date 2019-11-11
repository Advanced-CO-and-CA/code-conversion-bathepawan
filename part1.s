/******************************************************************************
* file: part1.s
* Author: Pawan Bathe (CS18M519)
* TA: G S Nitesh Narayana
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

/*

Convert the contents of a given **A_DIGIT** variable from an ASCII character to
a hexadecimal digit and store the result in **H_DIGIT**. Assume that **A_DIGIT**
contains the ASCII representation of a hexadecimal digit (i.e., 7 bits with
MSB=0).

For example:

|         |           |             |
|:-------:|:---------:|:-----------:|
|  Input: |   A_DIGIT |      43     |
|  Output:|   H_DIGIT |      OC     |

*/
  @BSS SECTION
  .bss
  		H_DIGIT: .word 0
  @ DATA SECTION
      .data
		A_DIGIT: .word 0x31	

  @ TEXT section
      .text

.globl _main

_main:



LDR R1, =A_DIGIT
LDR R2, [R1]

CMP R2, #0x41    @ if digit go to NUMBER and add 0x30 
BLT NUMBER
SUB R2, R2, #0x41   @ handle character 
ADD R2, R2, #0xA
B EXIT

NUMBER:
		SUB R2, R2, #0x30
		B EXIT

EXIT:
	LDR R3, =H_DIGIT
	STR R2,[R3]  @ Store the result  
	SWI 0x11
    .end




