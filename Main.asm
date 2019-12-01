;**********************************************************************************
; File Name: Main.asm
; Version: 1.0
; Description: Finding the average, min and max of an array of elements
; Author: Jordan Gilpin
; Target: Simulator
; Assembler: AVR-AS
; Last Modified: September 4, 2019
;**********************************************************************************
.cseg
ldi r30, low(A)			   ;Stack creation
ldi r31, high(A)
add r30, r30
adc r31, r31
ldi r27, low(ramend)
out spl, r27
ldi r27, high(ramend)
out sph, r27

ldi r24, 0					;counter
ldi r23, 0					;counter
ldi r25, 5					;limit


average:					;computes number to be divided 
	lpm r16, z+				;loads first number in the array to register r16
	add r17, r16			;take the sum of r16 & r17
	inc r24					;increment the counter
	push r16
	cp r24, r25				;compare the counter with the limit
	brne average			;branch to next statement if condition holds


;The function below uses subtraction and an incrementing register to represent division
divide:			
	sub r17, r24			;subtracts number of elements from sum of array
	inc r18					;shows the value of the quotient incrementing as it is being calculated
	cp r17, r1
	brne divide	

Max:					;needs to go through 1 more time in order to grab the last element
	 pop r5
	 cp r23, r25
	 inc r23
	 brsh exit			;used to skip the next few lines of code				
	 cp r5, r29
	 brlo minstore
	 brsh maxstore
	

minstore: 
	mov r28, r5			;Stores minimun array value in r28
	jmp Max

maxstore:
	mov r29, r5			;Stores maximum array value in r29
	jmp Max
	
exit:
	rjmp exit 

A:
	.db 1,2,3,4,5			;array	

.dseg
b:
	.byte 2 

