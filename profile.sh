#Git Shortcuts
alias status='git status'
alias push='git push'
gcam () { git add . && git commit -m "$1"; }

#General Shortcuts
alias editBashProfile='nano ~/code/Misc/BashProfile/profile.sh'
alias ebp='editBashProfile'
alias cdBashProfile='cd ~/code/Misc/BashProfile'
alias cdbp='cdBashProfile'
vlogme () { sh ~/code/projects/NeistatScript/run.sh "$1"; }

#Navigation Shortcuts
alias desktop='cd ~/Desktop'
alias documents='cd ~/Documents'
alias cdcode='cd ~/code'
alias projects='cd ~/code/projects'

#Project Shortcuts
alias patch-store='cd ~/code/projects/patch-store'
