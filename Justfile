set shell := ["bash", "-c"]
set windows-shell := ["bash.exe", "-c"]

deps := '''
"htmx:https://unpkg.com/htmx.org@1.9.6>js/htmx.js"
"_hyperscript:https://unpkg.com/hyperscript.org@0.9.11>js/_hyperscript.js"
'''

alias on := start

# Kill any existing server instance and run the server
@start:
    -lapis term >/dev/null
    lapis serve

alias updw := update-web

# Update dependencies required by the frontend side
update-web: dev-init
    #!/usr/bin/env bash
    cd static/depsi
    echo "Performing download..."
    deps=({{deps}})
    for v in "${deps[@]}"; do
        depname="${v%%:*}"
        : "${v#*:}"
        depurl="${_%%>*}"
        depfile="${v##*>}"
        echo "Downloading $depname..." &
        [[ -e "$depfile" ]] && echo "Found file of $depname, updating..."
        curl -fLo "$depfile" "$depurl"
    done
    echo "Done!"

alias updl := update-lua

# Update dependencies required by the backend side
@update-lua: dev-init
    luarocks install website-dev-1.rockspec --only-deps

# Test website
test browser="firefox": dev-init
    #!/usr/bin/env bash
    lapis term
    lapis serve &
    bun run cypress run -b "$1" || true
    kill %1

alias init := dev-init

# Initialize development environment
dev-init:
    -[[ ! -d lua_modules ]] && luarocks init
    -command -v direnv && direnv allow .
    -[[ ! -d node_modules ]] && command -v bun && bun install
