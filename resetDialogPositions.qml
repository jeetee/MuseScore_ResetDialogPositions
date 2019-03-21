import QtQuick 2.0
import MuseScore 3.0

import Qt.labs.settings 1.0

MuseScore {
	menuPath: "Plugins.Reset Dialog Positions"
	//pluginType: "dialog"
	version: "2.0"
	description: "Erases positioning information for GUI dialogs"
	requiresScore: false

	Settings {
		id: settings
		category: "MainWindow" //need to start somewhere
		property size size
		property point pos
	}

	onRun: {
		var defaults = [
			{ cat: "Debugger", sizeW: 1000, sizeH: 500, posX: 10, posY: 10 },
			{ cat: "Drumroll", sizeW: 900, sizeH: 500, posX: 10, posY: 10 },
			{ cat: "EditStaff", sizeW: 484, sizeH: 184, posX: 10, posY: 10 },
			{ cat: "PartEditor", sizeW: 484, sizeH: 184, posX: 10, posY: 10 },
			{ cat: "Instruments", sizeW: 800, sizeH: 500, posX: 10, posY: 10 },
			{ cat: "Mixer", sizeW: 600, sizeH: 480, posX: 10, posY: 10 }, //484x184 in useFactory, but 622x143 in .ui, going for a sensible inbetween value
			//{ cat: "MainWindow", sizeW: 1024, sizeH: 768, posX: 10, posY: 10 }, //can't do this from within the plugin, as closing MuseScore overwrites us anyhow
			{ cat: "Pianoroll", sizeW: 900, sizeH: 500, posX: 10, posY: 10 },
			{ cat: "playPanel", sizeW: null, sizeH: null, posX: 300, posY: 100 }, //DEFAULT_POS_X and DEFAULT_POS_Y
			{ cat: "Startcenter", sizeW: 720, sizeH: 570, posX: 200, posY: 100 },
			{ cat: "SynthControl", sizeW: 746, sizeH: 268, posX: 10, posY: 10 }
		];

		console.log("Start resetting...");
		for (var g in defaults) {
			console.log("\t" + defaults[g].cat);
			settings.category = defaults[g].cat;
			if (defaults[g].sizeW && defaults[g].sizeH) {
				settings.size = Qt.size(defaults[g].sizeW, defaults[g].sizeH);
			}
			settings.pos = Qt.point(defaults[g].posX, defaults[g].posY);
		}
		console.log("...Done");

		cmd("quit"); //close musescore
		Qt.quit();
	}

}
