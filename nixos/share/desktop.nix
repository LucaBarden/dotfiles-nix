{ config, lib, pkgs, ... }:

{
  sound.enable = true;

  users.users.luca = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.fish;
   };


  users.defaultUserShell = pkgs.fish;
  
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.withPython3 = true;
  programs.neovim.viAlias = true;

  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.tmux = {
      enable = true;
      newSession = true;
      keyMode = "vi";
      historyLimit = 5000;
      clock24 = true;
      terminal = "screen-256color";
      extraConfig = ''
       set -g @catppuccin_flavour 'mocha'
      set -g @catppuccin_date_time "%d.%m.%Y %H:%M"
      set -g @catppuccin_powerline_icons_theme_enabled on
      set -g @catppuccin_l_left_separator ""
      set -g @catppuccin_l_right_separator ""
      set -g @catppuccin_r_left_separator ""
      set -g @catppuccin_r_right_separator ""
      run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
      run-shell ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
      run-shell ${pkgs.tmuxPlugins.catppuccin}/share/tmux-plugins/catppuccin/catppuccin.tmux
      '';
      plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];

  };
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    cryptsetup
    wget
    kitty
    firefox
    fastfetch
    waybar
    starship
    zoxide
    librewolf
    fd
    fzf
    nodejs
    (python312.withPackages (python-pkgs: [
	python-pkgs.requests
    ]))
    cmake
    swayidle
    swaylock-effects
    slurp
    grim
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-xapp
    xdg-desktop-portal-gnome
    xdg-desktop-portal-wlr
    wl-clipboard
    polkit_gnome
    greetd.regreet
    dracula-theme
    unzip
    xdg-utils
    rofi-bluetooth
    thunderbird
    swww
    killall
    btop
    brightnessctl
    wlogout
    postman
    jetbrains.datagrip
    pamixer
    pavucontrol
    lazygit
    nix-search-cli
    wl-mirror
    pinentry-qt
    eza
    prismlauncher
    swaynotificationcenter
    rustup
    rust-analyzer
    openssl.dev
    pkg-config
    ripgrep
    hugo
    go
    wayland-pipewire-idle-inhibit
    beautysh
    hadolint
    statix
    alejandra
    ruff
    black
    taplo
    prettierd
    nodePackages.bash-language-server
    nodePackages.typescript-language-server
    clojure-lsp
    texlab
    lua-language-server
    marksman
    pyright
    zls
    vscode-langservers-extracted
    jdt-language-server
    openjdk21
    vscode-extensions.vscjava.vscode-java-debug
    vscode-extensions.vscjava.vscode-java-test
  ];

programs.thunar.enable = true;
programs.xfconf.enable = true;

programs.thunar.plugins = with pkgs.xfce; [
  thunar-archive-plugin
  thunar-volman
];

services.gvfs.enable = true; # Mount, trash, and other functionalities
services.tumbler.enable = true; # Thumbnail support for images


environment.variables = {
  EDITOR = "vi";
  DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
  XCURSOR_SIZE = "32";
  GTK_THEME = "Dracula";
  PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig";
};

 security.pam.services.swaylock = {
    text = ''
      auth sufficient pam_fprintd.so
      auth include login
    '';
  };

  # greetd
  programs.regreet = {
    enable = true;
    settings = builtins.fromTOML ''
      [background]
      path = "/etc/greetd/background.jpg"
      fit = "Fill"

      [env]

      [GTK]
      cursor_theme_name = "Dracula"
      font_name = "Cantarell 16"
      icon_theme_name = "Dracula"
      theme_name = "Dracula"
    '';
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        hyprlandConfig = builtins.toFile "hyprland.regreet.conf" ''
          exec-once = regreet; hyprctl dispatch exit;
          windowrulev2=fullscreen, title:^regreet$
          animations {
            enabled = no
          }
          misc {
            disable_hyprland_logo = yes
            disable_splash_rendering = yes
          }
        '';
      in {
        command = "${pkgs.hyprland}/bin/Hyprland --config ${hyprlandConfig}";
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 8080 22];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

}

