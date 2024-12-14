curl 'https://www.google.ru/complete/search?client=firefox&channel=fen&q=alfon' \
| iconv -f windows-1251 -t UTF-8 \
| jq . \
> tests/google_firefox.json

curl "https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext-ansg&q=alfon" \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0' \
| jq . \
> tests/google_chromium.json

curl "https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext-ansg&q=facebook" \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0' \
| jq . \
> tests/google_chromium_link.json

curl "https://www.google.com/complete/search?client=chrome-omni&gs_ri=chrome-ext-ansg&q=1%2B77" \
    -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0' \
| jq . \
> tests/google_chromium_calculator.json


# this also needs a cookie header for rich suggest, omitting for security reasons
# -H "Cookie: ..."
curl "https://yandex.ru/suggest/suggest-browser?part=gosusl&brandID=yandex&rich=1&srv=browser_desktop&rich_nav=1" \
  | jq . \
> tests/yandex_yabro.json
