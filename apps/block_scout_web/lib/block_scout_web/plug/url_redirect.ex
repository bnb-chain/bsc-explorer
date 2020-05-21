defmodule BlockScoutWeb.Plug.URLRedirecter do
  @mainnet "/smart"
  @testnet "/smart-testnet"

  @spec init(any) :: any
  def init(args), do: args

  def call(%Plug.Conn{request_path: @testnet <> path, path_info: path_info} = conn, _) do
    replace_path(conn, path, path_info)
  end

  def call(%Plug.Conn{request_path: @mainnet <> path, path_info: path_info} = conn, _) do
    replace_path(conn, path, path_info)
  end

  def call(conn, _), do: conn

  defp replace_path(conn, path, path_info) do
    conn
    |>Map.replace!(:request_path, path)
    |>Map.replace!(:path_info, tl(path_info))
  end

end
