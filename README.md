# flakes
Nix flakes

add your hardware-configuration.nix file to this folder

assuming this repo is in /home/tyler/github/nix/

```
sudo nixos-rebuild switch --flake '/home/tyler/github/nix/#tyler';
```

'home' to edit home config  
'config' to edit main config  
'rebuild' to rebuild and switch system  