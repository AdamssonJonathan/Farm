# defmodule Token do
#   defmodule Unencoded do
#     @moduledoc """
#       The unencoded version of the token.
#     """
#     @enforce_keys [:bot,
#                     :exp,
#                     :fw_update_server,
#                     :os_update_server,
#                     :iat,
#                     :iss,
#                     :jti,
#                     :mqtt,
#                     :sub]
#     @type t :: %__MODULE__{
#       # Github apis for bot and fw updates.
#       fw_update_server: String.t,
#       os_update_server: String.t,
#
#       # Dates for when the token expires and was issued at.
#       exp: number,
#       iat: number,
#       # Bot name for logging into MQTT.
#       bot: String.t,
#
#       # Issuer (api server)
#       iss: String.t,
#       # mqtt broker
#       mqtt: String.t,
#       # uuid
#       jti: String.t,
#       # Email
#       sub: String.t
#     }
#     defstruct [:bot,
#                :exp,
#                :fw_update_server,
#                :os_update_server,
#                :iat,
#                :iss,
#                :jti,
#                :mqtt,
#                :sub]
#   end
#   @moduledoc """
#     Token Object
#   """
#   @enforce_keys [:encoded, :unencoded]
#   defstruct [ :encoded, :unencoded ]
#   @type t :: %__MODULE__{
#     encoded: binary,
#     unencoded: Unencoded.t
#   }
#
#   @doc """
#     Creates a valid token from json.
#     This function excepts either {:ok, token} or just a map of a token
#     so FarmbotAuth can be piped into it.
#   """
#   @spec create({:ok, map} | map) :: {:ok, t} | {atom, :malformed}
#   def create({:ok, token}), do: create(token)
#   def create(%{"encoded" => encoded,
#                "unencoded" =>
#                 %{"bot" => bot,
#                   "exp" => exp,
#                   "fw_update_server" => fw_update_server,
#                   "os_update_server" => os_update_server,
#                   "iat" => iat,
#                   "iss" => iss,
#                   "jti" => jti,
#                   "mqtt" => mqtt,
#                   "sub" => sub}})
#   do
#     f =
#     %Token{encoded: encoded,
#            unencoded: %Unencoded{
#              bot: bot,
#              exp: exp,
#              iat: iat,
#              iss: iss,
#              jti: jti,
#              mqtt: mqtt,
#              sub: sub,
#              fw_update_server: fw_update_server,
#              os_update_server: os_update_server }}
#     {:ok, f}
#   end
#   def create(_), do: {__MODULE__, :malformed}
#
#   @spec create!({:ok, map} | map) :: t
#   def create!({:ok, thing}), do: create!(thing)
#   def create!(thing) do
#     case create(thing) do
#       {:ok, success} -> success
#       {__MODULE__, :malformed} -> raise "Malformed #{__MODULE__} Object"
#     end
#   end
# end
