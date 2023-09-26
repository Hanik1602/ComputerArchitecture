.data
welcome: .asciiz "                                            WELCOME TO GAME FOUR IN ROW!\n"
buffer1: .space 20
buffer2: .space 20
newLine: .asciiz "\n"
nameOfplayer1: .asciiz "Player1, please enter your name(not exceed 20 chars): "
nameOfplayer2: .asciiz "Player2, please enter your name(not exceed 20 chars: "
board: .asciiz "******************************************"
rule: .asciiz "Here is the rule of the game\n"
rule1: .asciiz "In the first move, you must drop the piece in the center column of the board\n"
rule2: .asciiz "After first move, you have 3 times to undo the move(before your opponent's turn)\n"
rule3: .asciiz "You can block the next opponent's move 1 time. But you can not use it when your opponent have opportunity to win.\n"
rule4: .asciiz "If you want to remove one arbitrary piece of the opponent, press R(1 time)\n"
rule5: .asciiz "If you place a piece at an inappropriate column, it will be count as a violation\n"
rule6: .asciiz "If you violate over 3 times, you will lose the game\n"
remainingViolation: .asciiz "The number of remaining violation: "
remainingUndo: .asciiz "The number of remaining undo: "
understand: .asciiz "If you have already understood the rule of the game, press any key to continue"
play: .asciiz "Now, let's play the game\n"
largeSpace: .asciiz "                                               "
count: .asciiz "  0 1 2 3 4 5 6 \n"
longFence: .asciiz " _______________\n"
fence: .asciiz "|"
space: .asciiz " "
turnOfplayer1:.asciiz "It's your turn, please enter your instruction: "
turnOfplayer2: .asciiz "It's your turn, please enter your instruction: "
char: .byte '*'
X: .byte 'X'
O: .byte 'O'
charPlayer1: .byte ' '
charPlayer2: .byte ' '
charOfPlayer1: .asciiz "The player 1: "
charOfPlayer2: .asciiz "The player 2: "
numberOfPiece: .asciiz "Number of piece: "
pieceChar: .asciiz "Piece char " 
ERROR: .asciiz "You can't place a piece at this position. Please enter the instruction again \n"
ERRORKEY: .asciiz "The instruction is inappropriate. Please enter the instruction again \n"
ERRORREMOVE: .asciiz "The piece you want to remove is not the piece of your opponent.\nPlease enter the instruction again"
Undo: .asciiz "Do you want to undo the last instruction(press Y if you want): "
Remove: .asciiz "\nThe position of piece you want to remove is: "
removeRow: .asciiz "\nThe row of piece you want to remove(0->5) is: "
removeColumn: .asciiz "The column of piece you want to remove(0->6) is: "
Block: .asciiz "Do you want to block the next opponent's move(press B if you want): "
CannotBlock: .asciiz "You can't block the next opponent's move because the oppenent have opportunity to win\n"
Winner: .asciiz "You are the winner"
Tie: .asciiz "Tie game"
InDiagonal1: .word 14, 7, 0, 1, 2, 3
OutDiagonal1: .word 38, 39, 40, 41, 34, 27
InDiagonal2: .word 3, 4, 5, 6, 13, 20
OutDiagonal2: .word  21, 28, 35, 36, 37, 38
listUndo: .word 3,3
listBlock: .word 1,1
listRemove: .word 1,1
listViolation: .word 3,3
firstMove: .word 1,1
notRemove: .asciiz "\nYou run out of remove time \n"
notUndo: .asciiz "You run out of undo time \n"
notBlock: .asciiz "You run out of block time \n"
loseGame: .asciiz "You lose the game \n"
firstinstruction: .asciiz "\nYou must drop the piece in the center of column in the first move\n"
congratulation: .asciiz "\nCongratulation! Winner "
.text
main:
	la $s0, board
	li $s3, 3 
	li $s4, 1
	li $s5, 0
	li $s6, 1
	
	li $v0, 4
	la $a0, welcome
	syscall
	
