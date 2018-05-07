scriptname CustomCategoriesInstallerScript extends Quest

Group VanillaWorkshopMenus
	FormList property VanillaWorkshopMenu auto const
	{The menu you want to add your new categeory to}
	;Add more properties for other vanilla menus if needed
	;Tipp: Name your properties as your forms in CK, so you can auto fill them with one click
EndGroup

Group CustomWorkshopMenus
	FormList property CustomWorkshopMenu auto const
	{A menu you want to add to a vanilla menu}
	Keyword property CustomWorkshopCategory auto const
	{A category you want to add to a vanilla menu}
	;Add more properties for other custom menus/keywords if needed
	;Tipp: Name your properties as your forms in CK, so you can auto fill them with one click
EndGroup

;TODO - remove if you dont want to use a while loop
bool uninstallCheckRunning = false

;====================================================================================================================
;Add your new forms
;====================================================================================================================

;The event OnPlayerLoadGame will not be executed the first time the player loads his game with this plugin active, so 
;we have to call the install() function manually once.
Event OnQuestInit()
	install()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	;TODO - remove if you dont want to use a while loop
	checkForUninstall()
EndEvent

;Calls the install function everytime the player loads his game. If you are adding many categories, you should stop 
;the time first. If your script runs longer then a few seconds, remove this event and the line 
;RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame") above
;This event is a safety feature, in case some other mod calls the revert() function on one of the formlists you want 
;to edit.
Event Actor.OnPlayerLoadGame(Actor actorref)
	install()
	;TODO - remove if you dont want to use a while loop
	checkForUninstall()
EndEvent		

;This function adds your new menus or categories to the vanilla formlists
Function install()
	;TODO - Adjust this function to your needs. 
	;Add your new keywords and / or formlists to the vanilla ones here
	;=======================================================

	VanillaWorkshopMenu.addForm(CustomWorkshopMenu)
	VanillaWorkshopMenu.addForm(CustomWorkshopCategory)
	;...
	
	;"if (Menu.hasForm(form))" is not needed, because formlists cannot contain the same form twice
EndFunction

;====================================================================================================================
;Remove your new forms manually (for example using an uninstall chem...). This will not work if your mod has already 
;been uninstalled.
;====================================================================================================================

;This Function is called to uninstall your new categories manually and will only work as long as your mod is still 
;active.
Function uninstall_manually()
	;TODO This function is called to uninstall your mod. Remove all forms you added above here.	
	;=======================================================
	VanillaWorkshopMenu.RemoveAddedForm(CustomWorkshopMenu)
	VanillaWorkshopMenu.RemoveAddedForm(CustomWorkshopCategory)
	;...
EndFunction

;TODO - Remove everything belwo if your don't want to call a possibly endless while loop
;====================================================================================================================
;Remove none values automatically after your mod was uninstalled. This will not work if your mod is still active.
;====================================================================================================================

;Checks if your plugin is still active. If not removes every none value from the vanilla formlists.
Function checkForUninstall()
	;we only want the loop once
	if (!uninstallCheckRunning)
		uninstallCheckRunning = true
		;TODO - replace YourMod.esp with the name of your esp
		while (Game.IsPluginInstalled("YourMod.esp"))
			Utility.wait(60) ;waits 60 seconds until the condition is checked again
		endwhile
		;The plugin is no longer active. Now we have to remove every none value from the edited formlists.

		;TODO - Do this with every vanilla menu you edited
		removeNoneValues(VanillaWorkshopMenu)
		;...
		uninstallCheckRunning = false
	endif 
EndFunction

;This function removes all none values from a formlist. 
Function removeNoneValues(Formlist flst)
	Formlist temp = flst
	;revert the formlist to remove every form that was added with a script, including forms of other plugins
	VanillaWorkshopMenu.revert()
	int i = 0
	while (i < temp.getSize()) 
		if (temp.getAt(i)) ;true if the form at index i is not none
			flst.addForm(temp.getAt(i))
			;"if (Menu.hasForm(form))" is not needed, because formlists cannot contain the same form twice
		endif
		i+=1
	endwhile
EndFunction
