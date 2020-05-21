defmodule BlockScoutWeb.Router do
  use BlockScoutWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(BlockScoutWeb.CSPHeader)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  url_params = Application.get_env(:block_scout_web, BlockScoutWeb.Endpoint)[:url]
  api_path = url_params[:api_path]
  path = url_params[:path]

  if path != api_path do
    scope to_string(api_path) <> "/verify_smart_contract" do
      pipe_through(:api)

      post("/contract_verifications", BlockScoutWeb.AddressContractVerificationController, :create)
    end
  else
    scope "/verify_smart_contract" do
      pipe_through(:api)

      post("/contract_verifications", BlockScoutWeb.AddressContractVerificationController, :create)
    end
  end

  forward("/", BlockScoutWeb.WebRouter)
end