ruleOftheGame:
	li $v0, 4
	la $a0, rule
	syscall
	
	li $v0, 4
	la $a0, rule1
	syscall
	
	li $v0, 4
	la $a0, rule2
	syscall
	
	li $v0, 4
	la $a0, rule3
	syscall
	
	li $v0, 4
	la $a0, rule4
	syscall
	
	li $v0, 4
	la $a0, rule5
	syscall

	li $v0, 4
	la $a0, rule6
	syscall	
	
	li $v0, 4
	la $a0, understand
	syscall	
	
	li $v0, 8
	syscall
	
	li $v0, 4
	la $a0, play
	syscall	
	
saveNameofPlayer:
	li $v0, 4
	la $a0, nameOfplayer1
	syscall
	
	li $v0, 8
	la $a0, buffer1
	li $a1, 20
	syscall
	move $s1, $a0
	
	li $v0, 4
	la $a0, nameOfplayer2
	syscall
	
	li $v0, 8
	la $a0, buffer2
	li $a1, 20
	syscall
	move $s2, $a0

	li $v0, 42
	li $a1, 2
	syscall
	beq $a0, 1, OX 
XO:
	la $t0, X
	lb $t1, ($t0)
	sb $t1, charPlayer1
	li $v0, 4
	la $a0, charOfPlayer1
	syscall
	li $v0, 11 
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall 

	la $t0, O
	lb $t1, ($t0)
	sb $t1, charPlayer2
	li $v0, 4
	la $a0, charOfPlayer2
	syscall
	li $v0, 11 
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall 
	
	j firstInstruction1
OX:
	la $t0, O
	lb $t1, ($t0)
	sb $t1, charPlayer1
	li $v0, 4
	la $a0, charOfPlayer1
	syscall
	li $v0, 11 
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall 
	
	la $t0, X
	lb $t1, ($t0)
	sb $t1, charPlayer2
	li $v0, 4
	la $a0, charOfPlayer2
	syscall
	li $v0, 11 
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall 
firstInstruction1:
	jal printtheboard
	li $v0, 4
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, turnOfplayer1
	syscall	
	
	li $v0, 12
	syscall 
	move $t0, $v0
	
	bne $t0, '3', errorFirstinstruction1
	la $t1, charPlayer1
	lb $t2, ($t1)
	sb $t2, 38($s0)
	li $s6, 2
	j firstInstruction2
errorFirstinstruction1:
	li $v0, 4
	la $a0, firstinstruction
	syscall
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	addi $t5, $t5, -1
	sw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	j firstInstruction1
firstInstruction2:
	jal printtheboard
	li $v0, 4
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, turnOfplayer2
	syscall	
	
	li $v0, 12
	syscall 
	move $t0, $v0
	
	bne $t0, '3', errorFirstinstruction2
	la $t1, charPlayer2
	lb $t2, ($t1)
	sb $t2, 31($s0)
	li $s6,1
	j LOOP
errorFirstinstruction2:
	li $v0, 4
	la $a0, firstinstruction
	syscall
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	addi $t5, $t5, -1
	sw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	j firstInstruction2
LOOP:
	add $v0, $zero, $zero
	jal printtheboard

	jal takeInput
	beq $v0, 1, continueChange
	beq $v0, 2, LOOP
	
	li $v0, 4
	la $a0, newLine
	syscall	
	
	add $v0, $zero, $zero
	jal checkVictory
	beq $v0, 1, ENDWIN
	
	add $v0, $zero, $zero
	jal checkTie
	beq $v0, 1, ENDTIE
	
	jal printtheboard
	
	add $v0, $zero, $zero
	jal undo
	beq $v0, 1, LOOP
	
	add $v1, $zero, $zero
	jal block
	beq $v1, 1, LOOP
continueChange:
	jal changeTurn
	j LOOP
