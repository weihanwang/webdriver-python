from sys import argv, stderr
from webdriver_util import init


def query_google(keywords, screenshot_dir):
    print "Loading Firefox driver..."
    driver, waiter, selector = init(screenshot_dir)

    print "Fetching google front page..."
    driver.get("http://google.com")

    print "Taking a screenshot..."
    waiter.shoot("frontpage")

    print "Typing query string..."
    selector.get_and_clear("input[type=text]").send_keys(keywords)

    print "Hitting Enter..."
    selector.get("button").click()

    print "Waiting for results to come back..."
    waiter.until_display("#ires")

    print
    print "The top search result is:"
    print
    print '    "{}"'.format(selector.get("#ires a").text)
    print


def main():
    screenshot_dir = '/shots'

    if len(argv) > 2:
        print >>stderr, "Usage: {} [screenshot-output-dir]".format(argv[0])
        print >>stderr, "The default screenshot output dir is {}".format(screenshot_dir)
        exit(11)
    elif len(argv) == 2:
        screenshot_dir = argv[1]

    query_google('test', screenshot_dir)


if __name__ == '__main__':
    main()