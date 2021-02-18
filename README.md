# linux-desktop

This repository contains chtoutz's
configuration for his daily driver.

Forked from https://github.com/octetz/linux-desktop

## Commands

To update this repo's contents based on the local system, run:

```
make update
```

Install all packages (via AUR & official repos):

```
make install-packages
```

To configure the machine:

```
make configure
```

dwm compilation/install:

```
sudo make install-wm
```

st compilation/install:

```
sudo make install-term
```

## Runtime details

This section contains notes about ensuring specific applications run well.

### Zoom

#### Black screen during screen sharing

When sharing screens against an X window system, a compositor is required or
else your screen will go black while sharing.

zoom support page:
https://support.zoom.us/hc/en-us/articles/202082128-Black-Screen-During-Screen-Sharing

While zoom recommends xcompmgr, picom (previously compton) is a more modern
solution. ref: https://www.reddit.com/r/linuxquestions/comments/89ibgy/compton_vs_xcompmgr

### OBS

#### Linux-Browser Plugin

For linux browser to work (often used to host a chat window) you need the
dependencies that come along with
[obs-linuxbrowser](https://aur.archlinux.org/packages/obs-linuxbrowser/).
Otherwise a window may not show up.

### Making Grub Font Readable

To set a custom font and size, create a grub-compatible font.

```
grub-mkfont -s 60 -o /boot/grubfont.pf2 /usr/share/fonts/TTF/Hack-Regular.ttf
```

Then add the following in `/etc/default/grub`.

```
GRUB_FONT="/boot/grubfont.pf2"
```

Regenerate the grub config.

```
grub-mkconfig -o /boot/grub/grub.cfg
```
