from sys import argv, stderr
from webdriver_util import init


def query_google(keywords, screenshot_dir):
    print "Loading Firefox driver..."
    driver, waiter, selector = init(screenshot_dir)

    print "Fetching google front page..."
    driver.get("http://google.com")

    print "Typing query string..."
    selector.get_and_clear("#gbqfq").send_keys(keywords)

    print "Hitting Enter..."
    selector.get("#gbqfb").click()

    print "Waiting for results to come back..."
    waiter.until_display("#ires")

    print "Taking a screen shot..."
    waiter.shoot("end")


if len(argv) > 2:
    print >>stderr, "Usage: {} [screenshot-output-dir]".format(argv[0])
    print >>stderr, "The default screenshot output dir is /"
    exit(11)

query_google('test', argv[1] if len(argv) == 2 else '/')
