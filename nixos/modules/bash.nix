{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.fzf ];
  
  programs.bash = {
    
    enableCompletion = true;
    shellAliases = {
      grep = "grep --color=auto";
      # code = "code --enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
    promptInit = ''
      PS1="\[\e[1m\]\[\e[32m\]\s \W ->\[\e[0m\] "
    '';
    interactiveShellInit = ''
      # cd ~/data
      
      shopt -s histappend
      PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
      HISTSIZE=10000

      if command -v fzf-share >/dev/null; then
        source "$(fzf-share)/key-bindings.bash"
        source "$(fzf-share)/completion.bash"
      fi
    '';
  };

  environment.variables = {
    TIMEFORMAT = "%Rs";
  };


}