#LOOP 
printtheboard:
	li $v0, 4
	la $a0, remainingViolation
	syscall

	addi $t0, $s6, -1
	sll $t0, $t0,2
	la $t1, listViolation
	add $t1, $t1, $t0 
	
	li $v0, 1
	lw $a0, ($t1) 
	syscall

	li $v0, 4
	la $a0, newLine
	syscall		
	
	li $v0, 4
	la $a0, remainingUndo
	syscall	
	
	addi $t0, $s6, -1
	sll $t0, $t0,2
	la $t1, listUndo
	add $t1, $t1, $t0
	
	li $v0, 1
	lw $a0, ($t1)
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall	
printBoardforTie:
	li $t1, 7 
	li $t2, 7
	add $t3, $zero, $zero #int i 
	
	li $v0, 4
	la $a0, largeSpace
	syscall
	li $v0, 4
	la $a0, longFence
	syscall
outterLoop:
	beq $t3, 6, next
	add $t4, $zero, $zero #int j 
	li $v0, 4
	la $a0, largeSpace
	syscall
	li $v0, 4
	la $a0, fence
	syscall	
innerLoop:
	beq $t4, 7, outterLoop
	li $v0, 4
	la $a0, space
	syscall	
	mul $t5, $t1, $t3 #7*i
	add $t5, $t5, $t4
	add $t5, $t5, $s0
	lb $a0, ($t5)
	li $v0, 11
	syscall
	addi $t4, $t4, 1
	bne $t4, $t2, innerLoop
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 4
	la $a0, fence
	syscall
	li $v0, 4
	la $a0, newLine
	syscall	
	addi $t3, $t3, 1
	j outterLoop
	jr $ra
next:
	li $v0, 4
	la $a0, largeSpace
	syscall
	li $v0, 4
	la $a0, count
	syscall
	jr $ra
	

takeInput:
player1:
	bne $s6, 1, player2
	li $v0, 4
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, turnOfplayer1
	syscall	
	
	li $v0, 12
	syscall 
	move $t0, $v0
	
	j r
player2:
	li $v0, 4
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, turnOfplayer2
	syscall	
	
	li $v0, 12
	syscall 
	move $t0, $v0
r:	
	beq $t0, '0', regis0
	beq $t0, '1', regis1
	beq $t0, '2', regis2
	beq $t0, '3', regis3
	beq $t0, '4', regis4
	beq $t0, '5', regis5
	beq $t0, '6', regis6
	beq $t0, 'R', remove
	beq $s3, 0, LOSEGAME
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	li $v0, 4
	la $a0, ERRORKEY
	syscall
	li $v0, 2
	jr $ra
regis0: 
	li $t5, 0
	j regis
regis1:
	li $t5, 1
	j regis
regis2: 
	li $t5, 2
	j regis
regis3:
	li $t5, 3
	j regis
regis4:
	li $t5, 4
	j regis
regis5:
	li $t5, 5
	j regis
regis6:
	li $t5, 6
	j regis
regis:
	li $t2, 7
	li $t3, 5
loopReplace0:
	beq $t3, -1, violation0
	mul $t4, $t3, $t2
	add $t4, $t4, $t5
	add $t1, $t4, $s0
	lb $t9, ($t1)
	la $t7, char
	lb $t8, ($t7)
	beq $t9, $t8, replace0
	addi $t3, $t3, -1
	j loopReplace0
replace0:
	move $s5, $t4
	beq $s6, 1,X0 
	la $t7, charPlayer2
	j O0	
X0:  
	la $t7, charPlayer1
O0:
	lb $t8, ($t7)
	sb $t8, ($t1)
	jr $ra
violation0:
	#s3 == 0, you lose the game
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	#beq $s3, 0, LOSEGAME
	li $v0, 4
	la $a0, ERROR
	syscall
	#addi $s3, $s3, -1
	li $v0, 2
	jr $ra
remove:
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listRemove
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, cannotRemove
	addi $t5, $t5, -1
	sw $t5, ($t4)

