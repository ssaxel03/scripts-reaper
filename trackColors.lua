local trackNames = {}

function ColorTrackByName()
    local trackCount = reaper.CountTracks(0)

    local colorRules = {
        {pattern = "bass", color = reaper.ColorToNative(0, 255, 0)},
        {pattern = "drum", color = reaper.ColorToNative(255, 0, 0)},
        {pattern = "guitar", color = reaper.ColorToNative(0, 0, 255)},
        {pattern = "vocals", color = reaper.ColorToNative(255, 255, 0)}
    }

    for i = 0, trackCount - 1 do
        local track = reaper.GetTrack(0, i)
        local _, trackName = reaper.GetTrackName(track)

        if trackNames[i] ~= trackName then
            trackNames[i] = trackName:lower()

            for _, rule in ipairs(colorRules) do
                if trackName:lower():find(rule.pattern) then
                    reaper.SetTrackColor(track, rule.color)
                    break
                end
            end
        end
    end

    reaper.TrackList_AdjustWindows(false)
    reaper.defer(ColorTrackByName)
end

ColorTrackByName()
