Consider this output from `nosetests`:

```python
$ nosetests
F.......
======================================================================
FAIL: test (failing_test.ClassWithTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/mambocab/py/nose-pasteable/test/failing_test.py", line 10, in test
    assert False
AssertionError

----------------------------------------------------------------------
Ran 8 tests in 0.009s

FAILED (failures=1)
```

How do you go about running just that failed test? Well, you copy and paste the test's name into your command prompt...

```python
$ nosetests test (failing_test.ClassWithTest)
zsh: invalid mode specification
$ # oh come on
```

No. No you don't. The way `nose` outputs tests names looks pretty good, but is not useful. This has bugged me ever since [@tenderlove](https://github.com/tenderlove) [pointed out his favorite feature](http://tenderlovemaking.com/2015/01/23/my-experience-with-minitest-and-rspec.html) of [`rspec`](http://rspec.info/): you can just copy and paste its output into the command line to rerun failing tests.

So, with `nose-pasteable`, the output you get is a little nicer. Enable it with the `--pasteable` option, or by setting `NOSE_PASTEABLE` to a non-empty string in the environment in which you run `nose`:

```python
$ nosetests --pasteable
F.......
======================================================================
FAIL: test/failing_test.py:ClassWithTest.test
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/mambocab/py/nose-pasteable/test/failing_test.py", line 10, in test
    assert False
AssertionError

----------------------------------------------------------------------
Ran 8 tests in 0.009s

FAILED (failures=1)
$ # copy and paste that thing from up there...
$ nosetests test/failing_test.py:ClassWithTest.test
F
======================================================================
FAIL: test (failing_test.ClassWithTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/mambocab/py/nose-pasteable/test/failing_test.py", line 10, in test
    assert False
AssertionError

----------------------------------------------------------------------
Ran 1 test in 0.000s

FAILED (failures=1)
```

Heck yes. One little annoyance gone.

## Installation

Easy: use `pip install nose-pasteable`. Slightly harder: clone this repo, then use `pip install .` from inside it.

## Development

Clone this repository, then create a branch in a repository you control. GitHub is most convenient for me, but I don't judge. GitLab is awesome, and BitBucket is pretty cool too. Go for it! I accept patches!

Do your development on that branch, adding tests in [`test_script.sh`](test_script.sh) as you go. To run the tests, install [bats](https://github.com/sstephenson/bats) by [following the instructions there](https://github.com/sstephenson/bats#installing-bats-from-source). Then, from the top-level directory of this repository, run `./test_script.sh`. All existing tests should pass, and any new features should at least have a smoke test and a test that makes sure they don't run when they're disabled.

Then, let me know about the changes, either through a pull request or a link in an issue.
