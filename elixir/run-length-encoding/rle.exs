defmodule Occurrence do
  defstruct char: nil, count: 1
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
    |> format_output
  end

  defp split_into_characters(string) do
    String.split(string, "", trim: true)
  end

  defp count_consecutive_characters(characters) do
    Enum.reduce characters, [], fn(char, occurrences) ->
      case last_occurrence(occurrences).char do
        ^char -> increment_last_occurrence(occurrences, char)
        _     -> add_first_occurrence(occurrences, char)
      end
    end
  end

  defp last_occurrence(occurrences) do
    List.last(occurrences) || %Occurrence{}
  end

  defp add_first_occurrence(occurrences, char) do
    occurrences ++ [ %Occurrence{ char: char } ]
  end

  defp increment_last_occurrence(occurrences, char) do
    List.update_at occurrences, -1, fn(last_occurrence) ->
      %{ last_occurrence | count: last_occurrence.count + 1 }
    end
  end

  defp format_output(occurrences) do
    Enum.reduce occurrences, "", fn(occurrence, output) ->
      output <> occurrence_output(occurrence)
    end
  end

  defp occurrence_output(occurrence) do
    Integer.to_string(occurrence.count) <> occurrence.char
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
  end
end