loopRemovefirst:
	li $v0, 4
	la $a0, removeRow
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	li $v0, 4 
	la $a0, removeColumn 
	syscall
	li $v0, 5
	syscall	
	move $t2, $v0
	beq $s6, 2, removeforPlayer2 
	li $t3, 7
	mul $t4, $t1, $t3
	add $t4, $t4, $t2
	add $t5, $t4, $s0
	lb $t6, ($t5)
	la $t7, charPlayer2
	lb $t8, ($t7)
	beq $t6, $t8, RemovePieceabove
	
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	li $v0, 4
	la $a0, ERRORREMOVE
	syscall
	j loopRemovefirst
removeforPlayer2:
	li $t3, 7
	mul $t4, $t1, $t3
	add $t4, $t4, $t2
	add $t5, $t4, $s0
	lb $t6, ($t5)
	la $t7, charPlayer1
	lb $t8, ($t7)
	beq $t6, $t8, RemovePieceabove
	
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	li $v0, 4
	la $a0, ERRORREMOVE
	syscall
	j loopRemovefirst
	#li $v0, 4
	#la $a0, Remove
	#syscall
	
	#li $v0, 5
	#syscall
RemovePieceabove:
	add $t0, $zero, $t4
	add $t1, $t0, $s0
loopRemove:
	slti $t4, $t0, 7
	beq $t4, 1, outRemove
	addi $t2, $t1, -7
	lb $t3, ($t2)
	beq $t3, '*', outRemove
	sb $t3, ($t1)
	addi $t1, $t1, -7
	addi $t0, $t0, -7
	j loopRemove
outRemove:
	la $t7, char
	lb $t8, ($t7)
	sb $t8, ($t1)
	addi $v0, $zero, 1
	jr $ra
cannotRemove:
	li $v0, 4
	la $a0, notRemove 
	syscall
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	addi $t5, $t5, -1
	sw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $v0, $zero, 2
	jr $ra
changeTurn:
	beq $s6, 2, changeToturnPlayer1
	li $s6, 2
	jr $ra
changeToturnPlayer1:
	li $s6, 1
	jr $ra
undo:
	li $v0, 4
	la $a0, Undo
	syscall
	li $v0, 12
	syscall 
	move $t0, $v0
	li $v0, 4
	la $a0, newLine
	syscall
	bne $t0, 'Y', return
	
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listUndo
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, errorUndo
	addi $t5, $t5, -1
	sw $t5, ($t4)
	
	add $t1, $s5, $s0
	la $t7, char
	lb $t8, ($t7)
	sb $t8, ($t1)
	addi $v0, $zero, 1
	jr $ra
errorUndo:
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	li $v0, 4
	la $a0, notUndo
	syscall
	jr $ra
return: 
	jr $ra
checkVictory:
checkRow:
	add $t0, $zero, $zero 
	li $t1, 7
	addi $t2, $zero, -1 #i
	add $t3, $zero, $zero #previous
	add $t4, $zero, $zero #count
loopOut0:
	addi $t0, $t0, 1
	beq $t2, 41, checkColumn
	addi $t2, $t2, 1
	add $t3, $t2, $zero
	add $t4, $zero, $zero
	mul $t5, $t0, $t1
	addi $t5, $t5, -1
loopInt0:
	add $t6, $s0, $t2
	lb $t7, ($t6)
	beq $t7, '*', checkFalserow
	add $t8, $s0, $t3
	lb $t9, ($t8)
	beq $t7, $t9, checkTruerow
	addi $t4, $zero, 1
continueRow:
	j check0
continueCheck0:
	beq $t2, $t5, loopOut0
	addi $t2, $t2, 1
	addi $t3, $t2, -1
	j loopInt0
checkFalserow:
	add $t4, $zero, $zero
	j continueRow
checkTruerow:
	addi $t4, $t4, 1
	j continueRow
check0:
	bne $t4, 4, continueCheck0
	addi $v0, $zero, 1
	jr $ra
checkColumn:
	add $t0, $zero, $zero 
	addi $t1,$zero, -1
	addi $t2, $zero, -1 #i
	add $t3, $zero, $zero #previous
	add $t4, $zero, $zero #count
loopOut1:
	addi $t0, $t0, 1
	beq $t2, 41, checkDiagonal
	addi $t1, $t1, 1
	add $t2, $zero, $t1
	add $t3, $t2, $zero
	add $t4, $zero, $zero
	addi $t5, $t0, 34
