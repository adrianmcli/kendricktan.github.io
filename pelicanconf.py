#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = 'Kendrick Tan'
SITENAME = "Kendrick's Blog"
SITEURL = '//kendricktan.github.io'

PATH = 'content'

TIMEZONE = 'Australia/Brisbane'

DEFAULT_LANG = 'en'

# Extra
STATIC_PATHS = [
    'extra/favicon.ico'
]

EXTRA_PATH_METADATA = {
    'extra/favicon.ico': {'path': 'favicon.ico'}
}

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (('portfolio', '//goo.gl/hU5G97'),)

# Social widget
SOCIAL = (('github', '//github.com/kendricktan'),
        ('linkedin', '//au.linkedin.com/in/tankendrick'),
        ('twitter', '//twitter.com/kendricktrh'),
        ('medium', '//medium.com/@kendricktan0814'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True
GITHUB_URL = '//github.com/kendricktan/'

# Theme
THEME = "Flex"

# SIDEBAR
SITETITLE = u'Kendrick Tan'
SITESUBTITLE = u'Machine Learning | Full Stack'
SITELOGO = u'//i.imgur.com/WCKPhvf.png'

COPYRIGHT_YEAR = 2016
