if status is-interactive
    # Starship custom prompt
    starship init fish | source

    # Direnv + Zoxide
    command -v direnv &> /dev/null && direnv hook fish | source
    command -v zoxide &> /dev/null && zoxide init fish --cmd cd | source

    # Dotfiles bare repo
    alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

    # Better ls
    alias ls='eza --icons --group-directories-first -1'

    # Abbrs
    abbr lg 'lazygit'
    abbr gd 'git diff'
    abbr ga 'git add .'
    abbr gc 'git commit -am'
    abbr gl 'git log'
    abbr gs 'git status'
    abbr gst 'git stash'
    abbr gsp 'git stash pop'
    abbr gp 'git push'
    abbr gpl 'git pull'
    abbr gsw 'git switch'
    abbr gsm 'git switch main'
    abbr gb 'git branch'
    abbr gbd 'git branch -d'
    abbr gco 'git checkout'
    abbr gsh 'git show'

    abbr l 'ls'
    abbr ll 'ls -l'
    abbr la 'ls -a'
    abbr lla 'ls -la'

    # Custom colours
    cat ~/.local/state/caelestia/sequences.txt 2> /dev/null

    # Fowl-Custom-Function
    function ollauncher --description "Launch Ollama with parameters"
        set -x OLLAMA_MODELS /media/Zodiark/Git/LLM/ollama-models 
        set -x OLLAMA_HOST 0.0.0.0:11434 
        set -x OLLAMA_DEBUG 1 
        set -x HIP_VISIBLE_DEVICES 0 
        set -x HSA_OVERRIDE_GFX_VERSION 11.0.0 
        ollama serve
    end

    # For jumping between prompts in foot terminal
    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end

    # Custom fish config
    source ~/.config/caelestia/user-config.fish 2> /dev/null

    # Set PATH to include user's private bin if it exists
    if test -d "$HOME/.local/bin"
        set -gx PATH "$HOME/.local/bin" $PATH
    end

end

fish_add_path /home/richterfowl/.spicetify
fish_add_path ~/.npm-global/bin
