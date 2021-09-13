# archive-mount-nautilus

Adds context actions to mount archives using `gvfsd-archive`

![Screenshot Context Menu](assets/screen.png)
![Screenshot Mounted Archive](assets/screen_2.png)

## Automatic installation

Available in [Arch Linux AUR (archive-mount-nautilus-git)](https://aur.archlinux.org/packages/archive-mount-nautilus-git), otherwise:

```
wget -qO- https://raw.githubusercontent.com/Lucas-Steinmann/archive-mount-nautilus/main/install.sh | bash
```

## Manual installation

- Ensure the packages providing `python-nautilus` and `gvfsd-archive` is installed.
    - `nautilus-python` and `gvfs-archive`for yum-based distros
    - `gvfs` and `python-nautilus` for arch-based distros
    - `gvfs-backends` and `python-nautilus` for debian-based distros
- Copy `archive-mount.py` from this repo to `~/.local/share/nautilus-python/extensions`.

## Uninstallation

```
rm ~/.local/share/nautilus-python/extensions/archive-mount.py
```
