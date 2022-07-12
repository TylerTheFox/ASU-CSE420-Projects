# Student Name:                             Brandan Tyler Lasley
# Student ID:                               1214587374 
# Class:			            CSE420
# Project:                                  1

.data
ask:  		.asciiz "Enter string: "
ret:  		.asciiz "The result string is "
buffer:   	.space 100

.text 
.globl main 
main:
    # Print
    la  $a0, ask  	# set address of string
    addi $v0, $0, 4	# set command to print string
    syscall		# call print
    
    # Input String
    li $v0, 8       	# take in input
    la $a0, buffer  	# load byte space into address
    li $a1, 100     	# allot the byte space for string
    syscall
    
    #3#3#3#3#3 Convert Case #3#3#3#3
    # Desceription:
    # Inverts character case of only A-Z, a-z
    # and saves it back to the buffer. 
    
    # This could be a standalone function invert(c)
    
    # Init
    xor $t0, $t0, $t0
    
    # $t0 stores the byte location of the string 
    # $t1 stores the current address of the string (ie a, b, c, etc)
    # $t2 stores the current byte from the address from $t1
    
    case:
    # Check
    # Jump to exit_case on null
    la $t1, buffer  	# load byte space into address
    add $t1, $t1, $t0 
    lb $t2, 0($t1)
    
    # If null, exit.
    beqz $t2, exit_case
    
    # These are all off by 1 because bge/ble is equal to
    # Thus the offsets have to be off by 1.
    
    # If less than A
    ble $t2, 64, continue_no_save
     
    # If greater than z
    bge $t2, 123, continue_no_save
    
    # If Upper
    ble  $t2, 96, upper
    
    # Fallthrough to lower
   
    lower:
    # 97 - 122
    # ToLower(c) = c - 32
    subi $t2, $t2, 32
    j continue
    
    upper:
    # 65 - 90
    # ToUpper(c) = c + 32
    
    # If greather than Z
    bge $t2, 91, continue_no_save
    
    addi $t2, $t2, 32
    j continue
    
    continue:
    sb	$t2, 0($t1)
    
    # We don't need to save the byte if we dont have to g++ -o3
    continue_no_save: 
    addi $t0, $t0, 1
    j case
    
    exit_case:

    #3#3#3#3#3#3#3#3#3#3#3#3#3#3#3#3
    
    # Print
    la  $a0, ret  	# set address of string
    addi $v0, $0, 4	# set command to print string
    syscall		# call print
    
    # Print
    la  $a0, buffer  	# set address of string
    addi $v0, $0, 4	# set command to print string
    syscall		# call print
    
    # Exit
    li $v0, 10
    syscall