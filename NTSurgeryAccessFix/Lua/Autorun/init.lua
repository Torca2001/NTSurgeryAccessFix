
Version = "1.0.0"

-- Version and expansion display
Timer.Wait(function() Timer.Wait(function()
    local runstring = "\n/// Running NT Surgery Access Fix V "..MT.Version.." ///\n"

    local linelength = string.len(runstring)+4
    local i = 0
    while i < linelength do runstring=runstring.."-" i=i+1 end

    print(runstring)
end,1) end,1)

-- jobid:surgeon
--id_medicaldoctor or jobid:medicaldoctor or id_medic

Hook.Patch("Barotrauma.RelatedItem", "Load", function(instance, ptable)
    ids = ptable.ReturnValue.JoinedIdentifiers
    if string.find(ids, "id_medic") or string.find(ids, "jobid:medicaldoctor") or string.find(ids, "id_medicaldoctor") then
        changed = false
        if not string.find(ids, "jobid:surgeon") then
            changed = true
            ids = ids .. ", jobid:surgeon"
        end

        if changed then
            ptable.ReturnValue.JoinedIdentifiers = ids
        end
    end
end, Hook.HookMethodType.After)


