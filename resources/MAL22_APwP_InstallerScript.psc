ScriptName MAL22_APwP_InstallerScript extends Quest

Group CustomWorkshopMenus
	Keyword property ap_MAL22_Bot_FrontArmorDecal auto const
	{A category you want to add to a vanilla menu}
	FormList property DLC01WorkbenchRobotListPaint auto const
	{Automatron Paint FormList}
EndGroup

Event OnQuestInit()
	Debug.trace("Installing APwP")
	Debug.Notification("Installing APwP")
	installMe()
	
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	
	Debug.trace("APwP installed")	
	Debug.Notification("APwP installed")
;	checkForUninstall()
EndEvent

;bool uninstallCheckRunning = false

;-- Functions ----------------------------------------------

Event Actor.OnPlayerLoadGame(Actor source)
	installMe()
;	checkForUninstall()
EndEvent		
	
;This function adds your new menus or categories to the vanilla formlists
Function installMe()
	if(!DLC01WorkbenchRobotListPaint.HasForm(ap_MAL22_Bot_FrontArmorDecal))
		DLC01WorkbenchRobotListPaint.AddForm(ap_MAL22_Bot_FrontArmorDecal)
		Debug.Trace("APwP decal added")
	endif
EndFunction

Function uninstallMe()
	Debug.trace("Uninstalling APwP")	
	Debug.Notification("Uninstalling APwP")
	
	DLC01WorkbenchRobotListPaint.RemoveAddedForm(ap_MAL22_Bot_FrontArmorDecal)
	UnregisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	self.stop()
	
	Debug.trace("APwP Uninstalled")	
	Debug.Notification("APwP Uninstalled")
EndFunction

;Function checkForUninstall()
;	if (!uninstallCheckRunning)
;		uninstallCheckRunning = true
;
;		while (Game.IsPluginInstalled("AutomatronPrewarPaints.esp"))
;			Utility.wait(180)
;		endwhile
;
;		removeNoneValues(DLC01WorkbenchRobotListPaint)
;
;		Debug.trace("APwP uninstalled")	
;		Debug.Notification("APwP uninstalled")
;		
;		uninstallCheckRunning = false
;	endif 
;EndFunction

;Function removeNoneValues(Formlist flst)
;	Formlist temp = flst
;
;	flst.revert()
;	int i = 0
;	while (i < temp.getSize()) 
;		if (temp.getAt(i)) ;true if the form at index i is not none
;			flst.addForm(temp.getAt(i))
;		endif
;		i+=1
;	endwhile
;EndFunction
