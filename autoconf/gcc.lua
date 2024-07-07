---
-- Autoconfiguration.
-- Copyright (c) 2016 Blizzard Entertainment
---
local p = premake
local gcc = p.tools.gcc

function gcc.try_compile(cfg, text, parameters)
	-- write the text to a temporary file.
	local cppFile = path.join(cfg.objdir, "temp.cpp")
	if not io.writefile(cppFile, text) then
		return nil
	end
	
	if parameters == nil then
		parameters = ""
	end

	local outFile = path.join(cfg.objdir, "temp.out")

	-- compile that text file.
	if os.execute('gcc "' .. cppFile .. '" ' .. parameters .. ' -o "' .. outFile ..'"  &> /dev/null') then
		return outFile
	else
		return nil
	end
end
