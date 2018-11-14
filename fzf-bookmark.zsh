bk_widget() LBUFFER+=$(bk)
zle -N bk_widget
bindkey '^b' bk_widget

export $FZFBOOKMARKS="~/.fzf_bookmarks"
export $FZFBOOKMARKS_BACKUP="~/.fzf_bookmarks_backup"

strip_duplicates() {
    # unique values only
    sort -u $FZFBOOKMARKS > $FZFBOOKMARKS_BACKUP
    rm $FZFBOOKMARKS
    mv $FZFBOOKMARKS_BACKUP $FZFBOOKMARKS
}

bk-rm() {
    echo "$1 was removed from bookmarks."
    sed -n '/^${1}$/!p' $FZFBOOKMARKS
    # mv ~/.fzf_bookmarks_backup ~/.fzf_bookmarks
}

bk() {
    if [ "$1" = "--help" ]; then
        echo "BK how to:\n"
        echo "$ bk [directory] [number of subdirectories to bookmark]\n"
        echo "# bookmark user Home directory and 3 levels of subdirectories"
        echo "$ bk ~ 3 \n"
        echo "# bookmark ./Work directory only"
        echo "$ bk ./Work \n"
        echo "# bookmark current directory"
        echo "$ bk . \n"
        echo "List current bookmarked directories:"
        echo "$ bk"
    else
        if [ -z $1 ]; then
            local dir
            dir=$(cat $FZFBOOKMARKS | fzf +m) && echo "$dir"
        else
            if [ -z $2 ]; then
                if [ "${1}" = "." ]; then
                    echo `pwd` >> $FZFBOOKMARKS
                    echo "`pwd` was bookmarked."
                else
                    # remove trailling / if there is one
                    if [ "${1[-1]}" = "/" ]; then
                        echo ${1[1,-2]} >> $FZFBOOKMARKS
                        echo "${1[1,-2]} was bookmarked."
                    else
                        echo $1 >> $FZFBOOKMARKS
                        echo "${1} was bookmarked."
                    fi
                fi
            else
                _dir=`find $1 -type d -maxdepth $2 | sed "s|^\./||"`;
                for i in $_dir; do
                    if [ "${i[-1]}" = "/" ]; then
                        echo ${i[1,-2]} >> $FZFBOOKMARKS
                        echo "${i[1,-2]} was bookmarked."
                    else
                        echo $i >> $FZFBOOKMARKS
                        echo "${i} was bookmarked."
                    fi
                done
            fi
            strip_duplicates
        fi
    fi
}
