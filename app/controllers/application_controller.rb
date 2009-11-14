# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging :password
  layout 'general'
  before_filter :set_locale
  #before_filter :log_action
  include AuthenticatedSystem
  
  def set_locale
    locale = I18n.locale = session[:locale] || I18n.default_locale
    p = params[:locale]
    return if not p
    if p == ''
      locale = (locale=='en'? 'fr':'en')
    else
      locale = p
    end
    session[:locale] = I18n.locale = locale
    
    #OPTIMIZE better locales handling
    #locale = params[:locale] || session[:locale] || (this_user.site_language if is_logged_in?) || I18n.default_locale
    #locale = AVAILABLE_LOCALES.keys.include?(locale) ? locale : I18n.default_locale
    #session[:locale] = I18n.locale = locale
  end
  
  #def log_action
  #  @action_log = ActionLog.new
  #  # who is doing the activity?
  #  @action_log.session_id = session.session_id #record the session
  #  @action_log.browser = request.env['HTTP_USER_AGENT']
  #  @action_log.ip = request.env['HTTP_X_FORWARDED_FOR'] || request.env['REMOTE_ADDR']
  #  # what are they doing?
  #  @action_log.controller        = controller_name
  #  @action_log.action            = action_name
  #  @action_log.controller_action = controller_name + "/" + action_name
  #  @action_log.params            = params.inspect # wrap this in an unless block if it might contain a password
  #  @action_log.user_id           = session[:user_id]
  #  @action_log.company_id        = current_user.company_id if session[:user_id]
  #  @action_log.save!
  #end  

end

