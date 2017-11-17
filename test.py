#!/usr/bin/env python
# -*- coding: utf-8 -*-
# __date__ = 'Nov 17, 2017 '
# __author__ = 'samuel'
from selenium import webdriver
from seleniumrequests import Firefox
from xvfbwrapper import Xvfb


def main():
    with Xvfb(width=1280, height=2000):
        # driver = webdriver.Firefox(executable_path='/usr/local/bin/geckodriver')
        # driver = webdriver.Firefox()
        driver = Firefox()
        driver.get('https://tw.yahoo.com')
        driver.save_screenshot('screenshot.png')
        driver.quit()


if __name__ == '__main__':
    main()
