{
  lib,
  buildGo122Module, # builds, but does not start on 1.23
  fetchFromGitHub,
  nix-update-script,
}:

buildGo122Module rec {
  pname = "bitmagnet";
  version = "0.9.5";

  src = fetchFromGitHub {
    owner = "bitmagnet-io";
    repo = "bitmagnet";
    rev = "v${version}";
    hash = "sha256-so9GD9hyGfuqqYq61OD1WJXba22cR4msOPp1wLI5vAU=";
  };

  vendorHash = "sha256-aauXgHPZbSiTW9utuHXzJr7GsWs/2aFiGuukA/B9BRc=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/bitmagnet-io/bitmagnet/internal/version.GitTag=v${version}"
  ];

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    description = "Self-hosted BitTorrent indexer, DHT crawler, and torrent search engine";
    longDescription = ''
      A self-hosted BitTorrent indexer, DHT crawler, content classifier and torrent search engine with web UI, GraphQL API and Servarr stack integration.
    '';
    homepage = "https://bitmagnet.io/";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ viraptor ];
    mainProgram = "bitmagnet";
  };
}