loopInt1:
	add $t6, $s0, $t2
	lb $t7, ($t6)
	beq $t7, '*', checkFalsecolumn
	add $t8, $s0, $t3
	lb $t9, ($t8)
	beq $t7, $t9, checkTruecolumn
	addi $t4, $zero, 1
continueColumn:
	j check1
continueCheck1:
	beq $t2, $t5, loopOut1
	add $t3, $t2, $zero
	addi $t2, $t2, 7
	j loopInt1
checkFalsecolumn:
	add $t4, $zero, $zero
	j continueColumn
checkTruecolumn:
	addi $t4, $t4, 1
	j continueColumn
check1:
	bne $t4, 4, continueCheck1
	addi $v0, $zero, 1
	jr $ra
checkDiagonal:
	addi $t0, $zero, -1
	addi $t2, $zero, -1 #i
	add $t3, $zero, $zero #previous
	add $t4, $zero, $zero #count
loopOutdiagonal1:
	addi $t0, $t0, 1
	beq $t0, 6, checkDiagonal2
	sll $t6, $t0, 2
	
	la $t7, InDiagonal1
	add $t7, $t7, $t6
	lw $t1, ($t7)
	
	la $t7, OutDiagonal1
	add $t7, $t7, $t6
	lw $t5, ($t7)
	
	add $t2, $zero, $t1
	add $t3, $t2, $zero
	add $t4, $zero, $zero
loopIndiagonal1:
	add $t6, $s0, $t2
	lb $t7, ($t6)
	beq $t7, '*', checkFalsediagonal1 
	add $t8, $s0, $t3
	lb $t9, ($t8)
	beq $t7, $t9, checkTruediagonal1
	addi $t4, $zero, 1
continueDiagonal1:
	j check2
continueCheckDiagonal1:
	beq $t2, $t5, loopOutdiagonal1
	add $t3, $t2, $zero
	addi $t2, $t2, 8
	j loopIndiagonal1
checkFalsediagonal1:
	add $t4, $zero, $zero
	j continueDiagonal1
checkTruediagonal1:
	addi $t4, $t4, 1
	j continueDiagonal1
check2:
	bne $t4, 4, continueCheckDiagonal1
	addi $v0, $zero, 1
	jr $ra
checkDiagonal2:
	addi $t0, $zero, -1
	addi $t2, $zero, -1 #i
	add $t3, $zero, $zero #previous
	add $t4, $zero, $zero #count
loopOutdiagonal2:
	addi $t0, $t0, 1
	beq $t0, 6, return
	sll $t6, $t0, 2
	
	la $t7, InDiagonal2
	add $t7, $t7, $t6
	lw $t1, ($t7)
	
	la $t7, OutDiagonal2
	add $t7, $t7, $t6
	lw $t5, ($t7)
	
	add $t2, $zero, $t1
	add $t3, $t2, $zero
	add $t4, $zero, $zero
loopIndiagonal2:
	add $t6, $s0, $t2
	lb $t7, ($t6)
	beq $t7, '*', checkFalsediagonal2
	add $t8, $s0, $t3
	lb $t9, ($t8)
	beq $t7, $t9, checkTruediagonal2
	addi $t4, $zero, 1
continueDiagonal2:
	j check3
continueCheckDiagonal2:
	beq $t2, $t5, loopOutdiagonal2
	add $t3, $t2, $zero
	addi $t2, $t2, 6
	j loopIndiagonal2
checkFalsediagonal2:
	add $t4, $zero, $zero
	j continueDiagonal2
checkTruediagonal2:
	addi $t4, $t4, 1
	j continueDiagonal2
check3:
	bne $t4, 4, continueCheckDiagonal2
	addi $v0, $zero, 1
	jr $ra
errorBlock:
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listViolation
	add $t4, $t4, $t3
	lw $t5, ($t4)
	beq $t5, 0, LOSEGAME
	addi $t5, $t5, -1
	sw $t5, ($t4)
	li $v0, 4
	la $a0, notBlock
	syscall
	jr $ra
