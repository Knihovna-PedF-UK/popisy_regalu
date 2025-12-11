
local csv = require "csv"
kpse.set_program_name "luatex"

local texfilename = kpse.find_file("stitky-oddily.tex")
local csvfilename = "popisky-regalu.csv"
local csvfile = csv.open(csvfilename)

local signatury = {}
for rec in csvfile:lines() do
  local signatura, popis = table.unpack(rec)
  signatury[signatura] = popis
end

local used = {}
for line in io.lines(texfilename) do
  local signatura = line:match("{(.-)}")
  used[signatura] = line
  -- print(signatura, signatury[signatura])
end

for signatura, popisek in pairs(signatury) do
  local tex = used[signatura] 
  if tex then
    local new = tex:gsub("{}$", string.format("{%s}", popisek))
    print(new)
  end
end
