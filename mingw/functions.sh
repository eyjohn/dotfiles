function is_mingw
{
    if [[ $(uname) =~ "MINGW" ]]; then
        true
    else
        false
    fi    
}