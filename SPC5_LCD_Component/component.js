/**
 * 
 */

function begin(xmlRoot) {
	// Do Nothing
	return;
}

function end(xmlRoot) {
	// Do Nothing
	return;
}

function doesPinIdentifierExist(xmlRoot, currentNode) {
	var identifier = currentNode.getChild("value").getText();
	if( identifier.length > 0) {
		var xpathQuery = "count(/SPC5-Config/application/instances//i_o_settings/pins_list//pin_identification/identifier/value[text()='";
		xpathQuery = xpathQuery + identifier;
		xpathQuery = xpathQuery + "'])";
		return handler.evaluateXPath(xmlRoot,xpathQuery)[0]==1;
	} else {
		return true;
	}
}
