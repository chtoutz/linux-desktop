exec xrdb ~/.Xresources &
eval $(ssh-agent) &
feh --bg-scale ~/photos/wallpapers/current.jpg &
xbindkeys -p &
exec startxfce4
