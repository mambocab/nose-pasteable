from __future__ import print_function
from nose.plugins import Plugin
from os.path import relpath
from os import getcwd


class Pasteable(Plugin):
    """
    Generates output about failing test cases in the same format as test
    specifiers for the nosetests command. In other words:
    """
    enabled = False
    env_opt = 'NOSE_PASTEABLE'

    def options(self, parser, env):
        super(Pasteable, self).configure(parser, env)

        parser.set_defaults(pasteable=env.get(self.env_opt, False))
        pasteable_help = ('Generate reports with test name specifiers that '
                          'you can paste back as nosetests input to rerun '
                          'tests. '
                          '[{env_opt}]'.format(env_opt=self.env_opt))
        parser.add_option('--pasteable',
                          dest='pasteable',
                          action='store_true',
                          help=pasteable_help)
        no_pasteable_help = ('Override the {env_opt} environment '
                             'variable.'.format(env_opt=self.env_opt))
        parser.add_option('--no-pasteable',
                          dest='pasteable',
                          action='store_false',
                          help=no_pasteable_help)

    def configure(self, options, conf):
        super(Pasteable, self).configure(options, conf)
        self.enabled = options.pasteable

    def testName(self, test):
        try:
            test_file_absolute_path, _, test_object = test.address()
            test_file_relative_path = relpath(test_file_absolute_path,
                                              getcwd())
            return '{f}:{o}'.format(f=test_file_relative_path, o=test_object)
        # except on everything so names operate normally if there are errors
        except:
            return

    # work even when nose decides to use describeTest
    describeTest = testName
