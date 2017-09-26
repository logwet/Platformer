local input = {}

input.check = function (self)
  local output = nil
  if love.keyboard.isDown("left", "a") then
    output = "left"
  end
  return output
end

if input.check(input) == "left" then

end

return input
