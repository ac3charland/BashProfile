#Git Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Git Prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/docs'
alias cdcode='cd ~/code'
alias projects='cd ~/code/projects'

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

#Git Shortcuts
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
gcam () { git commit -am "$1"; }
gc () { git checkout "$1"; }
gcb () { git checkout -b "$1"; }
gm () { git merge "$1"; }
gbd () { git branch -D "$1"; }
gd () { git diff "$1"~ "$1"; }

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
alias editBashProfile='nano ~/code/misc/BashProfile/profile.sh'
alias ebp='editBashProfile'
alias refreshBashProfile='source ~/code/misc/BashProfile/profile.sh'
alias rbp='refreshBashProfile'
alias cdBashProfile='cd ~/code/misc/BashProfile'
alias cdbp='cdBashProfile'
alias bs-t='npm run backstop:test'
alias bs-r='npm run backstop:report'
alias bs-a='npm run backstop:approve'
alias cy-o='npm run cypress:open'
alias cy-t='npm run cypress:test'
alias ngrok='~/.ngrok'
alias yt-u='brew upgrade youtube-dl'
vlogme () { cd ~/code/projects/NeistatScript && sh run.sh; }
txt () { touch ~/Desktop/"$1".txt && open ~/Desktop/"$1".txt; }
yt () { desktop && youtube-dl -f mp4 "$1"; }
yt-a () { desktop && youtube-dl --extract-audio --audio-format mp3 "$1"; }
cra () { npx create-react-app "$1" --use-npm; }


export EDITOR=nano
export VISUAL="$EDITOR"
