strip_duplicates() {
    # unique values only
    sort -u ~/.fzf_favorites > ~/.fzf_favorites_backup
    rm ~/.fzf_favorites
    mv ~/.fzf_favorites_backup ~/.fzf_favorites
}

bookmark-rec() {
    _dir=`find $1 -type d -maxdepth $2`;
    for i in $_dir; do
        echo $i >> ~/.fzf_favorites
    done

    strip_duplicates()
}

bookmark-dir() {
    echo $1 >> ~/.fzf_bookmarks

    strip_duplicates()
}
