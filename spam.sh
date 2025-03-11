#!/bin/bash

# Use AppleScript to fetch contacts and let the user select one
selected_contact=$(osascript <<EOF
tell application "Contacts"
    set contactNames to name of people
    set selectedName to choose from list contactNames with prompt "Select a contact to message:" without multiple selections allowed
    if selectedName is false then return "CANCELLED"
    return selectedName
end tell
EOF
)

# Exit if user cancels selection
if [ "$selected_contact" == "CANCELLED" ]; then
    echo "Operation cancelled."
    exit 1
fi

# Use AppleScript to fetch the phone number of the selected contact
phone_number=$(osascript <<EOF
tell application "Contacts"
    set matchedContacts to people whose name is "$selected_contact"
    if (count of matchedContacts) > 0 then
        set firstContact to item 1 of matchedContacts
        set phoneNumbers to value of phones of firstContact
        if (count of phoneNumbers) > 0 then
            return item 1 of phoneNumbers
        else
            return "NO_PHONE"
        end if
    else
        return "NO_MATCH"
    end if
end tell
EOF
)

# Handle cases where no phone number is found
if [ "$phone_number" == "NO_PHONE" ]; then
    echo "No phone number found for $selected_contact."
    exit 1
elif [ "$phone_number" == "NO_MATCH" ]; then
    echo "Error finding the selected contact."
    exit 1
fi

# Prompt user for the message to send
read -p "Enter message to send: " message

# Prompt user for the number of messages to send
read -p "Enter number of messages to send: " number_of_messages

# Loop to send message multiple times
for i in $(seq 1 $number_of_messages)
do
  osascript -e "tell application \"Messages\" to send \"$message\" to buddy \"$phone_number\" of (service 1 whose service type is iMessage)"
  echo "Message sent to $selected_contact ($phone_number): $i"
done
