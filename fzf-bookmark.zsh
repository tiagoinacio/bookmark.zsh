bk_widget() LBUFFER+=$(bk)
zle -N bk_widget
bindkey '^b' bk_widget

strip_duplicates() {
    # unique values only
    sort -u ~/.fzf_bookmarks > ~/.fzf_bookmarks_backup
    rm ~/.fzf_bookmarks
    mv ~/.fzf_bookmarks_backup ~/.fzf_bookmarks
}

bk-rm() {
    echo "$1 was removed from bookmarks."
    sed -n '/^${1}$/!p' ~/.fzf_bookmarks
    # mv ~/.fzf_bookmarks_backup ~/.fzf_bookmarks
}

bk() {
    if [ -z $1 ]; then
        local dir
        dir=$(cat ~/.fzf_bookmarks | fzf +m) && echo "$dir"
    else
        if [ -z $2 ]; then
            if [ "${1}" = "." ]; then
                echo `pwd` >> ~/.fzf_bookmarks
                echo "`pwd` was bookmarked."
            else
                # remove trailling / if there is one
                if [ "${1[-1]}" = "/" ]; then
                    echo ${1[1,-2]} >> ~/.fzf_bookmarks
                    echo "${1[1,-2]} was bookmarked."
                else
                    echo $1 >> ~/.fzf_bookmarks
                    echo "${1} was bookmarked."
                fi
            fi
        else
            _dir=`find $1 -type d -maxdepth $2 | sed "s|^\./||"`;
            for i in $_dir; do
                if [ "${i[-1]}" = "/" ]; then
                    echo ${i[1,-2]} >> ~/.fzf_bookmarks
                    echo "${i[1,-2]} was bookmarked."
                else
                    echo $i >> ~/.fzf_bookmarks
                    echo "${i} was bookmarked."
                fi
            done
        fi
        strip_duplicates
    fi
}
