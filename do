#!/bin/sh
set -euo pipefail

# A general script to run aliased commands
# Taken loosely from https://gist.github.com/waylan/4080362

PROGRAM_NAME=$(basename "${0}")

sub_help() {
  echo "Usage: ${PROGRAM_NAME} <subcommand>"
  echo "Subcommands:"
  echo "    setup         Apply data model migrations to DB"
  echo "    dumpdata      Dump current DB data to a JSON flat file"
  echo ""
}

sub_setup() {
  echo "Setting up DB"
  echo "Detecting data model changes"
  python manage.py makemigrations authentication
  python manage.py makemigrations backend
  python manage.py makemigrations
  echo "Applying any data model changes"
  python manage.py migrate
}

sub_dumpdata() {
  echo "Dumping DB data to datadump.json"
  python manage.py dumpdata -o datadump.json
}

subcommand="${1:-}"
case $subcommand in
"" | "-h" | "--help")
  sub_help
  ;;
*)
  shift
  "sub_${subcommand}" "$@"
  if [ "${?}" = 127 ]; then
    echo "Error: '$subcommand' is not a known subcommand." >&2
    echo "       Run '${PROGRAM_NAME} --help' for a list of known subcommands." >&2
    exit 1
  fi
  ;;
esac
