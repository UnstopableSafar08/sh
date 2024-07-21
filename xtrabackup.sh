#!/bin/bash

# Function to display a menu
show_menu() {
    echo "1. Greet"
    echo "2. Sum"
    echo "3. Exit"
}

# Function to greet the user
greet() {
    read -p "Enter your name: " name
    echo "Hello, $name!"
}

# Function to sum two numbers
sum() {
    read -p "Enter first number: " num1
    read -p "Enter second number: " num2
    echo "The sum is $((num1 + num2))"
}

# Main script logic
while true; do
    show_menu
    read -p "Choose an option: " choice
    case $choice in
        1) greet ;;
        2) sum ;;
        3) exit 0 ;;
        *) echo "Invalid option, please try again." ;;
    esac
done
