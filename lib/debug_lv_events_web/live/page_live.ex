defmodule DebugAppWeb.PageLive do
  use DebugAppWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <.form let={f} for={:form} phx-change="form-changed">
      <fieldset>
        <legend align="center">A group of radio buttons</legend>
        <%= for id <- 1..3 do %>
          <%= label f, :radio, phx_click: "radio-clicked", phx_value_id: id do %>
            <%= radio_button f, :radio, id, checked: id == @form_radio_selection %>
            <%= "Radio #{id}" %>
          <% end %>
        <% end %>
      </fieldset>
    </.form>
    <h2>Events:</h2>
    <pre id="events" phx-update="prepend">
      <%= for event <- @events do %>
        <p style="margin-bottom: 0" id={event.id}>
          <%= event.id %> - <%= event.description %> (value: <%= event.selection %>)
        </p>
      <% end %>
    </pre>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form_radio_selection: 1, events_count: 0),
     temporary_assigns: [events: []]}
  end

  @impl true
  def handle_event("radio-clicked" = event, %{"id" => id}, socket) do
    {:noreply, update_events_and_selection(socket, event, id)}
  end

  def handle_event("form-changed" = event, %{"form" => %{"radio" => id}}, socket) do
    {:noreply, update_events_and_selection(socket, event, id)}
  end

  defp update_events_and_selection(socket, event, selection) do
    events_count = socket.assigns.events_count + 1

    socket
    |> update(:events, fn events ->
      [%{description: event, id: events_count, selection: selection} | events]
    end)
    |> assign(form_radio_selection: String.to_integer(selection), events_count: events_count)
  end
end
