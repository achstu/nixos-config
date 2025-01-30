{ pkgs }:

pkgs.writeShellScriptBin "mvd" ''
  # Check if an argument is provided
  if [ $# -ne 1 ]; then
    echo "usage: $0 <dest>"
    exit 1
  fi

  DOWNLOADS="$HOME/downloads"
  DEST="$1"

  SRC=$(ls -t $DOWNLOADS | head -n 1)

  if [ -z "$SRC" ]; then
    echo "$0: $DOWNLOADS is empty"
    exit 1
  fi

  mv "$DOWNLOADS/$SRC" "$DEST"

  if [ $? -eq 0 ]; then
    echo "$0: moved $SRC to $DEST"
  else
    echo "$0: failed to move $SRC"
    exit 1
  fi

''
