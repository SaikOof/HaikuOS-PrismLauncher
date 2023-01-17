# HaikuOS-PrismLauncher
The minecraft launcher ported to the Haiku Operating System.
# How does it works?
Remember to first read both scripts and "chmod +x" them.
Both scripts must be runned from a terminal emulator.
-builder.sh is for installing all the dependencies, cloning for the first time the official PrismLauncher repository, patching its files and building it.
-updater.sh is for removing previously patched file, pulling the repository and building it. 
# Why not using MultiMC?
MultiMC can't be builded with the API keys, PrismLauncher is one of the most popular fork of MultiMC that also allows building with API keys so you can log to your microsoft account.
