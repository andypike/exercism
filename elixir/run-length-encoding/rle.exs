defmodule Occurrence do
  defstruct char: nil, count: 1

  def last(occurrences) do
    List.last(occurrences) || %Occurrence{}
  end

  def add_first(occurrences, char) do
    occurrences ++ [ %Occurrence{ char: char } ]
  end

  def increment_last(occurrences) do
    List.update_at occurrences, -1, fn(last_occurrence) ->
      %{ last_occurrence | count: last_occurrence.count + 1 }
    end
  end

  def compress(occurrence) do
    Integer.to_string(occurrence.count) <> occurrence.char
  end

  def inflate(occurrence) do
    String.duplicate(occurrence.char, occurrence.count)
  end

  def from_match(match) do
    %Occurrence{
      char:  Enum.at(match, 2),
      count: String.to_integer(Enum.at(match, 1))
    }
  end
end


defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """

  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> split_into_characters
    |> count_consecutive_characters
    |> compress
  end

  defp split_into_characters(string) do
    String.split(string, "", trim: true)
  end

  defp count_consecutive_characters(characters) do
    Enum.reduce characters, [], fn(char, occurrences) ->
      case Occurrence.last(occurrences).char do
        ^char -> Occurrence.increment_last(occurrences)
        _     -> Occurrence.add_first(occurrences, char)
      end
    end
  end

  defp compress(occurrences) do
    Enum.reduce occurrences, "", fn(occurrence, output) ->
      output <> Occurrence.compress(occurrence)
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> split_into_occurrences
    |> inflate
  end

  defp split_into_occurrences(string) do
    Regex.scan(~r/(\d+)(\w)/, string)
    |> Enum.map(&Occurrence.from_match/1)
  end

  defp inflate(occurrences) do
    Enum.reduce occurrences, "", fn(occurrence, output) ->
      output <> Occurrence.inflate(occurrence)
    end
  end
end
