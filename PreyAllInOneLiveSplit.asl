/* by NemoIsBae_ */

state("Prey" , "1.0.0.0-STEAM") {

}

state("Prey" , "1.0.1.0-STEAM") {

}

state("Prey" , "1.0.1.0-EPIC") {
	//get area names	
	string32 areaName1 : "PreyDll.dll", 0x02C1FFE0, 0x4; // only steam
	// string64 areaName2 : "PreyDll.dll", 0x0224D988, 0xA70; // only steam


	string64 areaName2 : "PreyDll.dll", 0x024AB6C0, 0x90, 0x8, 0xE8; // only epic
	
    //for areaName2 | addr = "PreyDll.dll"+024AB6C0 offset0 = 90 offset1 = 8 offset2 = E8

    // areaName1: apartment
    // areaName2: levels/campaign/research/simulationlabs/

    /*
        7FAA7FC3C5D0    
    */


	/* string32 areaName2 : 0x02BF3D08, 0x100, 0x418, 0x5A8, 0x8, 0x10, 0x40; */
	//mooncrash area
	// string64 MooncrashAreaDatafile : "PreyDll.dll", 0x2D9AE38;
	//area name , mooncrash directly launched from steam
	// string64 MooncrashAreaName1 : "PreyDll.dll", 0x026269D0, 0x20, 0x730, 0x48, 0x4C, 0x48;
	
	//get loading status

    /*
		Only Epic loading bool change only if you dont quick save quick load or reload same zone
	*/

	bool isLoadingWithoutQuick : "PreyDll.dll", 0x024185C8, 0x14;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417A00, 0xBE0;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417A00, 0xC00;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417890, 0xD40;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417450, 0xD88;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417870, 0xDD8;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x024177C0, 0xE10;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02417370, 0xE58;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x024177A0, 0xEB8;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x024175F0, 0xFE0;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x02241940, 0x50, 0xA28;
	// bool isLoadingWithoutQuick : "PreyDll.dll", 0x0242E4A8, 0x50, 0xA28;



	bool isLoading : "bink2w64.dll", 0x58000; // not working
	/*
	 7FFE707BC010
	
	  bink2w64.dll+4C6D8
	*/

	/*
		7FFE707BCB30

		offset 158 ???

	  bink2w64.dll+4C6B8
	  bink2w64.dll+4CC98


	*/


	/*
		Get triger when quick load
	*/
	bool isInCutscene : "bink2w64.dll", 0x58538, 0x184; 
	

	/*
		Get triger when you interact with last run button

		= 3 go to = 0 if lastcutscene 
	*/

	byte isInCutsceneWithoutQuickLoad : "bink2w64.dll", 0x57AF8, 0x30; 

	// 7FF1C9F8008
	// 7FF1C9F800C

	// 7FFF1C9F7A80 offset = 30  bink2w64.dll+57AF8


	/*
		------ ENUM menuMode -------
		0 = ingame, 2 = waiting input after load, 3 = pause menu
	*/
		// byte menuMode1 : "PreyDll.dll", 0x02C25930, 0x8, 0xA0, 0x10, 0x18, 0x10, 0xBC, 0x1E0; // only steam


	/*
		ONLY EPICGAME VERSION
	*/

	// byte menuMode1 : "PreyDll.dll", 0x02B33468, 0x48, 0x40, 0x60, 0x8, 0x30, 0xA8, 0x1E0; // destroy after pc restart
	// byte menuMode1 : "PreyDll.dll", 0x02B33468, 0x48, 0x40, 0x58, 0xA8, 0x30, 0xA8, 0x1E0; // destroy after pc restart


	// byte menuMode1 : "PreyDll.dll", 0x0226B350, 0x0, 0x10, 0xA8, 0x30, 0x98, 0x1E0; // strange value sometime
	// byte menuMode1 : "PreyDll.dll", 0x0226B350, 0x0, 0x10, 0xB0, 0x60, 0x30, 0x98, 0x1E0; // strange value sometime

	byte menuMode1 : "PreyDll.dll", 0x0226B350, 0x0, 0x10, 0xA8, 0x30, 0x68, 0x38, 0x1E0; // stay at good value in loading become "???"



	//int isLoadingMooncrash: "PreyDll.dll", 0x02626C18, 0x18, 0x10, 0x80, 0x218, 0xE0;
}

startup {
	//promt for game time
	settings.Add("timerPopup", true, "Prompt to use Loadless on startup");
	//promt for beta stage of auto splitter
	settings.Add("betaPopup", true, "Prompt to inform that the Autosplitter is in Beta");
    //for steam/epic
	settings.Add("isSteam", true, "If checked your play on STEAM version. You need to uncheck if you play on EPIC version");

	vars.split = false;


	print("[PREY AIO] STARTUP");

}

