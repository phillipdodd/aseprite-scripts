do 

    ::beginning::

    local type = app.range.type
    
    if type == RangeType.EMPTY or not type == RangeType.FRAMES then 
        app.alert('Please select frames to modify.')
        return
    end

    local frames = app.range.frames
    local selectedFramesString = "[" .. frames[1].frameNumber .. " .. " .. frames[#frames].frameNumber .. "]"
        
    local data = Dialog()
        :label{
            id = "frameInfo",
            label = "Selected Frames:",
            text = selectedFramesString
        }
        :number{ 
            id = 'desiredDuration', 
            label = "Duration (milliseconds):", 
            text = ""
        }
        :button{id="ok", text="OK"}
        :button{id="cancel", text="Cancel"}
        :show().data

    if data.ok then

        local desiredDuration = tonumber(data.desiredDuration) / 1000

        if desiredDuration == nil or data.desiredDuration < 1 then 
            app.alert('Please enter a valid non-zero number.')
            goto beginning
        end
        
        for _, frame in ipairs(frames) do 
            frame.duration = desiredDuration
        end
        app.alert("Frames " .. selectedFramesString .. " duration succesfully set to " .. data.desiredDuration)

    end
    
end