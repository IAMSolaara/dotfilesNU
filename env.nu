# Nushell Environment Config File
#
# version = "0.96.0"
# vim:ts=4:sw=4:expandtab


# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]


# -----
$env.EDITOR = 'nvim'

use std "path add"
path add /opt/homebrew/bin/
path add /usr/local/bin
path add ~/.local/bin
path add ~/.cargo/bin
path add /opt/homebrew/opt/mysql-client@5.7/bin
path add /opt/homebrew/opt/mysql-client/bin
path add ($env.HOME | path join '.krew' | path join 'bin')

$env.JAVA_HOME = (/usr/libexec/java_home -v 21)

mkdir $nu.cache-dir

let ohmyposh_init_script = ($nu.vendor-autoload-dirs | last | path join "oh-my-posh-init.nu" )
oh-my-posh init nu --config ($env.HOME | path join dotfiles | path join "oh-my-posh" | path join "so-shell.omp.yaml") --print | save $ohmyposh_init_script --force

let carapace_init_script = ($nu.vendor-autoload-dirs | last | path join "carapace-init.nu")
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
carapace _carapace nushell | save --force $carapace_init_script
# -----
