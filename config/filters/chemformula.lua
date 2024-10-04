-- Coge los compuestos químicos y les aplica el paquete chemformula de latex
-- Solo funciona con compuestos químicos con subíndices
-- No funciona con isotopos
-- No funciona en entorno matemático

if FORMAT:match 'latex' then
    function Str (elem)
        if elem.text:match("%u%l?%d?%)?%d") then
            if elem.text:match("^#") then return elem end   -- evita colisión con plugin siunitx al descartar los que empiecen por #
            if elem.text:match(".%..") then return elem end   -- evita colisión con plugin las formas UD1.1
            start, formula, stop = elem.text:match("^(%p*)([%w%(%)%-%+=]+%w)(%p*)$")
            if PANDOC_WRITER_OPTIONS.variables["debug"] == true then
               print("ChemF", elem.text,":",start, formula, stop)
            end
            return { pandoc.Str(start),
                    pandoc.RawInline('latex', '\\ch{' .. formula .. '}'),
                    pandoc.Str(stop)}
        end
        return nil
    end
end

-- Bug conocido sin identificar causa: choca con siunitx.lua a la hora de identificar #L2/M2/s