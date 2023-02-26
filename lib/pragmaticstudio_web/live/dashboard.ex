defmodule PragmaticstudioWeb.DashboardLive do
  use PragmaticstudioWeb, :live_view

  import Pragmaticstudio.GenerateSalesData

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end
    {:ok, assign_stats(socket)}
  end

  def render(assigns) do
    ~H"""
      <h1>Snappy Sales 📊</h1>
      <div class="mt-8 max-w-2xl mx-auto">
        <div class="mb-8 rounded-lg bg-white shadow-lg grid grid-cols-3">
          <div class="p-6 text-center;">
            <span class="block text-5xl font-extrabold text-indigo-600">
              <%= @new_orders %>
            </span>
            <span class="block mt-2 text-lg font-medium text-slate-500">
              New Orders
            </span>
          </div>
          <div class="p-6 text-center;">
            <span class="block text-5xl font-extrabold text-indigo-600">
              $<%= @sales_amount %>
            </span>
            <span class="block mt-2 text-lg font-medium text-slate-500">
              Sales Amount
            </span>
          </div>
          <div class="p-6 text-center;">
            <span class="block text-5xl font-extrabold text-indigo-600">
              <%= @satisfaction %>%
            </span>
            <span class="block mt-2 text-lg font-medium text-slate-500">
              Satisfaction
            </span>
          </div>
        </div>

        <button phx-click="refresh" class="inline-flex items-center px-4 py-2 border border-indigo-300 text-sm shadow-sm font-medium rounded-md text-indigo-700 bg-indigo-100 transition ease-in-out duration-150 outline-none hover:bg-white active:bg-indigo-200">
          <img class="mr-2 h-4 w-4" src="/images/refresh.svg" /> Refresh
        </button>
      </div>
    """
  end

  def handle_event("refresh", _, socket) do
      {:noreply, assign_stats(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_stats(socket)}
  end

  defp assign_stats(socket) do
      assign(socket,
      new_orders: new_orders(),
      sales_amount: sales_amount(),
      satisfaction: satisfaction()
    )
  end
end
