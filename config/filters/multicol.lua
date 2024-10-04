-- md = require('mobdebug')
-- md.start()

local columns = 2


OrderedList = function (elem)
  local list = elem.content
  local list_lenght = #list
  
  -- si la lista tiene menos de 3 elementos, no poner en columnas
  -- if list_lenght < 4 then
  --   return elem
  -- end

  -- si algún elemento de la lista tiene más de un párrafo, no aplicar columnas
  -- si algún elemento de la lista tiene más de 10 palabras, no aplicar columnas

  -- for i,block in ipairs(list) do
  --   print("Block",i,"lenght",#block)
  --   for j,inline in ipairs(block) do
  --     print("|- Elem", j)
  --     print("|  Type", inline.t, "length", #inline.content)
  --     for k,word in ipairs(inline.content) do
  --       print("  |-- Elem", k)
  --       print("  |   Type", word.t)
  --       print("  |   Text", word.text)
  --       if word.t == 'Str' or word.t == "Math" then
  --         print("  |   Characters", #word.text)
  --       end
  --     end
  --   end
  -- end


  return {
    pandoc.RawBlock("latex", '\\begin{multicols}{'.. columns ..'}'),
    elem,
    pandoc.RawBlock("latex", '\\end{multicols}')
  }
end