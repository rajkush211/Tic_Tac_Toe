#!/bin/bash -x

#Problem Statement: As a Tic Tac Toe player would like to challenge computer.
#Author: Raj Kush
#DAte: 24 March 2020

clear

#CONSTANTS
USER_LETTER=X
COMP_LETTER=O
USER_TURN=0
COMP_TURN=1
TRUE=1
FALSE=0

#VARIABLES
isWon=0
vacantCells=9

declare -A Board

function resetBoard() {
	local count=0
	for (( i=0; i<3; i++ ))
	do
		echo "---------------------"
		for (( j=0; j<3; j++ ))
		do
			Board[$i,$j]=$(( count++ ))
			echo -n "|  ${Board[$i,$j]}  |"
		done
		echo
	done
	echo "---------------------"
}

function tossForTurn() {
	toss=$(( RANDOM % 2 ))
	case $toss in
		$USER_TURN)
			echo "You won the toss, your turn first";;
		$COMP_TURN)
			echo "You loss the toss, computer turn first";;
	esac
}

function displayBoard() {
	for (( i=0; i<3; i++ ))
	do
		echo "---------------------"
		for (( j=0; j<3; j++ ))
		do
			echo -n "|  ${Board[$i,$j]}   |"
		done
		echo
	done
	echo "---------------------"
}

function areThreeCellsEqual() {
	cell1=$1
	cell2=$2
	cell3=$3
	if [ ! -z "$cell1" ]  #CHECKING IF CELL IS NON-EMPTY
	then
		if [[ $cell1 == $cell2 && $cell2 == $cell3 ]]
		then
			isWon=$TRUE
			if [ $cell1 == $USER_LETTER ]
			then
				winner=$USER_LETTER
			else
				winner=$COMP_LETTER
			fi
		fi
	fi
}

function checkWinning() {
	isWon=$FALSE
#CHECKING EACH ROW AND COLUMN AT EACH ITERATION IF WON
	for (( i=0; i<3; i++ ))
	do
		areThreeCellsEqual ${Board[$i,0]} ${Board[$i,1]} ${Board[$i,2]} #FOR ROW
		areThreeCellsEqual ${Board[0,$i]} ${Board[1,$i]} ${Board[2,$i]} #FOR COLUMN
	done
#CHECKING BOTH DIAGONAL
	areThreeCellsEqual ${Board[0,0]} ${Board[1,1]} ${Board[2,2]} #FOR 1 DIAGONAL
	areThreeCellsEqual ${Board[0,2]} ${Board[1,1]} ${Board[2,0]} #FOR 2 DIAGONAL
	if [ $isWon -eq $TRUE ]
	then
		if [ $winner == $USER_LETTER ]
		then
			echo "Congratulations, You won! well played."
		elif [ $winner == $COMP_LETTER ]
		then
			echo "Computer won!, Better luck next time"
		fi
	else
		if [[ $vacantCells -eq 0 ]] #TIE CONDITION IF THERE IS NO VACANT CELLS
		then
			echo "Game Tie"
		else
			turn=$(( 1 - turn ))
		fi
	fi
}

echo "You are assigned letter:- $USER_LETTER"
tossForTurn
displayBoard
resetBoard
checkWinning

echo "Computer is playing smart like you, So be focused"

sleep 1
