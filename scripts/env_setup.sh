#!/usr/bin/env bash

if ! grep -q "^setfont ter-132n$" ~/.bashrc; then
    printf '\nsetfont ter-132n\n' >>~/.bashrc
    echo "Font setting added to .bashrc"
else
    echo "Font setting already exists in .bashrc, no changes made"
fi
