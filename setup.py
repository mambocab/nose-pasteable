from setuptools import setup, find_packages

setup(
    name='Nose-Pasteable',
    version='0.1',
    packages=find_packages(),

    entry_points={
        'nose.plugins': ['pasteable = pasteable.pasteable:Pasteable']
    },
    install_requires=['nose'],
    test_suite='test'
)
