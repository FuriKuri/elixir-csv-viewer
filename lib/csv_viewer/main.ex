defmodule CsvViewer.Main do
	import CsvViewer.CLI, only: [ file_name: 1, lines_per_page: 1 ]
	import CsvViewer.File, only: [ read: 1 ]
	import CsvViewer.Paging, only: [ extract: 3 ]
	import CsvViewer.Parser, only: [ parse: 1 ]
	import CsvViewer.Printer, only: [ print: 1 ]

  def main(args) do
  	{ :ok, pid } = :gen_server.start_link(CsvViewer.Page, 0, [])
  	limit = lines_per_page args
  	args
  	  |> file_name
  	  |> read
  	  |> extract(:gen_server.call(pid, :current_page), limit)
  	  |> parse
  	  |> print
  end
end