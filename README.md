# flakes
Nix flakes

add your hardware-configuration.nix file to this folder

assuming this repo is in /home/tyler/github/flakes/

```
sudo nixos-rebuild switch --flake '/home/tyler/github/flakes/#tyler';
```

'home' to edit home config  
'config' to edit main config  
'rebuild' to rebuild and switch system  