let carapace_init_script = ($nu.vendor-autoload-dirs | last | path join "02-carapace-init.nu")
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
carapace _carapace nushell | save --force $carapace_init_script

