defmodule CsvViewer.File do
  def read(filename) do
  	case File.open(filename) do
      { :ok, file } -> IO.stream(file, :line) |> Stream.map(&String.strip(&1)) |> Enum.to_list
      { :error, msg } -> raise "Something went wrong #{msg}"
    end
  end
end
