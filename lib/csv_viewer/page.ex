defmodule CsvViewer.Page do
  use GenServer.Behaviour

  def init(current_page) when is_number(current_page) do
    { :ok, current_page }
  end

  def handle_call(:next_page, _from, current_page) do
    { :reply, current_page + 1, current_page + 1 }
  end

  def handle_call(:prev_page, _from, current_page) do
    { :reply, current_page - 1, current_page - 1 }
  end

  def handle_call(:current_page, _from, current_page) do
    { :reply, current_page, current_page }
  end
end
