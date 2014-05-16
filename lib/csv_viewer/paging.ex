defmodule CsvViewer.Paging do
	def extract([ header | content ], page, limit) do
		[header] ++ Enum.slice(content, page * limit, limit)
	end
end