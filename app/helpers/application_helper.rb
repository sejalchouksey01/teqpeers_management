module ApplicationHelper
  def role_badge_class(role)
    case role.downcase
    when "manger"
      "badge-admin"
    when "mentor"
      "badge-editor"
    else
      "badge-user"
    end
  end
end
