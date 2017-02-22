defmodule Strings do
    def ascii_printable([]), do: true
    def ascii_printable([h|t]) do
        if(h > 31 && h < 127) do
            ascii_printable(t)
        else
            false
        end
    end
end