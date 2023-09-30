set shell := ["bash", "-c"]
set windows-shell := ["bash.exe", "-c"]

deps := '''
htmx:https://unpkg.com/htmx.org/dist/htmx.min.js>js/htmx.js
'''

alias srv := serve

serve:
    lapis serve

alias upd := update
alias download := update

update:
    #!/usr/bin/env bash
    echo "Performing download..."
    read -ra deps <<<"{{deps}}"
    for v in "${deps[@]}"; do
        depname="${v%%:*}"
        : "${v#*:}"
        depurl="${_%%>*}"
        depfile="${v##*>}"
        echo "Downloading $depname..."
        [[ -e "$depfile" ]] && echo "Found file of $depname, updating..."
        curl -fLo "$depfile" "$depurl"
    done
    echo "Done!"
