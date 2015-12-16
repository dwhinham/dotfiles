function bat
	upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -E "state|time\ to\ full|time\ to\ empty|percentage"
end
