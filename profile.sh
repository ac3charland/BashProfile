#Setup
DEFAULT_IDE="windsurf"  # Overwrite this in local.sh (e.g., "code", "windsurf", etc.)
SCRIPT_DIR="$(dirname "$0")"
UTILS_PATH="$SCRIPT_DIR/utils.sh"
RECORDINGS_DIR="$HOME/Desktop/recordings"
PROJECTS_ROOT="$HOME/code/projects"
export FABRIC_PATTERNS_PATH="$HOME/.config/fabric/patterns"
FABRIC_CUSTOM_PATTERNS_PATH="$PROJECTS_ROOT/fabric-custom-patterns"
source "$UTILS_PATH"
source_local

#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/docs'
alias downloads='cd ~/Downloads'
alias cdcode='cd ~/code'
alias projects="cd $PROJECTS_ROOT"
alias proj='projects'

#Project Shortcuts
create_project_shortcut "bp" "$SCRIPT_DIR" "open"
alias editBashProfile="bp"
alias ebp='editBashProfile'
alias cdBashProfile="bp -N"
alias cdbp='cdBashProfile'
alias ezsh="$DEFAULT_IDE $HOME/.zshrc"
alias zshrc='ezsh'
alias template="cd $PROJECTS_ROOT/react-template/"
alias mac-setup="cd $PROJECTS_ROOT/mac-setup-script/"

#Git Shortcuts
PREV_BRANCH='main'
unalias_if_exists uwm gcam gcamp gc gcb gcbn gm gbd gd gco gcl
alias nogit='xcode-select --install'
alias status='git status'
alias st='status'
alias pull='git pull'
alias push='git push'
alias gb='git branch'
alias gcm='gco main || gco master'
alias gcd='git checkout development'
alias gmm='git merge main || git merge master'
alias glo='git log --oneline'
alias gld='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'
alias gs='git stash'
alias gsp='git stash pop'
alias amend='git add . && git commit --amend --no-edit'
alias resolveConflicts='gcam "Merge main into branch & resolve conflicts"'
alias rc='resolveConflicts'

function updateWithMain {
    local CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    gcm
    git pull
    git checkout "$CURRENT_BRANCH"
    gmm
}
alias uwm='updateWithMain'
function gcnm { git commit -m "$1"; }
function gcam { git add . && git commit -am "$1"; }
function gcamp { 
    git add .
    git commit -m "$1"
    push
}
function gc { git checkout "$1"; }
function gcb { gcm && git pull && git checkout -b "$1"; }
function gcbn { git checkout -b "$1"; }
alias gcbc='gcbn'
function gm { git merge "$1"; }
function gbd { git branch -D "$1"; }
function gd { git diff "$1"~ "$1"; }
function gco {
    PREV_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git checkout "$1"
}
function gcl { 
    TMP=$(git rev-parse --abbrev-ref HEAD)
    git checkout "$PREV_BRANCH"
    PREV_BRANCH=$TMP 
}
function gbg { git branch | grep "$1"; }
alias gcs='gbg'
function gbgc { git branch | grep "$1" | pbcopy; }
alias gcgc='gbgc'
function gcog {
    local matches=$(git branch | grep "$1")
    local match_count=$(echo "$matches" | grep -v "^$" | wc -l | tr -d ' ')
    
    if [ "$match_count" -eq 0 ]; then
        echo "No branches match pattern '$1'"
    elif [ "$match_count" -eq 1 ]; then
        local branch=$(echo "$matches" | tr -d ' *')
        gco "$branch"
    else
        # Convert matches to a clean array for zsh
        local -a branches
        while IFS= read -r line; do
            # Skip empty lines
            [[ -z "$line" ]] && continue
            # Trim leading/trailing spaces and asterisk
            line=$(echo "$line" | sed 's/^[* ]*//' | xargs)
            # Add to array if non-empty
            [[ -n "$line" ]] && branches+=($line)
        done <<< "$matches"
        
        # Use the select_from_menu function from utils.sh
        select_from_menu "Multiple branches match pattern '$1'.\n\nSelect one:" ${branches[@]}
        
        # Checkout the selected branch (MENU_SELECTED_ITEM is set by select_from_menu)
        if [[ -n "$MENU_SELECTED_ITEM" ]]; then
            echo "Checking out: $MENU_SELECTED_ITEM"
            gco "$MENU_SELECTED_ITEM"
        else
            echo "No branch selected."
        fi
    fi
}

record () {
  local file="${1:-$(date +%Y-%m-%d_%H-%M-%S).wav}"
  local dir="${2:-$RECORDINGS_DIR}"

  mkdir -p "${dir}"
  echo "Recording to ${dir}/${file}..."
  ffmpeg -f avfoundation -i ":1" "${dir}/${file}"
}

#AWS Shortcuts
alias ap='amplify push'
alias as='amplify status'

