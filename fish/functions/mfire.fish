function mfire --description "Grant or revoke mnemosyne-fire elevated access on homelab CTs"
    set -l usage "Usage: mfire elevate|revoke [media|infra|both]"

    if test (count $argv) -lt 1
        echo $usage
        return 1
    end

    set -l action $argv[1]
    set -l target (test (count $argv) -ge 2; and echo $argv[2]; or echo "both")

    switch $action
        case elevate
            set -l cmd "sudo usermod -aG mnemosyne-fire mnemosyne && echo 'elevated'"
        case revoke
            set -l cmd "sudo gpasswd -d mnemosyne mnemosyne-fire && echo 'revoked'"
        case '*'
            echo $usage
            return 1
    end

    switch $target
        case media
            echo "[$action] CT 101 mnemosyne-media..."
            ssh mnemosyne $cmd
        case infra
            echo "[$action] CT 100 mnemosyne-infra..."
            ssh mnemosyne-infra $cmd
        case both
            echo "[$action] CT 100 mnemosyne-infra..."
            ssh mnemosyne-infra $cmd
            echo "[$action] CT 101 mnemosyne-media..."
            ssh mnemosyne $cmd
        case '*'
            echo "Unknown target '$target'. Use: media, infra, or both"
            return 1
    end

    if test $action = elevate
        echo "Done. Tell the agent to reconnect in Discord — group changes don't apply to active sessions."
    end
end
