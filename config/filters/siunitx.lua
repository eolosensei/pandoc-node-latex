-- Este plugin sustituye las apariciones valores con unidades, codificadas como valor#unidades
-- por código correcto de siunitx para latex y similares
-- Funciona para texto y para entorno matemático

-- Patrón para identificar valor#unidades
-- Admite números positivos y negativos con notación científica del tipo -8,3e-10
-- Las unidades deben estar separadas por puntos · o guiones -
-- Reconoce el signo de división y las potencias, pero de momento nada más.
-- Ejemplo: 8.64e-2#km/h
local str_pattern = "^([%(%[,;%.:/{~¿¡%\"\'=]*)([%+%-]?%d*[,%.]?%d*[eEdD]?[%+%-]?%d*)#([%w·/^]*)([%)%],;%.:}~?!\"\'=]*)$"
local math_pattern = "([%+%-]?%d*[,%.]?%d*[eE]?[%+%-]?%d*)#([%w·/^]*)"

-- reemplaza caracteres problemáticos dentro de las unidades y realiza ajustes varios
local replace_units = function (text)
  local text = string.gsub(text, "(%a+)", "\\%1")
  text = string.gsub(text, "-", "")
  text = string.gsub(text, "·", "")
  text = string.gsub(text, "ºC", "degreeCelsius")
  text = string.gsub(text, "%^*2", "\\squared")
  text = string.gsub(text, "%^*3", "\\cubed")
  text = string.gsub(text, "%^(%d+)", "\\tothe{%1}")
  text = string.gsub(text, "/", "\\per")
  return text
end

local generate_exponent = function (number)
  float,exp = number:match("([%+%-]?%d*[,%.]?%d*)[eEdD]?([%+%-]?%d*)")
  if exp ~= nil then
    return pandoc.Str(float)
  else
    return pandoc.Str(float .. ' · 10'), pandoc.Superscript(pandoc.String(exp))
  end
end

if FORMAT:match 'latex' then
  function Str (elem)
    start,number,units,stop = elem.text:match(str_pattern)
    if number == nil and units == nil then return elem end -- no ejecutar si no hay coincidencias
    if PANDOC_WRITER_OPTIONS.variables["debug"] == true then
      print("SI ",elem.text,":",start, number, units, stop)
    end
    if number ~= nil then          -- si el anterior ha hecho un match, entonces number no estará vacío
      if units == "º" then          -- si es un ángulo
        return {pandoc.Str(start),
                pandoc.RawInline('latex', '\\ang{' .. number .. '}'),
                pandoc.Str(stop)}
      end
      if units == "" then           -- si no tiene unidades, entonces es solo el número
        return {pandoc.Str(start),
                 pandoc.RawInline('latex', '\\num{' .. number .. '}'),
                 pandoc.Str(stop)}
      end
      units = replace_units(units)  -- realiza correcciones 
      if number == "" then          -- si no contiene valor numérico, solo es la unidad
        return {pandoc.Str(start),
                 pandoc.RawInline('latex', '\\unit{' .. units .. '}'),
                 pandoc.Str(stop)}
      else
        return {pandoc.Str(start),
                pandoc.RawInline('latex', '\\qty{' .. number .. '}{' .. units .. '}'),
                pandoc.Str(stop)}
      end
    else
      return elem
    end
  end

  function Math (elem)
    local newtext = string.gsub(elem.text, math_pattern, function (number, units)
              units = replace_units(units)
              if number == "" then 
                return '\\unit{' .. units .. '}'
              else  -- Aquí habría que meter también la condición de que solo sea un número sin unidades, ej: 5e-3#
                return '\\qty{' .. number .. '}{' .. units .. '}'
              end
        end)
    return pandoc.Math(elem.mathtype, newtext)
  end
end

-- if FORMAT:match 'docx' then
--   function Str (elem)
--     start,number,units,stop = elem.text:match(str_pattern)
--     if number ~= nil then          -- si el anterior ha hecho un match, entonces number no estará vacío
--       float,exp = number:match("([%+%-]?%d*[,%.]?%d*)[eEdD]?([%+%-]?%d*)")
--       if units == "º" then          -- si es un ángulo
--         return {pandoc.Str(start),
--                 pandoc.Str(number .. '°'),
--                 pandoc.Str(stop)}
--       end
--       if units == "" then           -- si no tiene unidades, entonces es solo el número
--         return {pandoc.Str(start),
--                  pandoc.Str(float), pandoc.Str(float .. ' · 10'), pandoc.Superscript(pandoc.String(exp)),
--                  pandoc.Str(stop)}
--       end
--       -- units = replace_units(units)  -- realiza correcciones 
--       if number == "" then          -- si no contiene valor numérico, solo es la unidad
--         return {pandoc.Str(start),
--                  pandoc.Str(units),
--                  pandoc.Str(stop)}
--       else
--         return {pandoc.Str(start),
--                 pandoc.Str(float), pandoc.Str(float .. ' · 10'), pandoc.Superscript(pandoc.String(exp)),
--                 pandoc.Space(),
--                 pandoc.Str(units),
--                 pandoc.Str(stop)}
--       end
--     else
--       return elem
--     end
--   end
-- end