Open311
=======
A Ruby wrapper for the Open311 API v2.

Does your project or organization use this gem?
------------------------------------------
Add it to the [apps](https://github.com/codeforamerica/open311/wiki/apps) wiki!

Installation
------------
    gem install open311

Documentation
-------------
[http://rdoc.info/gems/open311](http://rdoc.info/gems/open311)

Continuous Integration
----------------------
[![Build Status](http://travis-ci.org/codeforamerica/open311.png)](http://travis-ci.org/codeforamerica/open311)

Usage Examples
--------------
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

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](https://github.com/codeforamerica/open311/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue tracker](https://github.com/codeforamerica/open311/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](https://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

Copyright
---------
Copyright (c) 2010 Code for America Laboratories
See [LICENSE](https://github.com/codeforamerica/open311/blob/master/LICENSE.md) for details.
