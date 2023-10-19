#!/bin/sh

# Author:   PraxosTech
# Date:     2023-10-19

# Test if needed binaries are installed
if [ -z "$(command -v pgrep)" ]; then
    echo "ERROR: command 'pgrep' is not available"
    exit 1
fi

if [ -z "$(command -v pkill)" ]; then
    echo "ERROR: command 'pkill' is not available"
    exit 1
fi

if [ -z "$(command -v dirname)" ]; then
    echo "ERROR: command 'dirname' is not available"
    exit 1
fi

# process script arguments
winebin=$1
prefix=$2

if [ -n "$3" ]; then
    pvz_exe_path="$3"
else
    pvz_exe_path="$prefix/drive_c/Program Files (x86)/PopCap Games/Plants vs. Zombies/PlantsVsZombies.exe"
fi

if [ -z "$winebin" ] || ! [ -e "$winebin" ]; then
    echo "ERROR: wine-binary could not be found"
    exit 1
fi

if [ -z "$prefix" ] || ! [ -e "$prefix" ]; then
    echo "ERROR: prefix could not be found"
    exit 1
fi

# Test if the PVZ Exe exists
if ! [ -e "$pvz_exe_path" ]; then
    echo "ERROR: PVZ-Exe could not be found"
    exit 1
fi

# Start PVZ
(WINEPREFIX="$prefix" "$winebin" "$pvz_exe_path" > /dev/null 2>&1 &) 

# Wait until 'popcapgame1.exe' is running
i=0
while [ -z "$(pgrep -f 'popcapgame1.exe')" ] && [ "$i" -lt "100" ]; do
    sleep 0.1
    i=$((i+1))
done

# Print error and exit if an error occured
if [ "$i" = "100" ]; then
    echo "ERROR: Failed to start PVZ"
    exit 1
fi

# Copy EXE from "ProgramData" to the PVZ directory
cp "$prefix/drive_c/ProgramData/PopCap Games/PlantsVsZombies/popcapgame1.exe" "$(dirname "$pvz_exe_path")/"

# Rename original PVZ exe
mv "$pvz_exe_path" "$(dirname "$pvz_exe_path")/PlantsVsZombies.exe.bak"

# Rename 
mv "$prefix/drive_c/Program Files (x86)/PopCap Games/Plants vs. Zombies/popcapgame1.exe" "$pvz_exe_path"

# Kill the PVZ processes
pkill 'PlantsVsZombies.exe'
pkill 'popcapgame1.exe'

exit 0