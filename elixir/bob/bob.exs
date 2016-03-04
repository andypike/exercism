defmodule Bob do
  def hey(remark) do
    cond do
      Remark.silence?(remark)  -> "Fine. Be that way!"
      Remark.question?(remark) -> "Sure."
      Remark.shout?(remark)    -> "Whoa, chill out!"
      true                     -> "Whatever."
    end
  end
end

defmodule Remark do
  def silence?(remark) do
    remark
    |> String.strip
    |> String.equivalent?("")
  end

  def question?(remark) do
    String.ends_with?(remark, "?")
  end

  def shout?(remark) do
    remark |> all_upcase? && remark |> not_all_downcase?
  end

  defp all_upcase?(remark) do
    remark
    |> String.upcase
    |> String.equivalent?(remark)
  end

  defp not_all_downcase?(remark) do
    remark
    |> String.downcase != remark
  end
end
