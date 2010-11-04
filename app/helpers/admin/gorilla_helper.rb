module Admin::GorillaHelper
  def node_title
    %{<span class="title">#{ h(@current_node.breadcrumb) }</span>}
  end
end