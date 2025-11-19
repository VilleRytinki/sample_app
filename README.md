# Ruby on Rails tutorial sample application

This is the sample application for Ruby on Rails tutorial 7th edition.
This project showcases my ability to develop and test web apps.

The sample application in the tutorial is built with Rails 7 and SQLite3 database and is deployed with Heroku.

However I chose to use:
Framework: Rails 8
Database: Postgresql
Front-End: Bootstrap
CI: Github
Deployment: Render

# Problems I faced and solved
- How to use Bootstrap with Rails 8 as it is different from Rails 7.
- How to use postgresql with Rails 8.
- Using Github as CI platform.
- Using Render as my production pipeline.

I also faced challenges in setting development environment as the book uses Web based text editor that is not available anymore,
so I decided to use VSCode. The problems mainly were about Ruby Language server and getting rubocop(linter) to work.
Development is done on WSL.

Responsive design in the book was done with JS. I chose to use Bootstrap all the way, so I had to find the corresponding behavior in Bootstrap documentation.

# Features
This section gets updated as the project matures.
Bootstrap for Front-End.
Single page application with home, help, contact and about page.
- Fully functional login and authentication system with users having the ability to login and logout of the app via user session control.
- Implements session hijacking prevention techniques via reset session when redirecting or when user logs in.
- Error handling for invalid signup/login with error messages via flash.
- Responsive design using Bootstrap ex. header navigation links on smaller screens.
- Implements "Remember me" - functionality via cookies to enable persistent sessions across pages. By default the login state is preserved for the duration of the browser session.
# Technologies used
This project uses Rails, Postgresql, Javascript, HTML and CSS in order to build a full-blown database backed web-app.

# Link to the production application
You can visit the project application page at https://sample-app-z0aw.onrender.com/
