class AppMailer < ActionMailer::Base
  
  def alert(title, msg)
    @subject    = '[Swap] ' + title
    @body["msg"] = msg
    @recipients = 'faivrem@gmail.com'
    @from       = 'protask@protaskm.com'
    @sent_on    = Time.now
    @headers    = {}
  end
  
  def invitation(from,user,msg,pwd)
    @subject    = "[Swap!] #{from.name} invited you on Swap!"
    @body["f"] = from
    @body["user"] = user
    @body["msg"] = msg
    @body["pwd"] = pwd
    @recipients = user.email
    @from       = from.email
    @sent_on    = Time.now
    @headers    = {}
    content_type "text/html"
  end
  
end

