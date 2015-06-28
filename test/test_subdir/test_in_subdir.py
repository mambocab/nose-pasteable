from unittest import TestCase


def test_function_in_subdir():
    assert True


class TestClassInSubdir(TestCase):
    def test_method_in_subdir(self):
        assert True
