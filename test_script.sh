#!/usr/bin/env bats

function grep_passed_tests() {
  grep '\.\.\. ok'
}
function num_passed_tests() {
  grep_passed_tests | wc -l
}

@test 'nosetests with the plugin loaded but disabled discovers the tests' {
  [ `nosetests --collect-only --verbosity=2 2>&1 | grep_passed_tests | wc -l` -eq 6 ]
}

@test 'discovers the same tests, with different names, with pasteable enabled via env var' {
  before_results=`NOSE_PASTEABLE='' nosetests --collect-only --verbosity=2 2>&1`
  after_results=`NOSE_PASTEABLE='true' nosetests --collect-only --verbosity=2 2>&1`

  [ `echo "$before_results" | num_passed_tests` -eq `echo "$after_results" | num_passed_tests` ]
  [ "`echo $before_results`" != "`echo $after_results`" ]
}

@test 'output when enabled via --pasteable is the same as with env var' {
  before_results=`NOSE_PASTEABLE='' nosetests --collect-only --pasteable --verbosity=2 2>&1`
  after_results=`NOSE_PASTEABLE='true' nosetests --collect-only --verbosity=2 2>&1`
  before_results="`echo "$before_results" | grep_passed_tests`"
  after_results="`echo "$after_results" | grep_passed_tests`"

  [ "$before_results" == "$after_results" ]
}

@test 'test names generated can be used to run tests via nosetests' {
  valid_tests=`
    nosetests --collect-only --verbosity=2 --pasteable 2>&1 |
    grep_passed_tests |
    awk '{print $1}'
  `
  for test_name in `echo "$valid_tests"`; do
    echo "testing $test_name" 2>&1
    [ `nosetests $test_name --verbosity=2 2>&1 | num_passed_tests` == 1 ]
  done
}

@test "nosetests doesn't fall over when given an incorrect test spec" {
  [[ "`nosetests tests/test_file.py:NonExistentTestClass.nope_test 2>&1`" =~ "No module named" ]]
}
