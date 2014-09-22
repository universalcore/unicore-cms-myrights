from setuptools import setup, find_packages

requires = [
    'pyramid',
    'unicore-cms',
]

setup(name='unicore-cms-ebola',
      version='0.1',
      description='Ebola Pyramid Frontend Site for Universal Core ',
      long_description='Ebola Pyramid Frontend Site for Universal Core ',
      classifiers=[
      "Programming Language :: Python",
      "Framework :: Pyramid",
      "Topic :: Internet :: WWW/HTTP",
      "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
      ],
      author='Praekelt Foundation',
      author_email='dev@praekelt.com',
      url='http://github.com/universalcore/unicore-cms-ebola',
      license='BSD',
      keywords='web pyramid pylons',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      install_requires=requires,
      tests_require=requires,
      test_suite="unicorecmsebola",
      entry_points="""\
      [paste.app_factory]
      main = unicorecmsebola:main
      """,
      )
