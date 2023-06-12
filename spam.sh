#!/bin/bash

# Prompt user for phone number to spam
read -p "Enter phone number to spam: " phone_number

# Prompt user for message to send
read -p "Enter message to send: " message

# Loop to send message multiple times
for i in {1..10}
do
  osascript -e "tell application \"Messages\" to send \"$message\" to buddy \"$phone_number\""
done