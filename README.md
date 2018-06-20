# Personal Website
[Live Demo](https://kndrck.co)

```bash
# Using Nix
# https://utdemir.com/posts/hakyll-on-nixos.html
nix-shell env.nix

# To build executable
ghc -O2 -dynamic --make site.hs -o bin/generate-site

# Local testing
bin/generate-site rebuild
bin/generate-site watch

# To deploy
./deploy.sh
```