#General Shortcuts
alias ws='windsurf'
alias ll='ls -la'
alias ns='npm start'
alias ni='npm i'
alias nsd='npm run dev'
alias us='npm run update-schema'
alias sd='npm run develop'   # Strapi run command
# alias go='npm test'
alias go-bs='npm run test:ci'
alias refreshBashProfile="source $SCRIPT_DIR/profile.sh"
alias rbp='refreshBashProfile'
alias catBashProfile="cat $SCRIPT_DIR/profile.sh"
alias catbp='catBashProfile'
alias tuts='open ~/code/notes-and-tutorials'
alias bs-t='npm run backstop:test'
alias bs-r='npm run backstop:report'
alias bs-a='npm run backstop:approve'
alias cy-o='npm run cypress:open'
alias cy-t='npm run cypress:test'
alias cy-a='npm run cypress:approve'
alias ngrok='~/.ngrok'
alias yt-u='HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade yt-dlp'
alias lorem='cat ~/code/misc/lorem.txt | pbcopy'
alias lsg="ls | grep"
alias kill3000='kill -9 $(lsof -ti:3000)'	# Kill process on port 3000
killprocess () { kill -9 $(lsof -ti:$1); }
alias kp='killprocess'
alias kpp='killprocess'
alias clean-desktop='desktop && find . -maxdepth 1 -type f -name "*Screenshot*" -delete && find . -maxdepth 1 -type f -name "*Screen Recording*" -delete'
alias scratch='touch ~/Desktop/scratch.txt && open ~/Desktop/scratch.txt'
alias dscratch='rm ~/Desktop/scratch.txt'
alias regenerate-package-lock='rm -rf node_modules && rm package-lock.json && npm i'
alias rpl='regenerate-package-lock'
alias pwdcp='pwd | pbcopy'
txt () { touch ~/Desktop/"$1".txt && open ~/Desktop/"$1".txt; }
cra () { npx create-react-app "$1" --use-npm; }
stringify () { node $PROJECTS_ROOT/stringify-file "$1" | pbcopy; }
wd () { whisper "$1" --language en --fp16 False --output_format txt --output_dir ~/Desktop --model small; }
alias whisper-default='wd'
wdo () {
  local audio="$1"
  local subdir="$2"
  local vault="$HOME/Documents/Obsidian Vault/3 - Reference/* Book Notes"
  local outdir="$vault/$subdir"

  whisper "$audio" \
    --language en \
    --fp16 False \
    --output_format txt \
    --output_dir "$outdir" \
    --model small

  local base="${audio##*/}"   # strip path → myfile.wav
  base="${base%.*}"           # strip ext  → myfile
  mv -- "$outdir/$base.txt" "$outdir/$base.md"
}
catbpg () { catBashProfile | grep "$1"; }
alias catbps='catbpg'
alias prd='create_pr_description'
alias edit-custom-patterns="$DEFAULT_IDE $FABRIC_CUSTOM_PATTERNS_PATH"
alias ecp="edit-custom-patterns"
alias patterns="$DEFAULT_IDE $FABRIC_PATTERNS_PATH"
alias cdpat="cd $FABRIC_PATTERNS_PATH"
jina () { curl "https://r.jina.ai/$1" | pbcopy; }
alias scrape='jina'

function update-fabric() {
    # Install/update fabric
    echo "Installing/updating fabric..."
    if ! go install github.com/danielmiessler/fabric@latest; then
        echo "Error: Failed to install/update fabric. Aborting."
        return 1
    fi
    echo "Fabric successfully updated!"
    
    # Check if FABRIC_CUSTOM_PATTERNS_PATH environment variable exists
    if [ -z "${FABRIC_CUSTOM_PATTERNS_PATH}" ]; then
        echo "FABRIC_CUSTOM_PATTERNS_PATH is not set. Please add it to local.sh like this:"
        echo "export FABRIC_CUSTOM_PATTERNS_PATH=/path/to/your/fabric/patterns"
        return 1
    else
        # If the path exists, run the copy-patterns.sh script
        if [ -f "${FABRIC_CUSTOM_PATTERNS_PATH}/copy-patterns.sh" ]; then
            echo "Running copy-patterns.sh script..."
            if ! sh "${FABRIC_CUSTOM_PATTERNS_PATH}/copy-patterns.sh" "$FABRIC_CUSTOM_PATTERNS_PATH"; then
                echo "Error: Failed to execute copy-patterns.sh script."
                return 1
            fi
            echo "Custom patterns successfully copied!"
        else
            echo "Warning: ${FABRIC_CUSTOM_PATTERNS_PATH}/copy-patterns.sh not found"
            return 1
        fi
    fi
    
    return 0
}

# Ollama
DEFAULT_LARGE_MODEL="gemma3:27b"
DEFAULT_MODEL="gemma3:12b"

ola () {
  if [ "$1" = "-l" ]; then
    ollama run $DEFAULT_LARGE_MODEL
  else
    ollama run $DEFAULT_MODEL
  fi
}
alias olma=ola

# Requires `brew install jq`
function npm-downloads {
    local -A downloads

    for PACKAGE_NAME in "$@"; do
        WEEKLY_DOWNLOADS=$(curl -s https://api.npmjs.org/downloads/point/last-week/$PACKAGE_NAME | jq '.downloads')
        downloads[$PACKAGE_NAME]=$WEEKLY_DOWNLOADS
    done

    for PACKAGE_NAME in ${(o)${(k)downloads:#(|-*)}}; do
        echo "Weekly downloads for $PACKAGE_NAME: \t${downloads[$PACKAGE_NAME]}"
    done | sort -t ':' -k2 -nr
}
alias npm-d='npm-downloads'
alias nd='npm-downloads'

remove_empty_dirs() {
  if [ -z "$1" ]; then
    echo "Usage: remove_empty_dirs <directory>"
    return 1
  fi

  local target_dir="$1"

  if [ ! -d "$target_dir" ]; then
    echo "Error: $target_dir is not a valid directory."
    return 1
  fi

  find "$target_dir" -type d -empty -delete
  echo "Empty folders in '$target_dir' have been removed."
}
alias clean_empty_folders='remove_empty_dirs'

function cpwd() {
  local res

  if [ "$1" = "-l" ]; then
    res=$(pwd)
  else
    res=$(basename "$PWD")
  fi

  echo "Copying '$res' to clipboard..."
  echo "$res" | pbcopy
}

source_local

export EDITOR=nano
export VISUAL="$EDITOR"
