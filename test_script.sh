#!/usr/bin/env sh

indent_level=0
tab_width=2
failures=''

# first, the world's silliest rspec-style test "framework"
function indent() {
  case "$1" in
    up)    indent_level=$(($indent_level + 1)) ;;
    down)  indent_level=$(($indent_level - 1)) ;;
    *)     exit 1
  esac
}
function report() {
  indent_string=$(
    python -c "from __future__ import print_function ; print(' ' * ($indent_level * $tab_width))"
  )
  printf "$@" | sed -e "s/^/$indent_string/"
}
function context() {
  report "$1\n"
  indent up
}
function end_context() {
  indent down
}
function it() {
  report "$1 ... "
  test_command="${@:2}"
  if [ $test_command ] ; then
    echo "\033[1;32mok\033[0m"
  else
    echo "\033[31mfailed\033[0m"
    indent up
    report "(evaluated \`$test_command\`)\n"
    indent down
  fi
}

context 'nosetests without pasteable'
  before_results=`NOSE_PASTEABLE='' nosetests --collect-only --verbosity=2 2>&1`
  it 'discovers the correct number of tests' `echo "$before_results" | grep '\.\.\. ok' | wc -l` -eq 6
end_context

context 'NOSE_PASTEABLE environment variable'
  before_results=`NOSE_PASTEABLE='' nosetests --collect-only --verbosity=2 2>&1`
  after_results=`NOSE_PASTEABLE='true' nosetests --collect-only --verbosity=2 2>&1`

  it 'discovers the same number of tests' `echo "$before_results" | wc -l` -eq `echo "$after_results" | wc -l`
  it 'produces a different result' "'$before_results'" = "'$after_results'"
end_context
