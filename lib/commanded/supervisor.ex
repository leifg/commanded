defmodule Commanded.Supervisor do
  @moduledoc false
  use Supervisor

  alias Commanded.Registration

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      {Task.Supervisor, name: Commanded.Commands.TaskDispatcher},
      {Commanded.Aggregates.Supervisor, []},
      {Commanded.Subscriptions, []},
    ] ++ Registration.child_spec()

    Supervisor.init(children, strategy: :one_for_one)
  end
end