init {
	print("[PREY AIO] moduleMemorySize: " + modules.First().ModuleMemorySize.ToString());
	
	//Latest and mooncrash
	//581632
	//release
	//171769856

	if (modules.First().ModuleMemorySize == 171769856) {
		version = "1.0.0.0-STEAM";
		print("[PREY AIO] 1.0.0.0-STEAM Patch");
	} else if (modules.First().ModuleMemorySize == 581632) {
        if (settings["isSteam"]) {
		    version = "1.0.1.0-STEAM";
		    print("[PREY AIO] 1.0.1.0-STEAM Patch");
        } else {
		    version = "1.0.1.0-EPIC";
		    print("[PREY AIO] 1.0.1.0-EPIC Patch");
        }
	}
	

	//if the timer is in real time, ask if the user want to change it to game time
	if ((settings["timerPopup"]) && timer.CurrentTimingMethod == TimingMethod.RealTime)
	{        
		var timingMessage = MessageBox.Show
		("This game uses Loadless (Game Time) as the main timing method.\n"+
		"LiveSplit is currently set to show RTA (Real Time).\n"+
		"Would you like to set the timing method to Game Time?",
		"Prey (2017) | LiveSplit",
		MessageBoxButtons.YesNo,MessageBoxIcon.Question);
	
		if (timingMessage == DialogResult.Yes) {
			timer.CurrentTimingMethod = TimingMethod.GameTime;
		}
	}
	
	if (settings["betaPopup"]) {
		var betaMessage = MessageBox.Show
		("IMPORTANT: auto splitter is in Beta.\n" +
		"Bugs can still be present\n\n" + 
		"/!\\ don\'t forget to uncheck isSteam in setting if you play on EPIC version /!\\",
		"Prey (2017) | LiveSplit",
		MessageBoxButtons.OK);	
	}
	
	if ((settings["splitPopup"]) && timer.Run.CategoryName != "Any%") {	
		var timingMessage = MessageBox.Show
		("Auto Splitting fuctionality is currently only available for Any%.\n"+
		"Another category is selected, therefore splitting must be performed manually.",
		"Prey (2017) | LiveSplit",
		MessageBoxButtons.OK);
	}

	print("[PREY AIO] INIT");
}


start {

	print("areaName1: " + current.areaName1);
	print("areaName2: " + current.areaName2);
	print("menuMode1: " + current.menuMode1);

	/*
		Without areaName1 is work can make trouble later ?
	*/

	//start the run
	if (current.menuMode1 == 0 && old.menuMode1 == 2) {
		// if(current.areaName1 == "apartment") {
			if(current.areaName2.Contains("/simulationlabs")) {
				vars.split = false;

				return true;
			}		
		// }
	}	
}

exit {
	timer.IsGameTimePaused = true;
}

/*
	See that later
*/

// reset {
	// if(current.isLoadingTextures == 1 && current.areaName1 == "apartment" && current.areaName2.Contains("/simulationlabs")) {
	// 	return true;
	// }
// }

update {
	/*
		Prevent multiple split for one load
	*/

	if (vars.split == true && current.isLoadingWithoutQuick == false && old.menuMode1 == 2 && current.menuMode1 == 0) {
		vars.split = false;
	}
}

split {	
	print("[nemo] ==========================================");
	print("[nemo] current menuMode1: " + current.menuMode1);
	print("[nemo] old menuMode1: " + old.menuMode1);
	print("[nemo] areaName2: " + current.areaName2);
	print("[nemo] isLoadingWithoutQuick: " + current.isLoadingWithoutQuick);
	print("[nemo] isInCutsceneWithoutQuickLoad: " + current.isInCutsceneWithoutQuickLoad);
	print("[nemo] isInCutscene: " + current.isInCutscene);

	if (vars.split == false) {
		/*
			Need to split by an other way on last split of any% because "isLoadingWithoutQuick" = true on last split when you quick load
		*/
		if (current.areaName2.Contains("/bridge")) {
			if (current.isInCutsceneWithoutQuickLoad == 0 && current.isInCutscene && old.menuMode1 == 0 && current.menuMode1 == 0) {
				print("[nemo] LAST SPLIT END");

				vars.split = true;
				return true;
			} else {
				return false;
			}
		} else if (current.isLoadingWithoutQuick) {
			print("[nemo] SPLIT");

			vars.split = true;
			return true;
		} else {
			return false;
		}
	} else {
		return false;
	}
}

isLoading {
	// print("isLoading");

	// print("[nemo] ==============================================");
	// print("[nemo] areaName1: " + current.areaName1);

	// print("[nemo] isLoading: " + current.isLoading);
	// print("[nemo] isLoadingMain: " + current.isLoadingMain);
	// print("[nemo] isLoadingTextures: " + current.isLoadingTextures);
	// print("[nemo] menuMode1: " + current.menuMode1);
	// print("[nemo] isLoadingWithoutQuick: " + current.isLoadingWithoutQuick);
	// print("[nemo] isInCutscene: " + current.isInCutscene);
	// print("[nemo] areaName2: " + current.areaName2);


	//old check if the game is loading
	// return
	// 	current.isLoading ||
	// 	current.isLoadingMain ||
	// 	current.isLoadingTextures == 1 ||
	// 	current.menuMode1 == 2;	
		
	/*
		checking if the game loading
	*/
	
	return
		current.isLoadingWithoutQuick ||
		current.menuMode1 == 2;
}