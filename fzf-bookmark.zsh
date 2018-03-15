strip_duplicates() {
    # unique values only
    sort -u ~/.fzf_bookmarks > ~/.fzf_bookmarks_backup
    rm ~/.fzf_bookmarks
    mv ~/.fzf_bookmarks_backup ~/.fzf_bookmarks
}

bookmark-rec() {
    _dir=`find $1 -type d -maxdepth $2`;
    for i in $_dir; do
        echo $i >> ~/.fzf_bookmarks
    done

    strip_duplicates
}

bookmark-dir() {
    echo $1 >> ~/.fzf_bookmarks

    strip_duplicates
}

bookmark-list() {
    local dir
    dir=$(cat ~/.fzf_bookmarks | fzf +m) && cd "$dir"
}
