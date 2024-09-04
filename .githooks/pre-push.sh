#!/bin/bash

# Pre-push script to gather PR information and prompt the developer to fill out key details

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to prompt and get input for each section
function prompt_and_get_input() {
    echo "$1"
    read -r input
    echo "$input"
}

# Start writing the pre-push PR template
echo "Creating PR template..."

PR_TEMPLATE="# What?\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Describe what changes are made in this PR and the outcome of these changes:')\n\n"

PR_TEMPLATE+="## Why?\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Explain why these changes are necessary:')\n\n"

PR_TEMPLATE+="## How?\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Describe how the outcome is achieved (steps followed):')\n\n"

PR_TEMPLATE+="## Tests\n### Manual Test\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Have you done manual tests? What was validated?')\n\n"

PR_TEMPLATE+="### Automated Test\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Have you done automated tests? What are the test cases?')\n\n"

PR_TEMPLATE+="## Ticket\n\n"
PR_TEMPLATE+="$(prompt_and_get_input 'Is there a ticket related to this change? (Provide ticket number or URL):')\n"

# Save the PR template to a file (optional) or just print it
PR_TEMPLATE_FILE="pr_template.txt"
echo -e "$PR_TEMPLATE" > "$PR_TEMPLATE_FILE"

# Optionally, show the template
echo -e "\nGenerated PR Template:"
echo -e "$PR_TEMPLATE"

# Confirmation before pushing
echo -e "\nDo you want to continue with the push? (yes/no)"
read -r confirmation

if [[ "$confirmation" == "yes" ]]; then
    echo "Pushing changes..."
    # Execute git push
    git push
else
    echo "Push aborted."
    exit 1
fi
