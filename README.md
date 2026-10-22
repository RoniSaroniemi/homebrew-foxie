# Foxie for Homebrew

Use the runtime-inclusive Foxie CLI and its local MCP server on Apple Silicon Macs with macOS 15 or later and current Homebrew. No separate Node installation is needed. This tap reuses Foxie's immutable qualified native archive; it does not rebuild the CLI.

## Install

First update Homebrew. Run the following in a fresh ordinary Terminal. The existing-command check prevents two Foxie installation owners from competing on PATH; it does not remove anything.

```sh
brew update
(
  existing=$(command -v foxie || true)
  if [ -n "$existing" ]; then
    printf 'Existing Foxie command: %s\n' "$existing" >&2
    printf '%s\n' 'Refusing a second PATH owner. Remove only the verified old installer launcher with its original owner; keep the personal grant, profile, default and retained recovery version. See the ownership-transfer instructions.' >&2
    exit 1
  fi
  brew install --cask RoniSaroniemi/foxie/foxie
)
```

Then open a new Terminal, move outside any source repository, and run:

```sh
command -v foxie
foxie --version
foxie auth status
```

Expect the absolute Homebrew `bin/foxie` launcher. Compare `foxie --version` with the installed version shown by `brew info --cask RoniSaroniemi/foxie/foxie`; after installation or upgrade they must agree. If you already have a valid personal Foxie grant, installation preserves it. Otherwise use `foxie auth login`, complete the browser's own sign-in/consent and check the CLI confirmation. Use `foxie context list` and explicitly select the workspace with `foxie context use WORKSPACE_UUID` when needed. Never put tokens in MCP configuration.

Register Codex and Claude Code using the absolute launcher printed by `command -v foxie`, followed by `mcp serve --tenant WORKSPACE_UUID --environment staging` (or your explicitly chosen environment). Replace only your owned Foxie entry through the host's supported management commands. Restart/reconnect both hosts after installation, upgrade or CLI login replacement; an existing MCP process keeps its startup code and login generation.

## Update

`brew update` refreshes Homebrew/tap metadata. It does not replace the installed Foxie executable. Upgrade the software with:

```sh
brew upgrade --cask RoniSaroniemi/foxie/foxie
foxie --version
```

`foxie update` reports these Homebrew instructions and does not modify Homebrew's files. Restart/reconnect both MCP hosts after the upgrade. Keep the same personal login/default workspace unless you explicitly intend to replace it.

## Change installation owner or recover

Before changing owners, record the actual `command -v foxie`, version and nonsecret `foxie auth status`/workspace facts. End the owned Foxie MCP processes through their hosts and retain a known working recovery version. Remove only the verified OLD owner's command, without deleting the personal grant or profile:

- **Native user installation:** verify that the installer-created `~/.local/bin/foxie` symlink still points to the recorded native version/source, then unlink only that exact symlink. Retain `~/.local/share/foxie/versions` and the Foxie profile/default/generation and Keychain records. If the target or owner is uncertain, stop rather than removing it.
- **Homebrew:** use `brew uninstall --cask RoniSaroniemi/foxie/foxie`. Do not use a credential-deleting cleanup operation. Then rerun the desired qualified native installer or use the actual admitted package manager.
- **npm:** remove the executable with npm's global uninstall for the actual installed package name, after verifying its owner. No npm package/account entitlement is implied by this tap.
- **Foreign or ambiguous command:** inspect it and resolve its owner first. Do not use force/overwrite/adopt flags to bypass the conflict.

Run the first-install check again, install through the NEW owner, verify the absolute new launcher/version/auth status and reconnect both hosts to that stable command. This is an explicit transfer, never an automatic uninstall or grant replacement.

If the new owner fails to install, inspect the actual launcher before retrying. Restore the retained old owner/version through its original qualified installer or manager; never overwrite a foreign command. The native public 0.4.0 recovery installer is `https://storage.googleapis.com/foxie-cli-downloads-598510081965/releases/0.4.0/install.sh`. It verifies the immutable native source/archive and refuses a foreign launcher. A manager recovery selects an actual retained cask/version through Homebrew; this guide does not promise a registry-wide atomic rollback.

## Remove

```sh
brew uninstall --cask RoniSaroniemi/foxie/foxie
```

Uninstall removes this cask's command and payload. It preserves the personal grant, workspace selection and profile. Run `foxie auth logout` before uninstalling only if you want to revoke that grant. Do not remove another installer, package, host registration or session as cleanup.

This cask supports Mac ARM64 only; the native archive's source floor of Mac 11 is separate from Homebrew's supported Mac 15+ floor. Linux/Windows and npm publication require their own accepted delivery. Foxie retains its proprietary status and required third-party notices; this tap grants no new open-source licence.
