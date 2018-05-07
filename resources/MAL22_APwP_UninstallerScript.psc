scriptname MAL22_APwP_UninstallerScript extends ActiveMagicEffect

MAL22_APwP_InstallerScript property MAL22_APwP_Installer auto const

Event onEffectStart(Actor akTarget, Actor akCaster)
	MAL22_APwP_Installer.uninstallMe()
EndEvent
