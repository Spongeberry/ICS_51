#                                           ICS 51, Lab #1
# 
#                                          IMPORTATNT NOTES:
# 
#                       Write your assembly code only in the marked blocks.
# 
#                       DO NOT change anything outside the marked blocks.
# 
#

###############################################################
#                           Text Section
.text

###############################################################
###############################################################
###############################################################
#                            PART 1 (Swap Bits)
# 
# You are given an 32-bits integer stored in $a0. You need swap the bits
# at odd and even positions. i.e. b31 <-> b30, b29 <-> b28, ... , b1 <-> b0
# 
# Implementation details:
# The integer is stored in register $a0. You need to store the answer 
# into register $v0 in order to be returned by the function to the caller.
swap_bits:
############################## Part 1: your code begins here ###
li $t0, 0x55555555
and $t0, $a0, $t0
sll $t0, $t0, 1
li $t1, 0xaaaaaaaa
and $t1, $a0, $t1
srl $t1, $t1, 1
or $v0, $t1, $t0


############################## Part 1: your code ends here ###
jr $ra

###############################################################
###############################################################
###############################################################
#                           PART 2 (Triple Range)
# 
# You are given three integers. You need to find the smallest 
# one and the largest one and multiply their sum by three and return it.
# 
# Implementation details:
# The three integers are stored in registers $a0, $a1, and $a2. You 
# need to store the answer into register $v0 in order to be returned by 
# the function to the caller.
triple_range:
############################### Part 2: your code begins here ##


bgt $a0, $a1, skip1
move $t0, $a0
move $a0, $a1
move $a1, $t0
skip1:
bgt $a1, $a2, skip2
move $t0, $a1
move $a1, $a2
move $a2, $t0
skip2:
bgt $a0, $a1, skip3
move $t0, $a0
move $a0, $a1
move $a1, $t0
skip3:
    add $t0, $a0, $a2
    li $t1, 3
    mul $t0, $t0, $t1
    move $v0, $t0




############################### Part 2: your code ends here  ##
jr $ra

###############################################################
###############################################################
###############################################################
#                            PART 3 (Determinant)
# 
# You are given a 2x2 matrix and each element is a 16-bit 
# signed integer. Calculate its determinant.
# 
# Implementation details:
# The four 16-bit integers are stored in registers $a0, $a1. 
# You need to store the answer into register $v0 in order to 
# be returned by the function to the caller.
determinant:
############################## Part 3: your code begins here ###
addi $sp,$sp,-24
sw $s0,0($sp)
sw $s1,4($sp)
sw $s2,8($sp)
sw $s3,12($sp)
sw $s4,16($sp)
sw $s5,20($sp)


andi $s0,$a0,0x0000FFFF #loading a half word into $s0
sll $s0,$s0,16 #extending a sign bit
sra $s0,$s0,16 #retriving an original value
sra $a0,$a0,16 #shifting right $a0's value
andi $s1,$a0,0x0000FFFF #storing a upper half word into $s1
sll $s1,$s1,16 #extending a sign bit
sra $s1,$s1,16 #retriving an original value

andi $s2,$a1,0x0000FFFF #loading a half word into $s2
sll $s2,$s2,16 #extending a sign bit
sra $s2,$s2,16 #retriving an original value
sra $a1,$a1,16 #shifting right $a1's value
andi $s3,$a1,0x0000FFFF #storing a upper half word into $s3
sll $s3,$s3,16 #extending a sign bit
sra $s3,$s3,16 #retriving an original value


mul $s4,$s1,$s2 #multiplying $s1 and $s2
mul $s5,$s3,$s0 #multiplyning $s3 and $s0
subu $s5,$s4,$s5 #subtracting

addi $v0,$s5,0 #return value in $v0


# retriving a original word
lw $s0,0($sp)
lw $s1,4($sp)
lw $s2,8($sp)
lw $s3,12($sp)
lw $s4,16($sp)
lw $s5,20($sp)
addi $sp,$sp,24

############################## Part 3: your code ends here ###
jr $ra

