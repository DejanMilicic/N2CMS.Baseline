
0.1.0
=====
Features
----
* Nuget dependecies specification changed so that last version of each is used
* Mail settings introduced, different one for local developments and for release configuration
* httpruntime maximum file upload size and execution timeout
* WOFF mime type added
* Abstract base controller for all N2CMS pagetype controllers
* Refactoring folder structure for views

0.0.5
=====
Features
----
* Error 404 handler with Error404 page
* Error 500 handler with Error500 page
* Fetch library as a facade for standard opeations with content items

0.0.4
====
Features
----
* SquishIt added

0.0.3
====
Features
----
* Elmah added. Instead of using widely accepted package Elmah.MVC, I decided to go with 
just Elmah core package and to include configuration in web.config. No, I do not think
that _everything_ in MVC package should be MVC, hence no controller for Elmah, its own
handler is enought.
Elmah is accessible at /n2/elmah.axd
Placing it on /n2 path solves any security problems out of the box

0.0.2 - Bugfix release
====
Bugs
----
* Routing was missing - added Global.asax with routing

0.0.1 - Initial release
====
Features
----
* Bare bones configuration for N2CMS and for MVC