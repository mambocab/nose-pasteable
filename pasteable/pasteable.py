from __future__ import print_function
from nose.plugins import Plugin
import logging


log = logging.getLogger('nose.plugins.pasteable')
log.addHandler(logging.FileHandler('pasteable.log'))

log.error('initializing class')


class Pasteable(Plugin):
    """
    Generates output about failing test cases in the same format as the input to
    specify which test cases to run.
    """
    def options(self, parser, env):
        parser.add_option(
            '--pasteable',
            action='store_true',
            default=env.get('NOSE_PASTEABLE'),
            dest='pasteable')

    def configure(self, options, conf):
        self.enabled = options.pasteable
        self.conf = conf

    def formatFailure(self, test, err):
        log.error(err)
        return tuple(x + 'lol: {}'.format(i) for i, x in enumerate(err))

    def finalize(self, result):
        log.error('heyo!')
