HT = nil
TriggerEvent('HT_base:getBaseObjects', function(obj)
    HT = obj
end)


HT = nil

Citizen.CreateThread(function()
    while HT == nil do
        TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)
        Citizen.Wait(0)
    end
end)



Citizen.CreateThread(function()
    while true do
    local ped = PlayerPedId()
        Citizen.Wait(1)
                if GetDistanceBetweenCoords(GetEntityCoords(ped),461.68231201172,-1007.712890625,35.931102752686, true) <= 2 then
                    DrawText3Ds(461.68231201172,-1007.712890625,35.931102752686, "Tryk ~b~[E]~w~ for at åbne kamara")
                    if IsControlJustReleased(0, 38) then
                        HT.TriggerServerCallback('checkPoliceJob', function(Job) 
                        if Job == true then
                            openMenu()
                        end
                        SetCam(true,441.58102416992,-987.14758300781,32.323959350586, 0)
                        Citizen.Await(100)
                        openMenu()
                    end)
                end
            end
        end
    --hej med dig:)
end)

 function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 20, 20, 20, 150)
end


function openMenu()
    local elements = {
        { label = "Luk", value = "luk"},
    }
    HT.UI.Menu.Open('default', GetCurrentResourceName(), "vrp_htmenu",
    {
        title    = "Overvågningskamara", -- hvad der skal stå i toppen.
        align    = "center", --hvor menuen skal placeres på spillerens skærm.
        elements = elements -- Denne søger efter "local elements"
    },




    function(data, menu)
        if(data.current.value == 'luk') then -- Her siger den bare hvis man klikker "Luk" så lukker den.
            SetCam(false)
            menu.close()
        end
    end)
end

--SetCam funktion
function SetCam(onoff, CamX, CamY, CamZ, CamH)
    if onoff == true then
        if CurrentCam ~= 0 then 
            DestroyCam(CurrentCam)
        end
        CurrentCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(CurrentCam, CamX, CamY, CamZ, CamH)
        SetCamRot(CurrentCam, -21.637795701623, 0.0, CamH)
        SetCamActive(CurrentCam, true)
        RenderScriptCams(1, 1, 750, 1, 1)
    else
        SetCamActive(CurrentCam, false)
        DestroyCam(CurrentCam)
        DetachCam(CurrentCam)
        RenderScriptCams(false, true, 2000, true, true)
    end
end