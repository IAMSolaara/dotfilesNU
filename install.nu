#!/usr/bin/env nu

def replace-with-link [--src: string, --dst: string] {
	if ($src != $dst) {
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

replace-with-link --src ($env.FILE_PWD | path join "env.nu") --dst $nu.env-path
replace-with-link --src ($env.FILE_PWD | path join "config.nu") --dst $nu.config-path
