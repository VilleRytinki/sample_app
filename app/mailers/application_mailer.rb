class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@sample_app.com"
  layout "mailer"
end
