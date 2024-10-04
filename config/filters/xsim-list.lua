-- convert exercise enumerated list into xsim format

function create_latex_env(type, blk_list)
  -- Exit if the element is nil
  if blk_list[1] == nil then
    return blk_list
  end

  -- Begin latex environment
  if blk_list[1].t ~= "Para" and blk_list[1].t ~= "Plain" then
    blk_list:insert(1, pandoc.RawBlock('latex', '\\begin{' .. type .. '}'))
  else
    --print(blk_list[1].content[1].text)
    local env_options = parse_env_options(blk_list[1])
    blk_list[1].content:insert(1, pandoc.RawInline('latex', '\\begin{' .. type .. '}' .. env_options))
  end

  -- End latex environment
  if blk_list[#blk_list].t ~= "Para" then
    blk_list:insert(pandoc.RawBlock('latex', '\\end{' .. type .. '}'))
  else
    blk_list[#blk_list].content:insert(pandoc.RawInline('latex', '\\end{' .. type .. '}'))
  end

  -- return Pandoc List with latex environment tags included
  return blk_list
end

function parse_env_options(block)
  local first_contents
  if block.content[1] and block.content[1].t == "Str" then
    _,_,first_contents = string.find(block.content[1].text,"%[(.+)%]")  
  end
  if first_contents then
    first_contents = '[' .. first_contents .. ']'
    block.content:remove(1)
  else
    first_contents = ""
  end
  return first_contents
end

if FORMAT:match 'latex' then
  function OrderedList (elem)
    if elem.style == "Decimal" and elem.delimiter == "Period" then
      -- Prepairs output list
      local final = {
        global = pandoc.List()
      }

      -- run over all items in ordered list
      for i,ex in ipairs(elem.content) do
        -- clears exercise and solution lists. Setup pre-run
        final.exercise = pandoc.List()
        final.solution = pandoc.List()
        local type = 'exercise'

        -- run over all blocks in each item from the ordered list
        for j,blk in ipairs(ex) do
          -- print("Block: ", blk)
          -- print("Block.content: ", blk.content)
          -- print("First: ", blk.content[1].t)
          -- print("Content:", blk.content[1].text)
          -- print("Condition 1:", blk.t)
          -- print("Condition 2:", blk.content[1].t)
          -- print("Condition 3:", blk.content[1].text)
          -- check if the block starts the solution block and removes signal
          -- removed condition blk.t == "Para" causing problems when "Plain"
          if blk.content and blk.content[1].t == 'Str' and blk.content[1].text == '{S}' then
            -- print("Is working?")
            type = 'solution'
            blk.content:remove(1)
            if blk.content[1] and blk.content[1].t == 'Space' then
              blk.content:remove(1)
            end
          end
          -- adds the block to the proper list
          final[type]:insert(blk)
          -- print("---------------")
        end

        -- creates the final list and wraps it with proper latex environment
        if FORMAT:match 'latex' then
          final.global:extend(create_latex_env('exercise', final.exercise))
          final.global:extend(create_latex_env('solution', final.solution))
        end

        if FORMAT:match 'html' then
          final.global:extend(pandoc.List({pandoc.Div(final.exercise, { class = "exercise"})}))
          final.global:extend(pandoc.List({pandoc.Div(final.solution, { class = "solution"})}))
        end
      end
      return final.global
    else
      return elem
    end
  end
end

if FORMAT:match 'markdown' then
  
end