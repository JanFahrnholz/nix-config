{
  lib,
  pkgs,
  user,
  ...
}:
{
    environment.systemPackages = with pkgs; [
        python3
        chroma
        du-dust
        eza
        starship
    ];

    programs.zsh.enable = true;

    home-manager.users.${user} = {
        programs.starship.enable = true;
        programs.fzf.enable = true;
        programs.direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
        programs.zsh = {
            enable = true;

            antidote = {
                enable = true;
                plugins = [
                    "zsh-users/zsh-completions"
                    "zsh-users/zsh-autosuggestions"
                    "zsh-users/zsh-history-substring-search"
                    "zsh-users/zsh-syntax-highlighting"
                ];
            };

            shellAliases = {
                "ll" = "ls -hal";
                "dcu" ="docker-compose up";
                "dcd" ="docker-compose down";
                "dc" ="docker-compose";
                "dcp" ="docker cp";
                "dckill" ="docker kill $(docker ps -q)";
                "nl" ="php -d memory_limit=-1";
                "nlc" ="php -d memory_limit=-1 $(which composer)";
                "ds" ="docker ps";
                "dcx" ="docker-compose exec";
                "dx" ="docker exec -it";
                "ctx" ="kubectx";
                "ctl" ="kubectl";
                "dss" ="docker ps --format 'table {{ .ID }}\t{{.Names}}\t{{ .Image }}\t{{.Status}}\t{{ .RunningFor }}\t{{ .Size }}\t{{ .Networks }}'";
                "gl" ="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%as%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
            };
        };
    };
}