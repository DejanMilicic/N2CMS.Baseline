N2CMS.Baseline

This is package that should make your life as a N2CMS developer easier. Idea is to
quickly set up new project and get you going.

How to use it?
Since initial installation of MVC project has many things that are not needed, this
package will install only core MVC assemblies and set up minimal configuration.
Just create empty MVC project in VS and install package

If you have any remarks, requests, ideas or suggestions, please do not hesitate
to email me at dejan.milicic@gmail.com


== Changelog ==

0.0.5
-----
Error 404 handler with Error404 page
Error 500 handler with Error500 page
Fetch library as a facade for standard opeations with content items

0.0.4
-----
SquishIt added

0.0.3
-----
Elmah added. Instead of using widely accepted package Elmah.MVC, I decided to go with 
just Elmah core package and to include configuration in web.config. No, I do not think
that _everything_ in MVC package should be MVC, hence no controller for Elmah, its own
handler is enought.
Elmah is accessible at /n2/elmah.axd
Placing it on /n2 path solves any security problems out of the box

0.0.2
-----
Bugfix release.
Routing was missing - added Global.asax with routing

0.0.1
-----
Initial release.
Bare bones configuration for N2CMS and for MVC