#!/bin/bash

# Prompt user for phone number to spam
read -p "Enter phone number to spam: " phone_number

# Prompt user for message to send
read -p "Enter message to send: " message

#Prompt user for number of messages to send
read -p "Enter number of messages to send: " number_of_messages

# Loop to send message multiple times
for i in $(seq 1 $number_of_messages)
do
  osascript -e "tell application \"Messages\" to send \"$message\" to buddy \"$phone_number\" of (service 1 whose service type is iMessage)"
  echo "Message sent: $i"
done
