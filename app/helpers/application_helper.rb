# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def warning_message(message)
    "<div class='warning'>#{message}</div>"
  end
  
  def success_message(message)
    "<div class='success'>#{message}</div>"
  end

  def error_message(message)
    "<div class='error'>#{message}</div>"
  end
  
  def info_message(message)
    "<div class='error'>#{message}</div>"
  end
  
end
