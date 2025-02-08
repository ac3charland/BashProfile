unalias_if_exists() {
    for alias_name in "$@"; do
        if [[ -n $(alias "$alias_name" 2>/dev/null) ]]; then
            unalias "$alias_name"
        fi
    done
}

copy_to_clipboard() {
    local content="$1"
    
    # Mac
    if command -v pbcopy &>/dev/null; then
        echo "$content" | pbcopy
    # Linux
    elif command -v xclip &>/dev/null; then
        echo "$content" | xclip -selection clipboard
    # No dice
    else
        echo "\nUnable to copy to clipboard. Please install pbcopy (macOS) or xclip (Linux)."
    fi
}

extract_ticket_from_branch() {
    # Check if we are in a Git repository
    if [ -d .git ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        ticket=$(echo "$branch" | grep -o '[0-9]\+')

        echo "${ticket}"
    else
        # If not, print an error message
        echo "Not in a Git repository."
    fi
}

create_pr_description() {
    ticket=$(extract_ticket_from_branch)
    echo "Creating PR description for ticket $ticket\n\n========\n"

    summary_array=()

    echo "Enter summary bullets one by one. Type 'done' or hit Enter on an empty line to continue."

    while true; do
        # Display the prompt
        read "input?> "

        if [[ -z "$input" || "$input" == "done" ]]; then
            break
        fi

        summary_array+=("$input")
    done

    # Define TICKET_URL in local.sh with the following format:
    # TICKET_URL="www.test.com/{TICKET}?params"
    url="${TICKET_URL//\{TICKET\}/$ticket}"

    markdown_content="## Features\n"
    for bullet in "${summary_array[@]}"; do
        markdown_content+="- $bullet\n"
    done

    markdown_content+="\n## Ticket\n"
    markdown_content+="Resolves AB#$ticket\n\n"

    markdown_content+="## Screenshots\n\n"

    copy_to_clipboard "$markdown_content"

    echo "Generated PR summary for ticket $ticket and copied to clipboard"
}
