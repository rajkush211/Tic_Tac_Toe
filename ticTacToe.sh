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

declare -A Board

function resetBoard() {
	for (( i=0; i<3; i++ ))
	do
		echo "---------------"
		for (( j=0; j<3; j++ ))
		do
			echo -n "|   |"
		done
		echo
	done
	echo "---------------"
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
	count=0
	for (( i=0; i<3; i++ ))
	do
		echo "---------------"
		for (( j=0; j<3; j++ ))
		do
			echo -n "| $(( count++ )) |"
		done
		echo
	done
	echo "---------------"
}

echo "You are assigned letter:- $USER_LETTER"
tossForTurn
displayBoard

sleep 1
