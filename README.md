# webdriver-python

This is a Docker container combined with a few utility functions to simplify writing Selenium tests in Python. 
It uses Firefox as the driver. [Dockerfile](https://github.com/weihanwang/webdriver-python/blob/master/Dockerfile).

## Run example code

The example test querys the keyword "test" at google.com and print the first search result to stdout:

    $ docker run aerofs/webdriver-python

To export screenshots to the ./shots folder on the host computer:

    $ docker run -v $PWD/shots:/shots aerofs/webdriver-python

## Write tests

Check out [this document](http://selenium-python.readthedocs.org/en/latest/) for Selenium's concepts and operations.

To write new tests, you can either bind mount your python files to the container or create a new Docker image and copy files into the image.
The example code is located at `/example.py` in the container. You may overwrite this file or place your files at different locations. For the latter,
run the container as follows:

    $ docker run aerofs/webdriver-python python -u /path/to/your/python/code

At the beginning of your code, call webdriver_util.init() to set up the environment and retrieve a few utility objects:

    from webdriver_util import init
    driver, waiter, selector = init('/shots')

`driver` is the Selenium WebDriver object

`waiter` is a convenience wrapper around WebDriverWait. Every call to its `until*()` methods produce useful console output and a screenshot at the end of the wait.
You can also use `waiter.shoot()` at any time to save a screenshot to the screenshot folder specified by the `init()` call.

`selector` provides shortcuts to `WebDriver.find_element_by_css_selector()`. It restrict element selection to using CSS selectors only.
 
See [example code](https://github.com/weihanwang/webdriver-python/tree/master/root/example.py) for usage of these objects.


## Build from source

Check out [this GitHub repository](https://github.com/weihanwang/webdriver-python) and run this command in the repository's root folder:

    $ docker build -t aerofs/webdriver-python .




