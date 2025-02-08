#Setup
DEFAULT_IDE="windsurf"  # Change this to your preferred editor (e.g., "code", "windsurf", etc.)
SCRIPT_DIR="$(dirname "$0")"
UTILS_PATH="$SCRIPT_DIR/utils.sh"
source "$UTILS_PATH"

#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/docs'
alias downloads='cd ~/Downloads'
alias cdcode='cd ~/code'
alias projects='cd ~/code/projects'
alias proj='projects'

#Project Shortcuts
alias template='cd ~/code/projects/react-template/'
alias mac-setup='cd ~/code/projects/mac-setup-script/'

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
alias amend='git add . && git commit --amend'
alias resolveConflicts='gcam "Merge main into branch & resolve conflicts"'
alias rc='resolveConflicts'
alias cpwd='pwd | pbcopy'

function updateWithMain {
    local CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    gcm
    git pull
    git checkout "$CURRENT_BRANCH"
    gmm
}
alias uwm='updateWithMain'
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

#AWS Shortcuts
alias ap='amplify push'
alias as='amplify status'

#General Shortcuts
alias ws='windsurf'
alias ll='ls -la'
alias ns='npm start'
alias ni='npm i'
alias nsd='npm run start:dev'
alias us='npm run update-schema'
alias sd='npm run develop'   # Strapi run command
# alias go='npm test'
alias go-bs='npm run test:ci'
alias editBashProfile="code $SCRIPT_DIR"
alias ebp='editBashProfile'
alias refreshBashProfile="source $SCRIPT_DIR/profile.sh"
alias rbp='refreshBashProfile'
alias cdBashProfile="cd $SCRIPT_DIR"
alias cdbp='cdBashProfile'
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
alias yt-u='brew upgrade yt-dlp'
alias lorem='cat ~/code/misc/lorem.txt | pbcopy'
alias kill3000='kill -9 $(lsof -ti:3000)'	# Kill process on port 3000
alias clean-desktop='find ~/Desktop -maxdepth 1 -type f -name "*Screenshot*" -delete && find ~/Desktop -maxdepth 1 -type f -name "*Screen Recording*" -delete'
alias scratch='touch ~/Desktop/scratch.txt && open ~/Desktop/scratch.txt'
alias dscratch='rm ~/Desktop/scratch.txt'
alias regenerate-package-lock='rm -rf node_modules && rm package-lock.json && npm i'
alias rpl='regenerate-package-lock'
alias pwdcp='pwd | pbcopy'
txt () { touch ~/Desktop/"$1".txt && open ~/Desktop/"$1".txt; }
cra () { npx create-react-app "$1" --use-npm; }
stringify () { node ~/code/projects/stringify-file "$1" | pbcopy; }
wd () { whisper "$1" --language en --fp16 False --output_format txt --output_dir ~/Desktop --model small; }
alias whisper-default='wd'
catbpg () { catBashProfile | grep "$1"; }
alias catbps='catbpg'
alias prd='create_pr_description'

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

# If it exists, source local aliases from local.sh
# Duplicate aliases will default to the version in local.sh 
LOCAL_PATH="$SCRIPT_DIR/local.sh"
if [ -f "$LOCAL_PATH" ]; then
    source "$LOCAL_PATH"
fi

export EDITOR=nano
export VISUAL="$EDITOR"
