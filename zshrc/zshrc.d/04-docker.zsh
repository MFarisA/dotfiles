# Docker wrapper: pintasan compose di docker/docker-compose.yml.
unalias docker 2>/dev/null
docker() {
  if [[ "$1" == "up" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml up -d --build "$@"

  elif [[ "$1" == "down" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml down "$@"

  elif [[ "$1" == "restart" ]]; then
    shift
    command docker compose -f docker/docker-compose.yml restart "$@"

  else
    command docker "$@"
  fi
}