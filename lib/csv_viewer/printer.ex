defmodule CsvViewer.Printer do
	def print(lines) do
		format = format_for(widths(lines))
		lines
		  |> Enum.each(&(:io.format(format, &1)))
	end

  def format_for(column_width) do
    Enum.map_join(column_width, " | ",
      fn width -> "~-#{width}s" end) <> "~n"
  end

	def widths(lines) do
		lines
		  |> Enum.map( &( Enum.map(&1, fn x -> String.length(x) end ) ) )
		  |> Matrix.transpose
		  |> Enum.map(&(Enum.max(&1)))
	end
end
