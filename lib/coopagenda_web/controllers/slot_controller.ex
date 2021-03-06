defmodule CoopagendaWeb.SlotController do
  use CoopagendaWeb, :controller

  plug :require_admin when action in [:create, :update, :delete]

  alias Coopagenda.Agenda
  alias Coopagenda.Agenda.Slot

  action_fallback CoopagendaWeb.FallbackController

  def index(conn, _params, _user) do
    slots = Agenda.list_slots()
    render(conn, "index.json", slots: slots)
  end

  def create(conn, %{"slot" => slot_params}, _user) do
    with {:ok, %Slot{} = slot} <- Agenda.create_slot(slot_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.slot_path(conn, :show, slot))
      |> render("show.json", slot: slot)
    end
  end

  def show(conn, %{"id" => id}, _user) do
    slot = Agenda.get_slot!(id)
    render(conn, "show.json", slot: slot)
  end

  def update(conn, %{"id" => id, "slot" => slot_params}, _user) do
    slot = Agenda.get_slot!(id)

    with {:ok, %Slot{} = slot} <- Agenda.update_slot(slot, slot_params) do
      render(conn, "show.json", slot: slot)
    end
  end

  def delete(conn, %{"id" => id}, _user) do
    slot = Agenda.get_slot!(id)

    with {:ok, %Slot{}} <- Agenda.delete_slot(slot) do
      send_resp(conn, :no_content, "")
    end
  end

  def action(conn, _) do
    apply(__MODULE__, action_name(conn),
        [conn, conn.params, conn.assigns.user])
  end
end
