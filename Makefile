install-packages:
	cd pkg && sudo ./install-official-packages.sh
	# cd pkg && sudo ./install-official-packages.sh && ./install-aur-packages.sh

configure:
	cd pkg && sudo ./configure-system.sh
	# cd pkg && sudo ./configure-system.sh && ./configure-user.sh

update:
	cd pkg && ./update-config.sh

install-wm:
	cd dwm && $(MAKE) install
	cd dwmblocks && $(MAKE) install

install-term:
	# clean is important to ensure ~/.terminfo
	# is updated on system
	cd st && $(MAKE) clean install
