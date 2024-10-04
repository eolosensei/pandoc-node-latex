if FORMAT:match 'latex' or 'json' then
    function OrderedList (list)
        -- checks if the tasks flag exists in the first element in the list
        -- print('1.',list.content[1][1])
        -- print('2.',list.content[1][1].t)
        -- print('3.',list.content[1][1].content[1])
        -- print('4.',list.content[1][1].content[1].t)
        -- print('5.',list.content[1][1].content[1].text)
        -- print('----------------')

        if list.content[1][1] and list.content[1][1].content[1] and list.content[1][1].content[1].t == "Str" and list.content[1][1].content[1].text:find("%{tasks%}%(%d+%)") then
            -- stores and removes 'task' flag
            env = list.content[1][1].content[1].text:match("%{tasks%}%(%d+%)")
            list.content:remove(1)
            
            -- creates list to store elements
            result = pandoc.List()
            
            -- stores elements in result lists
            result:insert(pandoc.RawInline('latex','\\begin' .. env .. '\n'))
            for i,task in ipairs(list.content) do
                item = pandoc.List({
                    pandoc.RawInline('latex', '\\task'),
                })
                for j,para in ipairs(task) do
                    item:insert(pandoc.Str('\n  '))
                    item:extend(para.content)
                    item:insert(pandoc.Str('\n'))
                    -- result:insert(pandoc.Para(item))
                    -- item = pandoc.List({
                    --     pandoc.Str("  ")
                    -- })
                end
                result:extend(item)
            end 
            result:insert(pandoc.RawInline('latex','\\end{tasks}'))

            -- returns the resulting item
            return pandoc.Para(result)
        end
    end
end