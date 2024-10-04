-- detect placeholders for exercises an solutions in latex / xsim

if FORMAT:match 'latex' then
  function Str (elem)
    if elem.text == "{{exercise}}" then 
      return pandoc.RawInline('latex', '\\begin{exercise}')
    elseif elem.text == "{{/exercise}}" then
      return pandoc.RawInline('latex', '\\end{exercise}')
    elseif elem.text == "{{solution}}" then
      return pandoc.RawInline('latex', '\\end{solution}')
    elseif elem.text == "{{/solution}}" then
      return pandoc.RawInline('latex', '\\end{solution}')
    else
      return elem
    end
  end
end