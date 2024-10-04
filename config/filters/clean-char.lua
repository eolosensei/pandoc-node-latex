function Str(elem)
    local substitution_table = {
        ['´a'] = "á", ["´e"] = "é",
        ["´ı"] = "í", ["´o"] = "ó",
        ["´u"] = "ú", ["˜n"] = "ñ",
        ["ºC"] = "°C"
    }
    local string = elem.text
    for k,v in pairs(substitution_table) do
        string = string:gsub(k, v)
    end
    return pandoc.Str(string)
end