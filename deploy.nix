{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "kndrck.co";
  src = ./.;
  phases = "unpackPhase buildPhase";  
  buildPhase = ''
    export LANG=en_US.UTF-8
    $out/bin/generate-site rebuild

    # Commit changes
    git push origin hakyll

    # Clean rebuild
    mkdir .deploy
    cd .deploy
    git init
    git remote add origin git@github.com:kendricktan/kendricktan.github.io.git
    
    # Add built site files
    cp -r ../_site/* .
    echo "kndrck.co" >> CNAME
    git add .
    git commit -m 'Publish'
    git push -f origin master

    # Cleanup .deploy directory after a successful push
    cd .. && rm -rf .deploy
  '';
}