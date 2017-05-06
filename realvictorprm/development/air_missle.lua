ac = 80
yMin = 10
function Update(I)
   mainframeCount = I:GetNumberOfMainframes();
   if(mainframeCount > 0) then
      targetIndex = 0
      mainframeIndex = 0
      targetInfo = I:GetTargetPositionInfo(mainframeIndex, targetIndex)
      -- I:Log(string.format("info valid: %s", tostring(targetInfo.Valid)))
      pos = targetInfo.Position
      x = pos.x
      y = pos.y
      z = pos.z
      height = targetInfo.AltitudeAboveSeaLevel
      -- I:LogToHud(string.format("x: %f, y: %f, z: %f", x, pos.y, z))
      -- I:Log(string.format("x: %f, y: %f, z: %f", x, y, z))

      if y < yMin then 
       y = yMin 
       I:LogToHud(string.format("Y < %d !", yMin))
      end
      transceiverCount = I:GetLuaTransceiverCount()
      for luaTransceiverIndex = 0, transceiverCount - 1 do
         transceiverInfo = I:GetLuaTransceiverInfo(luaTransceiverIndex)
         transceiverPos = transceiverInfo.Position
         a = pos - transceiverPos
         missileCount = I:GetLuaControlledMissileCount(luaTransceiverIndex)
         for missileIndex = 0, missileCount - 1 do
            info = I:GetLuaControlledMissileInfo(luaTransceiverIndex,missileIndex)
            mpos = info.Position
            if ( mpos.x > x - ac and mpos.x < (x + ac) and mpos.z > z - ac and mpos.z < z + ac and mpos.y > y - ac and mpos.y < y + ac) then
               -- I:DetonateLuaControlledMissile(luaTransceiverIndex,missileIndex)
               I:Log(string.format("detonating missle %d", missileIndex))
            else
               -- I:SetLuaControlledMissileStandardGuidanceOnOff(luaTransceiverIndex, missileIndex, false)
               I:SetLuaControlledMissileAimPoint(luaTransceiverIndex,missileIndex,x,y,z)
            end  
         end
      end
   end
end
