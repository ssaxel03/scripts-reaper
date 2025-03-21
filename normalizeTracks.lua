local trackCount = reaper.CountTracks(0)

function normalizeToMinus18dB(track)
    reaper.SetMediaTrackInfo_Value(track, "D_VOL", 0.125)
end

function checkNewTracks()
    local currentCount = reaper.CountTracks(0)

    if currentCount > trackCount then
        for i = trackCount, currentCount - 1 do
            local track = reaper.GetTrack(0, i)
            normalizeToMinus18dB(track)
        end
        trackCount = currentCount
    end

    reaper.defer(checkNewTracks)
end

checkNewTracks()

