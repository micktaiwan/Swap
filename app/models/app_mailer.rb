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

  def proposition(p)
    @subject    = "[Swap!] Proposition from #{p.user.name}"
    @body["p"] = p
    @recipients = p.owner.email
    @from       = p.user.email
    @sent_on    = Time.now
    @headers    = {}
    content_type "text/html"
  end

  def cancel_proposition(p)
    @subject    = "[Swap!] Canceling proposition from #{p.user.name}"
    @body["p"] = p
    @recipients = p.owner.email
    @from       = p.user.email
    @sent_on    = Time.now
    @headers    = {}
    content_type "text/html"
  end

  def message(m, recipients)
    @subject    = "[Swap!] Message from #{m.user.name}"
    @body["m"] = m
    @recipients = recipients
    @from       = m.user.email
    @sent_on    = Time.now
    @headers    = {}
    content_type "text/html"
  end
  
end

