defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: List do

  def encrypt(string, shift) do
    string
    |> Enum.map(fn(char) -> shift_char(char, shift) end)
  end

  def rot13(string), do: encrypt(string, 13)

  defp shift_char(char, shift) when char in ?a..?z do
    ?a + rem(char + shift - ?a, 26)
  end

  defp shift_char(char, shift) when char in ?A..?Z do
    ?A + rem(char + shift - ?A, 26)
  end

  defp shift_char(char, shift), do: char
end