block:
	addi $t3, $s6, -1
	sll $t3, $t3, 2
	la $t4, listBlock
	add $t4, $t4, $t3
	lw $t5, ($t4)

	li $v0, 4
	la $a0, Block
	syscall
	li $v0, 12
	syscall 
	move $t0, $v0
	li $v0, 4
	la $a0, newLine
	syscall
	bne $t0, 'B', return
	beq $t5, 0, errorBlock
	addi $t5, $t5, -1
	sw $t5, ($t4)
	beq $s6, 1, assignO
	lb $s7, charPlayer1
	j checkBlock
assignO:
	lb $s7, charPlayer2
checkBlock:
	addi $s5, $zero,-1
	addi $sp, $sp, -4
	sw $ra, 0($sp) 
loopBlock:
	addi $t1, $s5, 1
	add $s5, $t1, $zero
	add $t2, $t1, $s0
	lb $t3, ($t2)
	beq $t3, '*', checkIf
	beq $s5, 41, returnBlock
	j loopBlock
continueCheckblock:
	add $t1, $s5, $zero
	add $t2, $t1, $s0
	lb $t3, char
	sb $t3, ($t2)
	beq $s5, 41, returnBlock
	j loopBlock
checkIf:
	sb $s7, ($t2)
	add $v0, $zero, $zero
	jal checkVictory
	bne $v0, 1, continueCheckblock
	add $t1, $s5, $zero
	add $t2, $t1, $s0
	lb $t3, char
	sb $t3, ($t2)
	li $v0, 4
	la $a0, CannotBlock
	syscall
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra 
returnBlock:
	addi $v1, $zero, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
checkTie:
	addi $t0, $zero, -1
loopTie:
	add $t0, $t0, 1
	add $t1, $t0, $s0
	lb $t2, ($t1)
	beq $t2, '*', return
	beq $t0, 6, returnTie
	j loopTie
returnTie:
	addi $v0, $zero, 1
	jr $ra
checkNumberofPiece:
	addi $t0, $zero, -1
	add $t4, $zero, $zero
	beq $s6, 2, pieceO
	lb $t1, charPlayer1
	j loopPiece
pieceO:
	lb $t1, charPlayer2
loopPiece:
	addi $t0, $t0, 1
	beq $t0, 42, return
	add $t2, $s0, $t0 
	lb $t3, ($t2)
	beq $t1, $t3, addnumPiece
	j loopPiece
addnumPiece:
	addi $t4, $t4, 1
	j loopPiece
ENDWIN:
	bne $s6, 1 player2winGame
	jal checkNumberofPiece
	li $v0, 4
	la $a0, congratulation
	syscall
	li $v0, 4
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, numberOfPiece
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, pieceChar
	syscall
	li $v0, 11
	lb $a0, charPlayer1
	syscall

	j END
player2winGame:
	jal checkNumberofPiece
	li $v0, 4
	la $a0, congratulation
	syscall
	li $v0, 4
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, numberOfPiece
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, pieceChar
	syscall
	li $v0, 11
	lb $a0, charPlayer2
	syscall
	j END
ENDTIE:
	jal printBoardforTie
	j END
LOSEGAME:
	bne $s6, 1, player2loseGame
	jal checkNumberofPiece
	li $v0, 4
	la $a0, congratulation
	syscall
	li $v0, 4
	la $a0, ($s2)
	syscall
	
	li $v0, 4
	la $a0, numberOfPiece
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, pieceChar
	syscall
	li $v0, 11
	lb $a0, charPlayer2
	syscall
	j END
player2loseGame:
	jal checkNumberofPiece
	li $v0, 4
	la $a0, congratulation
	syscall
	li $v0, 4
	la $a0, ($s1)
	syscall
	
	li $v0, 4
	la $a0, numberOfPiece
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	li $v0, 4
	la $a0, pieceChar
	syscall
	li $v0, 11
	lb $a0, charPlayer1
	syscall
END:	
		
	
	
	
