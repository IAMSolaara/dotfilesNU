let ohmyposh_init_script = ($nu.vendor-autoload-dirs | last | path join "02-oh-my-posh-init.nu" )
oh-my-posh init nu --config ($env.HOME | path join dotfiles | path join "oh-my-posh" | path join "so-shell-catppuccin.omp.yaml") --print | save $ohmyposh_init_script --force

