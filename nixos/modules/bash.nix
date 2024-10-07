{ config, pkgs, ... }:

{
  programs.bash = {
    shellAliases = {
      grep = "grep --color=auto";
    };
  };

  environment.variables = {
    TIMEFORMAT = "%Rs";
  };
}
