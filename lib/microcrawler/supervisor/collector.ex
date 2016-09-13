defmodule Microcrawler.Supervisor.Collector do
    require Logger
    use Supervisor

    @server __MODULE__

    def start_link do
        Logger.info("Starting #{__MODULE__}")

        Supervisor.start_link(@server, :ok, [name: @server])
    end

    def init(:ok) do
        collector = worker(Microcrawler.Worker.Collector, [[], [name: Collector]])

        children = [
            collector
        ]

        supervise(children, strategy: :one_for_one)
    end
end