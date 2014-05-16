defmodule CsvViewer.Parser do
	def parse(lines) do
		Enum.map(lines, &(String.split(&1, ";")))
	end
end