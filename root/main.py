from webdriver_util import init


def query_google(keywords):
    print("Loading Firefox driver...")
    driver, waiter, selector, datapath = init()

    print("Fetching google front page...")
    driver.get("http://google.com")

    print("Taking a screenshot...")
    waiter.shoot("frontpage")

    print("Typing query string...")
    selector.get_and_clear("input[type=text]").send_keys(keywords)

    print("Hitting Enter...")
    selector.get("input[type=submit]").click()

    print("Waiting for results to come back...")
    waiter.until_display("#ires")

    print
    print("The top search result is:")
    print
    print('    "{}"'.format(selector.get("#ires a").text))
    print


if __name__ == '__main__':
    query_google('test')
