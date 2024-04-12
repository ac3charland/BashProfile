unalias_if_exists() {
    for alias_name in "$@"; do
        if [[ -n $(alias "$alias_name" 2>/dev/null) ]]; then
            unalias "$alias_name"
        fi
    done
}