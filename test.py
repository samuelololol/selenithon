#!/usr/bin/env python
# -*- coding: utf-8 -*-
__date__ = 'Nov 17, 2017 '
__author__ = 'samuel'

from selenium import webdriver
from xvfbwrapper import Xvfb


def main():
    with Xvfb(width=1280, height=2000):
        driver = webdriver.Firefox()
        driver.get('https://tw.yahoo.com')
        driver.save_screenshot('screenshot.png')
        driver.quit()


if __name__ == '__main__':
    main()
