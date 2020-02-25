#target Illustrator
// JavaScript from forum below, titled: Please help to create "Unlonk All, Create Outlines, Embed" Scrpit. :)
//
// https://forums.adobe.com/message/10531441#10531441
// https://forums.adobe.com/message/10532624#10532624
//
// https://forums.adobe.com/message/10236331#10236331
// Unlock all layers & sublayers
processLayersRecursive(app.activeDocument.layers);
// Process all layers under variable "parent" (including sublayers on all levels).
function processLayersRecursive(parent) {
	for (var iLayer = 0; iLayer < parent.length; iLayer++) {
		var curLayer = parent[iLayer];
		// Unlock the current layer
		if (curLayer.locked) {
			curLayer.locked = false;
		}
		processLayersRecursive(curLayer.layers);
	}
}
// Unlock all objects, select all & convert text to outlines
// https://ten5963.wordpress.com/illustrator-ccver-22-menu-commands-list/
app.executeMenuCommand('unlockAll');
app.executeMenuCommand('selectall');
app.executeMenuCommand('outline');
// https://forums.adobe.com/message/10531441#10531441
// Embed all linked images
if (app.documents.length > 0) {
	while (app.activeDocument.placedItems.length > 0) {
		placedArt = app.activeDocument.placedItems[0];
		placedArt.embed();
	}
}
// Deselect all
app.executeMenuCommand('deselectall');