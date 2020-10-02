# In .bashrc and .profile
# export PYTHONSTARTUP="$HOME/.pythonrc.py"
# To prevent build\version info showing at launch: python -i -q
# In Windows OS copy pythonrc.py in %USERPROFILE%

import os
import sys

# Colorize the standard Python prompt
CSI = "\x1B["
reset = CSI + "0m"

sys.ps1 = CSI + "32;40m>" + CSI + "33;40m>" + CSI + "31;40m> " + reset
sys.ps2 = CSI + "31;40m<" + CSI + "33;40m<" + CSI + "32;40m<" + CSI + "37;40m..." + reset

# Shorten the default build information and show present working directory
print('Python {0} on {1}'.format(".".join(str(x) for x in sys.version_info[:3]), sys.platform))
print(os.path.expanduser('~'))

# The clear screen function that will move the cursor to the (very) top of the screen and not display a "0"
clear = lambda: sys.stderr.write("\x1b[2J\x1b[H")
