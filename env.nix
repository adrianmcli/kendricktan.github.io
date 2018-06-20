{ pkgs ? import <nixpkgs> {} }:

pkgs.haskell.lib.buildStackProject {
  name = "kndrck.co";  
  buildInputs = with pkgs; [    
    (haskellPackages.ghcWithPackages (p: with p; [ hakyll ]))    
  ];
  src = ./.;
  LANG = "en_US.UTF-8";
  TMPDIR = "/tmp";
}