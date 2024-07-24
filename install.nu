#!/usr/bin/env nu

def replace-with-link [--src: string, --dst: string] {
	let real_src = $src | path expand  -s
	let real_dst = $dst | path expand  -s

	if ($real_src != $real_dst) {
		if (($dst | path type) != "symlink") {
			try {
				rm $dst
			}
			^ln -s $src $dst
			print $"file ($src) installed to ($dst)"
		}
	} else {
		print $"file ($src) already installed."
	}
}

# Install main files
replace-with-link --src ($env.FILE_PWD | path join "env.nu") --dst $nu.env-path
replace-with-link --src ($env.FILE_PWD | path join "config.nu") --dst $nu.config-path

# Install autoload files
mkdir ($nu.vendor-autoload-dirs | last)

let files = glob --depth 1 --no-dir ($env.FILE_PWD | path join "autoload" | path join "*.nu") 
for file in $files {
	replace-with-link --src $file --dst ( $nu.vendor-autoload-dirs | last | path join ($file | path basename ))
}
