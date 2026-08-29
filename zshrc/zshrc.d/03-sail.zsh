function sail() {
    local sail_cmd=$([ -f sail ] && echo sail || echo vendor/bin/sail)

    case "$1" in
        optimize)
            sh $sail_cmd artisan optimize:clear
            sh $sail_cmd artisan optimize
            ;;

        migrate)
            shift
            sh $sail_cmd artisan migrate "$@"
            ;;

        fresh)
            shift

            if [[ "$1" == "seed" ]]; then
                shift
                sh $sail_cmd artisan migrate:fresh --seed "$@"
            else
                sh $sail_cmd artisan migrate:fresh "$@"
            fi
            ;;

        seed)
            shift
            sh $sail_cmd artisan db:seed "$@"
            ;;

        up)
            shift

            if [[ "$1" == "d" ]]; then
                shift

                if [[ "$1" == "build" ]]; then
                    shift
                    sh $sail_cmd up -d --build "$@"
                else
                    sh $sail_cmd up -d "$@"
                fi
            else
                sh $sail_cmd up "$@"
            fi
            ;;

        *)
            sh $sail_cmd "$@"
            ;;
    esac
}

migrate() {
  if [[ "$1" == "fresh" ]]; then
    shift
    php artisan migrate:fresh "$@"
  else
    php artisan migrate "$@"
  fi
}