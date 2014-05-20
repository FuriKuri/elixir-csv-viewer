defmodule CsvViewer.Main do
  import CsvViewer.CLI, only: [ file_name: 1, lines_per_page: 1 ]
  import CsvViewer.File, only: [ read: 1 ]
  import CsvViewer.Paging, only: [ extract: 3 ]
  import CsvViewer.Parser, only: [ parse: 1 ]
  import CsvViewer.Printer, only: [ print: 1 ]

  def main(args) do
    { :ok, pid } = :gen_server.start_link(CsvViewer.Page, 0, [])
    loop(:nothing, args, pid)
  end

  def loop(:e, _, _) do
  	System.halt(0)
  end

  def loop(input, args, pid) do
    do_action input, pid
    show_page args, pid
    loop(next_input, args, pid)
  end

  defp next_input do
    IO.gets("Next Prev Last First Exit\n")
      |> String.strip
      |> binary_to_atom
  end

  defp do_action(input, pid) do
    case input do
      :n -> :gen_server.call(pid, :next_page)
      :p -> :gen_server.call(pid, :prev_page)
      _ ->
    end
  end

  def show_page(args, pid) do
    limit = lines_per_page args
    args
      |> file_name
      |> read
      |> extract(:gen_server.call(pid, :current_page), limit)
      |> parse
      |> print
  end
end
