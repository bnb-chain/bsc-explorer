defmodule BlockScoutWeb.AddressTokenView do
  use BlockScoutWeb, :view

  def convertTokenType(type) do
    case type do
      "ERC-20" -> "BEP2E"
      _ -> type
    end
  end

end
