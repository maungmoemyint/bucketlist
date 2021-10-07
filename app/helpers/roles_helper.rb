module RolesHelper
  #moved from application helper
  def
    can_edit?(goal)
    case(current_user.role)
    when 'admin' then true
    when 'registered' then current_user == goal.user
    else false
    end
  end

end
