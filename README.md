# Opensearch suggestions explained

Opensearch is an old spec for how browsers and search engines should talk about search queries, including search suggestions. 

The spec is hosted here: https://github.com/dewitt/opensearch

We are only interested in the "Suggestions" part: https://github.com/dewitt/opensearch/blob/master/mediawiki/Specifications/OpenSearch/Extensions/Suggestions/1.1/Draft%201.wiki

Spec tells us that a suggestion is a list of 4 items. Modern browsers however add a 5th item to add more info about suggest results, e.g. rich data (show images or title along the completion) or suggest ranking factors (so the browser can sort completions in a certain way).

Chrome is the trend-setter here: see their format in [tests_explained/google_chromium.jsonc](tests_explained/google_chromium.jsonc). Firefox simply tries to use whatever it can get from google, as far as I can tell

Safari's suggest is very plain: it can only show us text and url completions. I won't add any info on Safari, but PRs are welcome

Check [tests_explained](tests_explained) for some details on different formats or run `sh tests.sh` to fetch suggest endpoints yourselves 


## Google suggest
Universal endpoint: `https://www.google.ru/complete/search`. All kind of suggestion clients go here: main page, search results page, chrome, firefox, and probably many more.


### Google for firefox
Firefox doesn't support links in search engine suggests: they are [intentionally filtered](https://searchfox.org/mozilla-central/source/browser/components/urlbar/UrlbarProviderSearchSuggestions.sys.mjs#476)
Google won't return any links for firefox

```
curl 'https://www.google.ru/complete/search?client=firefox&channel=fen&q=alfon'
```
* `channel` is reverse engineered from:
    * https://searchfox.org/mozilla-central/source/browser/app/profile/firefox.js#466
    * https://searchfox.org/mozilla-central/source/services/settings/dumps/main/search-config-v2.json#2418

Format explained in [tests_explained/google_firefox.jsonc](tests_explained/google_firefox.jsonc)

### Google for chromium
```
curl "https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext-ansg&q=alfon" \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0'
```

* full url is taken from `chrome://suggest-internals/`
* user agent is important: it enables rich formats (mainly google:entityinfo)

Format explained in [tests_explained/google_chromium.jsonc](tests_explained/google_chromium.jsonc)

### Yandex for Yandex.browser

```
curl 'https://yandex.ru/suggest/suggest-browser?part=gosusl&brandID=yandex&rich=1&srv=browser_desktop&rich_nav=1'
```