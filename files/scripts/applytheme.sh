#!/bin/bash
if [ ! -f "$HOME/.config/strata-theme-applied" ]; then
    # Apply Plasma Global Theme and Kvantum Aero styling
    plasma-apply-lookandfeel -a "com.github.aerotheme.desktop" 2>/dev/null
    kvantummanager --set "Windows-7" 2>/dev/null
    
    # Reload KWin and Plasma shell live
    kquitapp6 plasmashell && kstart plasmashell &
    qdbus6 org.kde.KWin /KWin reconfigure
    
    # Mark as completed
    touch "$HOME/.config/strata-theme-applied"
fi
