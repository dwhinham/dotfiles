# Colored man pages with less
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")        # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;38;5;74m")   # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")            # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")            # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[38;5;246m")     # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")            # end underline
set -xU LESS_TERMCAP_us (printf "\e[04;38;5;146m")  # begin underline
