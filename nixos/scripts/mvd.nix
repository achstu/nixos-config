{ pkgs }:

pkgs.writeShellScriptBin "mvd" ''
  # Check if an argument is provided
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <dest>"
    exit 1
  fi

  DOWNLOADS="$HOME/downloads"
  # Assign the first argument as the destination path
  DEST="$1"

  # Find the newest file in the downloads folder
  SRC=$(ls -t $DOWNLOADS | head -n 1)

  # Check if there's a file in the downloads folder
  if [ -z "$SRC" ]; then
    echo "No files found in $DOWNLOADS"
    exit 1
  fi

  # Move the newest file to the specified destination
  mv "$DOWNLOADS/$SRC" "$DEST"

  # Confirm that the file was moved
  if [ $? -eq 0 ]; then
    echo "Moved $SRC to $DEST"
  else
    echo "Failed to move $SRC"
    exit 1
  fi

''
