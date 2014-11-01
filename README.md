# Open311 [![Build Status](https://secure.travis-ci.org/codeforamerica/open311.png)][travis]
A Ruby wrapper for the Open311 API v2.

[travis]: http://travis-ci.org/codeforamerica/open311

## Does your project or organization use this gem?
Add it to the [apps](https://github.com/codeforamerica/open311/wiki/apps) wiki!

## Installation
    gem install open311

## Documentation
[http://rdoc.info/gems/open311](http://rdoc.info/gems/open311)


## Usage Examples
    require 'open311'

    # Certain methods require an API key
    Open311.configure do |config|
      config.endpoint     = 'https://open311.sfgov.org/dev/v2/'
      config.api_key      = 'yourkeyforpostrequests'
      config.jurisdiction = 'sfgov.org'
    end

    # Provide a list of acceptable 311 service request types and their associated service codes
    Open311.service_list

    # If meta data is available, provide attributes and definition for the service code
    Open311.service_definition('033')

    # Grab service requests, limited to 90 days or 1000 entries
    Open311.service_requests

    # Grab a service request, requires ID
    Open311.get_service_request('12345')

    # Post a service request, requires an api key
    Open311.post_service_request

    # Get a service_request_id using a token after a post_service_request
    Open311.request_id('12345')

    # Get service requests with certain parameters (service_code, start_date, end_date, status)
    Open311.service_requests("status" => "opened")
    Open311.service_requests({"status" => "opened", "service_code"=>"broken-streetlight-report", "start_date" => "2010-03-12T03:19:52Z", "end_date" => "2010-03-14T03:19:52Z"})

    # Use Time.now
    require 'time'
    Open311.service_requests({"start_date" => (Time.now - 86400).xmlschema, "end_date" => Time.now.xmlschema}) // last 24 hours

    # Get multiple service requests by ids, comma separated
    Open311.service_requests({"service_request_id" => "101000119824,101000119823"})

## Contributing
In the spirit of [free software][free-sw], **everyone** is encouraged to help improve
this project.

[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up
  inconsistent whitespace)
* by refactoring code
* by fixing [issues][]
* by reviewing patches

[issues]: https://github.com/codeforamerica/open311/issues

## Submitting an Issue
We use the [GitHub issue tracker][issues] to track bugs and features. Before
submitting a bug report or feature request, check to make sure it hasn't
already been submitted. When submitting a bug report, please include a [Gist][]
that includes a stack trace and any details that may be necessary to reproduce
the bug, including your gem version, Ruby version, and operating system.
Ideally, a bug report should include a pull request with failing specs.

[gist]: https://gist.github.com/

## Submitting a Pull Request
1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Add specs for your unimplemented feature or bug fix.
4. Run `bundle exec rake spec`. If your specs pass, return to step 3.
5. Implement your feature or bug fix.
6. Run `bundle exec rake spec`. If your specs fail, return to step 5.
7. Run `open coverage/index.html`. If your changes are not completely covered
   by your tests, return to step 3.
8. Add documentation for your feature or bug fix.
9. Run `bundle exec rake yard`. If your changes are not 100% documented, go
   back to step 8.
10. Add, commit, and push your changes.
11. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## Supported Rubies
This library aims to support and is [tested
against](http://travis-ci.org/codeforamerica/open311) the following Ruby
implementations:

* Ruby 1.9.3
* Ruby 2.0.0
* Ruby 2.1
* [JRuby](http://www.jruby.org/)
* [Rubinius](http://rubini.us/)

If something doesn't work on one of these interpreters, it should be considered
a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be personally responsible for providing patches in a
timely fashion. If critical issues for a particular implementation exist at the
time of a major release, support for that Ruby version may be dropped.

## Copyright
Copyright (c) 2010 Code for America.
See [LICENSE](https://github.com/codeforamerica/open311/blob/master/LICENSE.md) for details.

[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/open311.png)](http://stats.codeforamerica.org/projects/open311)
