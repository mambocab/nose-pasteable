from setuptools import setup, find_packages

setup(
    name='nose-pasteable',
    version='0.1',
    packages=find_packages(),
    author='Jim Witschey',
    author_email='jim.witschey@gmail.com',
    url='https://github.com/mambocab/nose-pasteable',
    license='MIT',
    entry_points={
        'nose.plugins': ['pasteable = pasteable.pasteable:Pasteable']
    },
    install_requires=['nose'],
    test_suite='test'
)
