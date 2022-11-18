class ApplicationController < ActionController::Base
    # CRRLLL
    helper_method :current_user, :logged_in?, :btn_to

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def logged_in?
        !!current_user
    end

    def login(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout
        current_user.reset_session_token!
        @current_user = nil
        session[:session_token] = nil
    end

    def btn_to(action, label, token)
        html = "<form action='#{action}' method='POST'>"
        html += "<input type='hidden' name='_method' value='DELETE'>"
        html += "<input type='hidden' name='authenticity_token' value='#{token}'>"
        html += "<button>#{label}</button></form>"
        return html.html_safe
    end
end
