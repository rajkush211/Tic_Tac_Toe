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
	for (( i=0; i<3; i++ ))
	do
		echo "---------------------"
		for (( j=0; j<3; j++ ))
		do
			Board[$i,$j]=" "
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
			echo "You won the toss, your turn first"
			whoseTurn=$USER_TURN;;
		$COMP_TURN)
			echo "You loss the toss, computer turn first"
			whoseTurn=$COMP_TURN;;
	esac
}

function displayBoard() {
	for (( i=0; i<3; i++ ))
	do
		echo "---------------------"
		for (( j=0; j<3; j++ ))
		do
			echo -n "|  ${Board[$i,$j]}  |"
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

function checkIfAnyoneWon() {
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
		fi
	fi
}

function checkCanCompWin() {
	letter=$1
	placeAtRow=""
	placeAtColumn=""
	for (( i=0; i<3; i++ ))
	do
#CHECKING WINNING IN ROWS
		if [[ ${Board[$i,0]} == $letter && ${Board[$i,1]} == $letter && ${Board[$i,2]} == " " ]]
		then
			placeAtRow=$i
			placeAtColumn=2
			break
		elif [[ ${Board[$i,0]} == $letter && ${Board[$i,2]} == $letter && ${Board[$i,1]} == " " ]]
		then
			placeAtRow=$i
			placeAtColumn=1
			break
		elif [[ ${Board[$i,1]} == $letter && ${Board[$i,2]} == $letter && ${Board[$i,0]} == " " ]]
		then
			placeAtRow=$i
			placeAtColumn=0
			break
#CHECKING WINNING IN COLUMNS
		elif [[ ${Board[0,$i]} == $letter && ${Board[1,$i]} == $letter && ${Board[2,$i]} == " " ]]
		then
			placeAtRow=2
			placeAtColumn=$i
			break
		elif [[ ${Board[0,$i]} == $letter && ${Board[2,$i]} == $letter && ${Board[1,$i]} == " " ]]
		then
			placeAtRow=1
			placeAtColumn=$i
			break
		elif [[ ${Board[1,$i]} == $letter && ${Board[2,$i]} == $letter && ${Board[0,$i]} == " " ]]
		then
			placeAtRow=0
			placeAtColumn=$i
			break
		fi
	done

#CHECKING WINNING IN BOTH DIAGONALS
	if [[ $placeAtRow == ""  && $placeAtColumn == "" ]]
	then
		if [[ ${Board[0,0]} == $letter && ${Board[1,1]} == $letter && ${Board[2,2]} == " " ]]
		then
			placeAtRow=2
			placeAtColumn=2
		elif [[ ${Board[0,0]} == $letter && ${Board[2,2]} == $letter && ${Board[1,1]} == " " ]]
		then
			placeAtRow=1
			placeAtColumn=1
		elif [[ ${Board[1,1]} == $letter && ${Board[2,2]} == $letter && ${Board[0,0]} == " " ]]
		then
			placeAtRow=0
			placeAtColumn=0
		elif [[ ${Board[0,2]} == $letter && ${Board[1,1]} == $letter && ${Board[2,0]} == " " ]]
		then
			placeAtRow=2
			placeAtColumn=0
		elif [[ ${Board[0,2]} == $letter && ${Board[2,0]} == $letter && ${Board[1,1]} == " " ]]
		then
			placeAtRow=1
			placeAtColumn=1
		elif [[ ${Board[1,1]} == $letter && ${Board[2,0]} == $letter && ${Board[0,2]} == " " ]]
		then
			placeAtRow=0
			placeAtColumn=2
		fi
	fi
}

function playTicTacToe() {
	echo "You are assigned letter:- $USER_LETTER"
	tossForTurn
	resetBoard
	displayBoard
	checkIfAnyoneWon
	if [[ $isWon -eq $FALSE && $vacantCells -ne 0 ]]
	then
		if [ $whoseTurn -eq $USER_TURN ]
		then
			while true
			do
				read -p "Your turn to play enter row(0-2) and column(0-2): " row column
				if [[ ${Board[$row,$column]} == " " ]]
				then
					Board[$row,$column]=$USER_LETTER
					(( vacantCells-- ))
					break
				fi
			done
		else
			echo "Computer's Turn"
			checkCanCompWin $COMP_LETTER
			if [[ $placeAtRow != "" && $placeAtColumn != "" ]]
			then
				Board[$placeAtRow,$placeAtColumn]=$COMP_LETTER
			fi
			(( vacantCells-- ))
			whoseTurn=$(( 1 - whoseTurn ))
		fi
	fi
}

playTicTacToe

sleep 1
