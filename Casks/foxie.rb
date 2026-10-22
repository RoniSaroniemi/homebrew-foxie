cask "foxie" do
  version "0.4.0"
  sha256 "826c38d997db3dac63ab34ac98e46d2fd9147a728128dfecea588dfd804bfdae"

  url "https://storage.googleapis.com/foxie-cli-downloads-598510081965/releases/#{version}/darwin-arm64/foxie-#{version}-darwin-arm64.tar.gz"
  name "Foxie"
  desc "Personal Foxie CLI and local MCP server with a bundled runtime"
  homepage "https://foxie.ai/"

  depends_on arch: :arm64
  depends_on macos: :sequoia

  binary "foxie/bin/foxie", target: "foxie"

  preflight_steps do
    write_file "foxie/.foxie-cli-install", "826c38d997db3dac63ab34ac98e46d2fd9147a728128dfecea588dfd804bfdae", append_newline: true
    write_file "foxie/installation.json", <<~JSON
      {
        "contractVersion": "foxie-cli-installation.v1",
        "owner": "homebrew",
        "version": "0.4.0",
        "source": "b793452f2cd9ab4f6c07e19193d6554d990bca1b",
        "platform": "darwin-arm64",
        "artifactSha256": "826c38d997db3dac63ab34ac98e46d2fd9147a728128dfecea588dfd804bfdae",
        "layout": {
          "installRoot": ".",
          "launcher": "bin/foxie"
        },
        "homebrew": {
          "fullyQualifiedCask": "RoniSaroniemi/foxie/foxie"
        }
      }
    JSON
  end

  caveats <<~EOS
    Homebrew owns this installation. Run brew update, then:
      brew upgrade --cask RoniSaroniemi/foxie/foxie
    Register MCP hosts with the absolute path printed by command -v foxie.
    Restart/reconnect both hosts after an upgrade or CLI login replacement.
    Uninstalling preserves your personal grant and workspace selection.
    Run foxie auth logout before uninstalling only when you want to revoke it.
    Remove the previous installer's verified launcher before switching owners;
    do not force-link over another Foxie installation.
  EOS
end
