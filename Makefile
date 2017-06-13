all: dist

clean:
	rm -rf dist build *.egg-info test_reports .coverage
	rm -f *.log
	find . | grep \.pyc$ | xargs rm -rf
	find . | grep __pycache__ | xargs rm -rf

dist: clean
	python setup.py bdist_wheel --universal

test_release: dist
	twine upload -r pypitest dist/*

release: dist
	twine upload -r pypi dist/*

test:
	nosetests-3.4  --with-coverage --cover-package=mockidp --cover-min-percentage=80 --cover-html --cover-html-dir=build/test_reports

.PHONY: all clean dist lint test