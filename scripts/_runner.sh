#!/usr/bin/env bash
# Usage: _runner.sh <script> <repo_dir> <exit_file>
clear
script="$1"
repo_dir="$2"
exit_file="$3"

bash "$script" "$repo_dir"
rc=$?
echo $rc > "$exit_file"
[ $rc -eq 0 ] && exit
