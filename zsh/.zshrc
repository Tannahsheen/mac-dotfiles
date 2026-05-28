export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="ohmy-pentest-report"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)
source $ZSH/oh-my-zsh.sh

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.local/bin:$HOME/.local/sbin:$PATH"

# === pentest aliases ===

function mkcd() { mkdir -p "$1"; cd "$1"; }

function td() {
    directory=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    mkdir "/tmp/$directory"
    cd "/tmp/$directory"
}

function tf() {
    file=tf-$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)
    vim "/tmp/$file"
    echo "$file"
}

function cl() {
    DIR="$1"; [ -z "$DIR" ] && DIR="$HOME"
    builtin cd "$DIR" && ls
}

alias ip-grepper="grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

alias myips='ifconfig | awk "/^[a-z]/{iface=\$1} /inet /{if(iface !~ /^(lo|bridge|vmenet|awdl|llw|en25)/ && \$2 !~ /^169\.254/)print iface, \$2}"'

# Usage: nmapq <target> <output-basename>
function nmapq() {
    if ! command -v nmap >/dev/null 2>&1; then
        echo "nmapq: nmap not found"; return 1
    fi
    sudo nmap -sCV -T4 --open -oA "$2" "$1"
}

# Usage: nmapfull <target> <output-basename>
function nmapfull() {
    if ! command -v nmap >/dev/null 2>&1; then
        echo "nmapfull: nmap not found"; return 1
    fi
    sudo nmap -p- -T4 --open "$1" -oG "${2}_allports" \
    && ports=$(grep -oE '[0-9]+/open' "${2}_allports.gnmap" | cut -d/ -f1 | paste -sd,) \
    && sudo nmap -sCV -p "$ports" "$1" -oA "${2}_detail"
}

# Usage: rlnc <port>
function rlnc() {
    if ! command -v rlwrap >/dev/null 2>&1; then
        echo "rlnc: rlwrap not found"; return 1
    fi
    rlwrap nc -lvnp "$1"
}

# Usage: handler <port> <payload>
# e.g.   handler 4444 windows/x64/meterpreter/reverse_tcp
function handler() {
    if ! command -v msfconsole >/dev/null 2>&1; then
        echo "handler: msfconsole not found"; return 1
    fi
    sudo msfconsole -q -x "use multi/handler; set LHOST 0.0.0.0; set LPORT $1; set payload $2; run"
}

# === end pentest aliases ===
