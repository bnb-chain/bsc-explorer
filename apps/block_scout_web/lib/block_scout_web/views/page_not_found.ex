defmodule BlockScoutWeb.PageNotFoundView do
  use BlockScoutWeb, :view

  @dialyzer :no_match

  def home_url() do
    Application.get_env(:block_scout_web, :web_network_path, "/")
  end

end
