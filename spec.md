# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
> All user interaction occurs through `RumbleBundle::CLI`, beginning with `#start`, looping through `#query`, and ending with `#quit`.

- [x] Pull data from an external source
> Except for the `@base_url` and `@main_pages` used as a starting point by `RumbleBundle::Scraper` (unpredictable sub-urls are fetched during scraping), all data comes from [the Humble Bundle website](http://humblebundle.com/).

- [x] Implement both list and detail views
> Once the site has been scraped, a list of all bundles on sale is presented; the user can then select a bundle to see a detailed view of its content.
> The user can also filter available products by entering a space-separated list of one or more tags such as `linux` or `drm-free`; search results are sorted by bundle.
