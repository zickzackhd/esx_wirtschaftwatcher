ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local userbankkaufkraft=0
local userBarKaufkraft=0
local firmenkaufkraft=0
local blackmoneyKaufkraft=0


local function CollectData() 
    
    userbankkaufkraft=0
    userBarKaufkraft=0
    firmenkaufkraft=0
    blackmoneyKaufkraft=0

    MySQL.ready(function()        
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier is not null',{},function(AllUser)

            RunALLUSERWirschaftspruefung(AllUser)
            RunUSERWirschaftspruefung(AllUser)
        end)
        MySQL.Async.fetchAll('SELECT * FROM addon_account_data',{},function(AllFirmen)
        
            RunFirmenWirtschaftspruefung(AllFirmen)
        end)
    end)
    Citizen.Wait(5000)
    MySQL.Async.execute("INSERT INTO wirtschaft (bank, bargeld, firmengeld, blackmoney) VALUES (@bank, @bargeld, @firmengeld, @blackmoney)",{
        ['@bank'] = userbankkaufkraft,
        ['@bargeld'] = userBarKaufkraft,
        ['@firmengeld'] = firmenkaufkraft,
        ['@blackmoney'] = blackmoneyKaufkraft
    }) 
end

RegisterServerEvent('wirtschaft:logItemSell')
AddEventHandler('wirtschaft:logItemSell', function(xPlayer, item, itemCount, price)
    MySQL.Async.execute("INSERT INTO wirtschaft_item_sells (identifier, item, item_count, price) VALUES(@identifier, @item, @itemCount, @price)", {
        ['@identifier'] = xPlayer.identifier,
        ['@item']       = item,
        ['@itemCount']  = itemCount,
        ['@price']      = price
    })
end)

function RunUSERWirschaftspruefung(AllUser)
    local usersbank
    local usersbargeld
    local usersblackmoney
    for i=1 , #AllUser,1 do 
        local userbank = 0
        local userbargeld =0
        local userblackmoney =0
        local decode = json.decode(AllUser[i].accounts)

        if decode.money ~=nil then
            if decode.money >0 then
            
                userbargeld= decode.money
            else
             
            end
        end
        if decode.bank ~=nil then
            if decode.bank >0 then
            
                userbank= decode.bank
            else
             
            end
        end
        if decode.black_money ~=nil then
            if decode.black_money >0 then
            
                userblackmoney=decode.black_money
            else
             
            end
        end
        MySQL.Sync.execute("INSERT INTO wirtschaft_users (steamname, bank, bargeld, blackmoney, identifier) VALUES (@steamname, @bank, @bargeld, @blackmoney, @identifier)",{['@steamname'] = AllUser[i].firstname..' '..AllUser[i].lastname,['@bank'] = userbank,['@bargeld'] = userbargeld,['@blackmoney'] = userblackmoney,['@identifier'] = AllUser[i].identifier})
    end

end

function RunALLUSERWirschaftspruefung(AllUser)
    for i=1 , #AllUser,1 do 

        decode = json.decode(AllUser[i].accounts)

        if decode.money ~=nil then
            if decode.money >0 then
            
                userBarKaufkraft= userBarKaufkraft+decode.money
            else
             
            end
        end
        if decode.bank ~=nil then
            if decode.bank >0 then
            
                userbankkaufkraft= userbankkaufkraft+decode.bank
            else
             
            end
        end
        if decode.black_money ~=nil then
            if decode.black_money >0 then
            
                blackmoneyKaufkraft= blackmoneyKaufkraft+decode.black_money
            else
             
            end
        end
       
        
    end


end


function RunFirmenWirtschaftspruefung(AllFirmen)
    for i=1 , #AllFirmen,1 do
        if string.match(AllFirmen[i].account_name, "society") then
            if string.match(AllFirmen[i].account_name, "cardealer") or string.match(AllFirmen[i].account_name, "police") or string.match(AllFirmen[i].account_name, "Justiz") or string.match(AllFirmen[i].account_name, "sgpolice") or string.match(AllFirmen[i].account_name, "ambulance") or string.match(AllFirmen[i].account_name, "fbi") or string.match(AllFirmen[i].account_name, "sheriff") or string.match(AllFirmen[i].account_name, "army") or string.match(AllFirmen[i].account_name, "swat") or string.match(AllFirmen[i].account_name, "news") or string.match(AllFirmen[i].account_name, "taxi") or string.match(AllFirmen[i].account_name, "Rathaus") or string.match(AllFirmen[i].account_name, "realestateagent") then

            else
               
                firmenkaufkraft=firmenkaufkraft+AllFirmen[i].money 
            end
        
    
        elseif  string.match(AllFirmen[i].account_name, "black_money") then
            blackmoneyKaufkraft= blackmoneyKaufkraft+AllFirmen[i].money 
        end
       
        
    end
end

AddEventHandler('onResourceStart', function(resourceName)
    if Config.SaveAfterRestart then
        CollectData()
        print("Mannuelles Speichern Erfogreich")
    end
end)

TriggerEvent('cron:runAt', 4, 0, CollectData)