#!/usr/bin/env python
# -*- coding: utf-8 -*-
# __date__ = 'Mar 29, 2020'
# __author__ = 'samuel'
# from selenium import webdriver
from seleniumrequests import Firefox
#from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from xvfbwrapper import Xvfb
URL='https://tw.yahoo.com'


def main():
    with Xvfb(width=1280, height=2000):
        # driver = webdriver.Firefox(executable_path='/usr/local/bin/geckodriver')
        # driver = webdriver.Firefox()
        # firefox_capabilities = DesiredCapabilities.FIREFOX
        # firefox_capabilities['marionette'] = False
        driver = Firefox()
        # driver = webdriver.Firefox(executable_path='/usr/local/bin/geckodriver')
        driver.get(URL)
        driver.save_screenshot('screenshot.png')
        driver.quit()


if __name__ == '__main__':
    main()
