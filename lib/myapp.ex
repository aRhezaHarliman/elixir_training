defmodule Myapp do
  @moduledoc """
  Documentation for Myapp.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Myapp.hello
      :world

  """
  # def hello do
  #   :world
  #   # "We need to make this test failed" -> uncomment this one then the test will be failed
  #   # :goodbye -> uncomment this one then the test will be failed
  # end

  use Application

  def start(_type, _args) do
    Myapp.Supervisor.start_link()
  end

  alias Hipchat.ApiClient
  alias Hipchat.Httpc.Response
  alias Hipchat.V2.Rooms

  def main([room_id, msg]) do
    client = ApiClient.new(load_token())
    {:ok, %Response{status: 201}} = Rooms.send_message(client, room_id, %{message: msg})
  end

  defp load_token() do
    Path.expand("~/.config/hipchat_cli/token")
    |> File.read!()
    |> String.trim()
  end

  # def main(_) do
  #   IO.puts("Hello Elixir!")
  # end
end
