#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/docs'
alias downloads='cd ~/Downloads'
alias cdcode='cd ~/code'
alias projects='cd ~/code/projects'
alias proj='projects'

#Project Shortcuts
alias patch-store='cd ~/code/projects/patch-store'
alias ewipatches='cd ~/code/projects/ewipatches'
alias charlandswed='cd ~/code/projects/CharlandsWedWebsite/'
alias portfolio='cd ~/code/projects/react-portfolio-redux/'
alias tflr='cd ~/code/projects/tflr/'
alias template='cd ~/code/projects/react-template/'
alias jacob='cd ~/code/projects/jacob-portfolio/'
alias bruce='cd ~/code/projects/bsk-mastersound/'
alias mac-setup='cd ~/code/projects/mac-setup-script/'
alias shopping='cd ~/code/projects/react-native-shopping-list/'
alias nobody='cd ~/code/projects/nobody-cares-about-your-project/'
alias dka='cd ~/code/projects/dka-app/'
alias crypto='cd ~/code/projects/crypto-bot/'
alias ear='cd ~/code/projects/ear-trainer'
alias earb='cd ~/code/projects/ear-trainer-server'
alias pyq='open ~/Desktop/python-rudiments-quiz.txt ~/Desktop/python-rudiments-quiz-key.txt'
alias sound='cd ~/code/projects/sound-spectrum-analyzer'

#Git Shortcuts
alias nogit='xcode-select --install'
alias status='git status'
alias st='status'
alias pull='git pull'
alias push='git push'
alias gb='git branch'
alias gcm='git checkout main || git checkout master'
alias gcd='git checkout development'
alias gmm='git merge main || git merge master'
alias glo='git log --oneline'
alias gld='git log --pretty=format:"%h%x09%an%x09%ad%x09%s"'
alias gitCheatSheet='open https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index'
alias gcs='gitCheatSheet'
alias amend='git add . && git commit --amend'
alias resolveConflicts='gcam "Merge main into branch & resolve conflicts"'
alias rc='resolveConflicts'
alias acp='git add . && git commit -am "Forgot to add new untracked files" && git push'
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
    if [ -z "$1" ]; then
        echo "Usage: gcamp <commit_message>"
        return 1
    fi
    echo "$1"
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

#AWS Shortcuts
alias ap='amplify push'
alias as='amplify status'

#General Shortcuts
alias ll='ls -la'
alias ns='npm start'
alias nsd='npm run start:dev'
alias us='npm run update-schema'
alias sd='npm run develop'   # Strapi run command
alias go='npm test'
alias go-bs='npm run test:ci'
alias editBashProfile='code ~/code/misc/BashProfile'
alias ebp='editBashProfile'
alias refreshBashProfile='source ~/code/misc/BashProfile/profile.sh'
alias rbp='refreshBashProfile'
alias cdBashProfile='cd ~/code/misc/BashProfile'
alias cdbp='cdBashProfile'
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
alias pct='~/code/projects/habit-chart-date-percentage-calc/target/release/habit-chart-date-percentage-calc'
alias habit-percent='pct'
alias print-chart='lp ~/Desktop/habit-tracker.png'
alias pc='print-chart'
alias make_thumbnail="~/code/projects/ig_thumbnail_creator/target/release/ig_thumbnail_creator"
alias clean-desktop='find ~/Desktop -maxdepth 1 -type f -name "*Screenshot*" -delete && find ~/Desktop -maxdepth 1 -type f -name "*Screen Recording*" -delete'
vlogme () { cd ~/code/projects/NeistatScript && sh run.sh; }
txt () { touch ~/Desktop/"$1".txt && open ~/Desktop/"$1".txt; }
yt () { desktop && yt-dlp -f mp4 "$1"; }
yt-a () { desktop && yt-dlp --extract-audio --audio-format mp3 "$1"; }
cra () { npx create-react-app "$1" --use-npm; }
stringify () { node ~/code/projects/stringify-file "$1" | pbcopy; }

# If it exists, source local aliases from local.sh
# Duplicate aliases will default to the version in local.sh 
SCRIPT_DIR="$(dirname "$0")"
LOCAL_PATH="$SCRIPT_DIR/local.sh"
if [ -f "$LOCAL_PATH" ]; then
    source "$LOCAL_PATH"
fi

export EDITOR=nano
export VISUAL="$EDITOR"
export ANDROID_SDK=/Users/alexcharland/Library/Android/sdk
