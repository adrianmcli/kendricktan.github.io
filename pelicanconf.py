#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

import os


AUTHOR = 'Kendrick Tan'
SITENAME = "Kendrick's Blog"
SITEURL = '//kendricktan.github.io'

PATH = 'content'
PLUGIN_PATHS = os.path.join("./", "plugins")
PLUGINS = ['assets']

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
MANGLE_EMAILS = True
FUZZY_DATES = False

# Blogroll
LINKS = (('home', SITEURL),
         ('about', '/pages/about.html'),
         ('archives', '/archives.html'),
         ('contact', '/pages/contact.html'),
         ('portfolio', '//goo.gl/hU5G97'))

TAGS_URL = 'tags.html'
ARCHIVES_URL = 'archives.html'

# Social widget
SOCIAL = (('Github', '//github.com/kendricktan'),
          ('Linkedin', '//au.linkedin.com/in/tankendrick'),
          ('Medium', '//medium.com/@kendricktan0814'),
          ('Twitter', '//twitter.com/kendricktrh'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
RELATIVE_URLS = True
GITHUB_URL = '//github.com/kendricktan/'

# Theme
THEME = "voce"

# SIDEBAR
SITETITLE = u'Kendrick Tan'
SITESUBTITLE = u'I organize matricies so it identifies cat pictures'

COPYRIGHT_YEAR = 2017
