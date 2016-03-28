module ApplicationHelper
  def delete_icon
    return '<span class="glyphicon glyphicon-trash" title="Delete"></span>'.html_safe
  end

  def show_icon
    return '<span class="glyphicon glyphicon-eye-open" title="Show"></span>'.html_safe
  end

  def edit_icon
    return '<span class="glyphicon glyphicon-wrench" title="Edit"></span>'.html_safe
  end

  def new_icon
    return '<span class="glyphicon glyphicon-plus" title="New"></span>'.html_safe
  end

  def right_arrow_icon
    return '<span class="glyphicon glyphicon-share-alt"></span>'.html_safe
  end

end
