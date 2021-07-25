{ default ? import ./default.nix {}
, pkgs ? import (import ./nix/sources.nix).nixpkgs {}
}:
let
  obelisk = default.obelisk;
  obPkgs = obelisk.nixpkgs;
in
pkgs.mkShell {
  packages = with pkgs; [
    niv
    rnix-lsp
  ] ++ [
    obelisk.command
  ];
}
