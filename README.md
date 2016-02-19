# Business Map
Business Map is a simple web app that hits an API and displays the results on a map. The API provides a list of businesses as well as an end-point for an individual business's details.

### Deprecation Warning
The API is no longer available. However, this project is still a good example of how to parse JSON in Ruby and display it nicely in a Bootstrapped Rails application.

### Where to Look
* `base_controller.rb` houses the parsing logic and builds the map's display object. This functionality should be placed in a class in effort to keep a thin controller but for demonstration, it lives in the controller.
* `business.rb` is a simple business object that is not database persistent (ie. `ActiveModel` not `ActiveRecord`). It is used to provide rails-like handling and functionality to a representation of a business record coming from the API.
* `views/base/index.html` a HAML generated landing page.
* `base.coffee` a coffeescripted JS file that handles loading the business details modal and generating the map points.
