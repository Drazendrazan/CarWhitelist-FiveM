local label =
[[ 
  //   
  ||            __                                    __    __  __       
  ||           |  \                                  |  \  |  \|  \      
  ||           | $$      __    __   _______  ______  | $$\ | $$| $$      
  ||           | $$     |  \  |  \ /       \|      \ | $$$\| $$| $$      
  ||           | $$     | $$  | $$|  $$$$$$$ \$$$$$$\| $$$$\ $$| $$      
  ||           | $$     | $$  | $$| $$      /      $$| $$\$$ $$| $$      
  ||           | $$_____| $$__/ $$| $$_____|  $$$$$$$| $$ \$$$$| $$_____ 
  ||           | $$     \\$$    $$ \$$     \\$$    $$| $$  \$$$| $$     \
  ||            \$$$$$$$$ \$$$$$$   \$$$$$$$ \$$$$$$$ \$$   \$$ \$$$$$$$$                                                                                                                                                                 
  ||                           Created by LucaNL#2230
  ||]]

function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

PerformHttpRequest("https://version.lucadev.nl/CarWhitelist-FiveM/version.txt", function( err, text, headers )
	Citizen.Wait(2000)
	print( label )
	local curVer = GetCurrentVersion()
	print( "  ||    Current version: " .. curVer )
	if ( text ~= nil ) then
		print( "  ||    Latest recommended version: " .. text .."\n  ||" )

		if ( text ~= curVer ) then
			print( "  ||    ^1Your CarWhitelist version is outdated, please visit the FiveM forum page at https://forum.cfx.re/t/release-free-carwipe-fivem/4839898 to get the latest version.^0\n  ||" )
		else
			print( "  ||    ^2CarWhitelist is up to date!\n^0  ||  \n  \\\\\n" )
			return
		end
	else
		print( "  ||    ^1There was an error getting the latest version information.\n^0  ||  \n  \\\\\n" )
	end
end)