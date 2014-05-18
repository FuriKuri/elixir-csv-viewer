defmodule CsvViewer.CLI do
  def file_name(args) do
    Enum.at args, 0
  end

  def lines_per_page(args) do
  	binary_to_integer(Enum.at(args, 1))
  end
end
