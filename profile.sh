#Git Autocomplete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#Git Shortcuts
alias status='git status'
alias pull='git pull'
alias push='git push'
alias gcm='git checkout master'
alias gmm='git merge master'
alias glo='git log --oneline'
gcam () { git commit -am "$1"; }
gc () { git checkout "$1"; }
gcb () { git checkout -b "$1"; }
gm () { git merge "$1"; }

#AWS Shortcuts
alias ap='amplify push'
alias as='amplify status'

#General Shortcuts
alias ns='npm start'
alias editBashProfile='nano ~/code/Misc/BashProfile/profile.sh'
alias ebp='editBashProfile'
alias refreshBashProfile='source ~/code/Misc/BashProfile/profile.sh'
alias rbp='refreshBashProfile'
alias cdBashProfile='cd ~/code/Misc/BashProfile'
alias cdbp='cdBashProfile'
alias bs-t='npm run backstop:test'
alias bs-r='npm run backstop:report'
alias bs-a='npm run backstop:approve'
alias cy-o='npm run cypress:open'
alias cy-t='npm run cypress:test'
vlogme () { sh ~/code/projects/NeistatScript/run.sh "$1"; }
txt () { touch ~/Desktop/"$1".txt && open ~/Desktop/"$1".txt; }
yt () { desktop && youtube-dl "$1"; }
yt-a () { desktop && youtube-dl --extract-audio --audio-format mp3 "$1"; }

#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias cdcode='cd ~/code'
alias projects='cd ~/code/projects'

#Project Shortcuts
alias patch-store='cd ~/code/projects/patch-store'
alias ewipatches='cd ~/code/projects/ewipatches'
