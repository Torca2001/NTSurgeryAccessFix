
Version = "1.0.0"

-- Print a nice version header
Timer.Wait(function() Timer.Wait(function()
    local runstring = "\n/// Running NT Surgery Access Fix V "..Version.." ///\n"

    local linelength = string.len(runstring)+4
    local i = 0
    while i < linelength do runstring=runstring.."-" i=i+1 end

    print(runstring)
end,1) end,1)

-- Patch the ID card to add the medical tags to the surgeon job
-- Also send a networking event to update the clients
function upgradeIDCard (instance, ptable)
    item = instance.item
    if item.HasTag("jobid:surgeon") then
        updated = false

        if not item.HasTag("jobid:medicaldoctor") then
            item.Tags = "jobid:medicaldoctor," .. item.Tags 
            updated = true
        end

        -- Add common medical tags
        if not item.HasTag("id_medic") then
            item.AddTag("id_medic")
            updated = true
        end

        if not item.HasTag("id_medical") then
            item.AddTag("id_medical")
            updated = true
        end

        if not item.HasTag("id_medicaldoctor") then
            item.AddTag("id_medicaldoctor")
            updated = true
        end

        if updated then

            -- Only server needs to update clients
            if SERVER then 
                Networking.CreateEntityEvent(item, Item.ChangePropertyEventData(item.SerializableProperties[Identifier("Tags")], item))
            end
        end
    end
end

-- Patch the ID card to add the medical tags to the surgeon job
Hook.Patch("Barotrauma.Items.Components.IdCard", "OnItemLoaded", upgradeIDCard, Hook.HookMethodType.After)
Hook.Patch("Barotrauma.Items.Components.IdCard", "Initialize", upgradeIDCard, Hook.HookMethodType.After)


