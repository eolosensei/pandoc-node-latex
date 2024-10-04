local if_option = function(attr)
  if attr == nil then
    return ''
  else
    return '[' .. attr .. ']'
  end
end


if FORMAT:match 'latex' then
  function Image (elem)
    if PANDOC_WRITER_OPTIONS.variables["debug"] == true then
      print("WF ",  elem.attr.attributes)
    end
    if elem.attributes.wrapfig == nil then
      return elem
    end
    
    local lines = if_option(elem.attributes.wrapfig_lines)
    local place = '{' .. elem.attributes.wrapfig .. '}'
    local overhang = if_option(elem.attributes.wrapfig_overhang)
    local width = '{' .. assert(elem.attributes.wrapfig_width, "Falta valor obligatorio: width") .. '}'
    
    local output = {pandoc.RawInline('latex', '\\begin{wrapfigure}' ..
                      lines ..
                      place ..
                      overhang ..
                      width),
                    elem}

    if elem.caption ~= nil then
      table.insert(output, pandoc.RawInline('latex', '\\caption{'))    
      table.insert(output, pandoc.RawInline('latex', pandoc.utils.stringify(elem.caption)))
      table.insert(output, pandoc.RawInline('latex', '}'))
    end

    table.insert(output, pandoc.RawInline('latex', '\\end{wrapfigure}'))

    return output
  end
end

-- if FORMAT:match 'latex' then
--   function Figure (elem)
--     print("FIG ", elem.attr, elem.attributes, pandoc.utils.type(elem.content))
--     elem.content:map(print)
--   end
-- end

-- Plain [Image ("",[],[("wrapfig","r"),("wrapfig_width","5cm")]) 
--       [Str "Modelo", Space, Str "at\243mico", Space ,Str "de" , Space, Str "Thomson"]
--       ("FQ%203E%202015%20SM%20Qu\237mica-p76c.png","")]    1