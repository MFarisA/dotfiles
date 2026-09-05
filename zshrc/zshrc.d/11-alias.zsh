py() {
  if [ -f ./py ]; then
    ./py "$@"
  else
    python3 "$@"
  fi
}


