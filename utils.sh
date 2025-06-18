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

# Interactive menu function that allows selection using arrow keys
# Usage: select_from_menu "Title" "item1" "item2" "item3"
# Sets the global variable MENU_SELECTED_ITEM with the selected option
select_from_menu() {
    # Setup terminal for interactive selection
    emulate -L zsh
    zmodload zsh/zselect
    zmodload zsh/zutil
    
    local title="$1"
    shift
    local -a items
    items=($@)  # Use zsh array assignment
    local selected=0
    local item_count=${#items}
    MENU_SELECTED_ITEM=""
    
    # Enable special keys for reading
    stty -echo
    # Needed for key press capture
    bindkey -e
    
    # Save cursor position and hide it
    tput sc
    tput civis
    
    # Print initial display
    echo "$title"
    
    # Main menu loop
    while true; do
        # Reset cursor and clear below
        tput rc
        tput ed
        
        # Show title
        echo "$title"
        
        # Display menu items
        local i=0
        while [[ $i -lt $item_count ]]; do
            if [[ $i -eq $selected ]]; then
                print -P "%S> ${items[$i+1]}%s"  # Use print with zsh highlighting
            else
                echo "  ${items[$i+1]}"
            fi
            ((i++))
        done
        
        # Read a keypress
        local key
        read -k key
        
        # Handle up/down/enter
        case "$key" in
            $'\x1b') # ESC key - handle potential arrow keys
                read -k key
                if [[ "$key" == "[" ]]; then
                    read -k key
                    case "$key" in
                        A) # Up arrow
                            if [[ $selected -gt 0 ]]; then
                                ((selected--))
                            fi
                            ;;
                        B) # Down arrow
                            if [[ $selected -lt $((item_count-1)) ]]; then
                                ((selected++))
                            fi
                            ;;
                    esac
                fi
                ;;
            $'\n'|$'\r') # Enter key
                MENU_SELECTED_ITEM="${items[$selected+1]}"
                break
                ;;
            q|Q) # Quit
                MENU_SELECTED_ITEM=""
                break
                ;;
        esac
    done
    
    # Restore terminal state
    stty echo
    tput cnorm
    echo ""
}

source_local() {
    # If it exists, source local aliases from local.sh
    # Duplicate aliases will default to the version in local.sh 
    LOCAL_PATH="$SCRIPT_DIR/local.sh"
    if [ -f "$LOCAL_PATH" ]; then
        source "$LOCAL_PATH"
    fi
}