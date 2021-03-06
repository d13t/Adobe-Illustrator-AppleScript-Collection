-- Info Panel – v1
-- Creates information panel on a separate layer
-- ©2020 – @dtrkrs

--Variables
set theDate to (do shell script ("date +%d-%m-%Y"))
set theDesigner to long user name of (system info) as string
set theLabCount to 0

tell application "Adobe Illustrator"
	activate
	
	set theDoc to current document
	
	-- Check whether or not document is RGB
	set docColour to color space of theDoc
	if docColour is RGB then
		display alert "Warning!" & return & return & "Artwork is RGB" message ¬
			"Hey, " & theDesigner & "! " & return & return & "The document color mode is set to RGB." & return & return & ¬
			"Please convert the color mode to CMYK" & return & ¬
			"to use this script." buttons {"OK"} default button 1 as critical
		return -- This stops the script
	end if
	
	-- Create layer "Info Panel"
	tell theDoc
		if exists layer "Info Panel" then
			set layerProp to the properties of layer "Info Panel"
			try
				set properties of layer "Info Panel" to {locked:false, visible:true}
			end try
			set layerItems to every page item of layer "Info Panel"
			repeat with anItem in layerItems
				try
					set properties of anItem to {locked:false, hidden:false}
				end try
			end repeat
			delete every item of layer "Info Panel"
			set theLayer to make layer with properties {name:"Info Panel", color:{class:RGB color info, red:255.0, green:78.692607003891, blue:78.692607003891}}
		else
			set theLayer to make layer with properties {name:"Info Panel", color:{class:RGB color info, red:255.0, green:78.692607003891, blue:78.692607003891}}
		end if
	end tell
	
	-- Starting coordinates
	set centerPoint to center point of view 1 of theDoc
	set orx to item 1 of centerPoint
	set ory to item 2 of centerPoint
	
	-- Setting text properties, be sure font Acumin Pro Condensed is activated	
	set textRegular1 to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}, justification:left, size:9, auto leading:false, leading:9, text font:text font "AcuminProCond-Regular"}
	set textRegular2 to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}, justification:left, size:9, auto leading:false, leading:10, text font:text font "AcuminProCond-Regular"}
	set textBold to {text font:text font "AcuminProCond-Semibold"}
	set textCaps to {capitalization:all caps}
	set textWhite to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}}
	-- Setting block properties
	set lineBlock to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:2.0}, stroke color:{cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}, stroke width:0.5}
	set blackBlock to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}}
end tell

-- Yet another group
tell application "Adobe Illustrator"
	tell theDoc
		set myInfoPanelGroup to make group item at beginning of theLayer with properties {name:"Info Panel Group"}
	end tell
end tell

--Address Module 
tell application "Adobe Illustrator"
	set theModule to "Address"
	
	-- Make group
	set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
	
	-- Module
	set orx to ((item 1 of centerPoint) - 6) --6pt margin left
	set ory to ((item 2 of centerPoint) + 20) --move it up 14 pt and 6pt margin
	set heightModule to 48
	set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx + 6, ory + 11}, height:59, width:108}
	--Address, fill in your company address
	set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, ¬
	contents:"Company Name" & return & "Streetname Number" & return & "Postal Code City" & return & "Country" & return & "Telephone" & return & "Email"}
	set properties of the text of theText to textRegular1
	set properties of characters 1 thru 16 of the text of theText to textBold & textCaps
	set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{orx, ory + 17, orx + 120, ory - heightModule}} & lineBlock
	
	-- Get the size of this module to start the next module
	set theBounds to geometric bounds of myGroup
	set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
	set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
	set boundR to (item 3 of theBounds) --myRightmostCoordinate
	set boundB to (item 4 of theBounds) -- myBottommostCoordinate	
end tell

--Changes to this document are only authorized if Mascot Europe has been informed and given approval.  
tell application "Adobe Illustrator"
	set theModule to "Authorization"
	
	-- Make group
	set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
	
	-- Module	
	set theRectanglePath to make new rectangle at end of myGroup with properties {position:{boundL + 6, boundB - 6}, height:32, width:108}
	set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, ¬
	contents:"Do not change or modify this file without the approval of Company Name."}
	set properties of the text of theText to textRegular1
	set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB, boundR, (boundB + (boundB - boundT) + 27)}} & lineBlock
	
	-- Get the size of this module to start the next module
	set theBounds to geometric bounds of myGroup
	set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
	set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
	set boundR to (item 3 of theBounds) --myRightmostCoordinate
	set boundB to (item 4 of theBounds) -- myBottommostCoordinate
end tell

--Date & Designer
tell application "Adobe Illustrator"
	set theModule to "Date"
	
	-- Make group
	set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
	
	-- Module	
	set theRectanglePath to make new rectangle at end of myGroup with properties {position:{boundL + 6, boundB - 6}, height:23, width:108}
	set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, contents:("Date: " & theDate & return & "Designer: " & theDesigner)}
	set properties of the text of theText to textRegular2
	set properties of characters 1 thru 5 of the text of theText to textBold & textCaps --DATE:
	set properties of characters 18 thru 26 of the text of theText to textBold & textCaps --DESIGNER: (return is also a character)
	set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB, boundR, (boundB + (boundB - boundT) + 9)}} & lineBlock
	
	-- Get the size of this module to start the next module
	set theBounds to geometric bounds of myGroup
	set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
	set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
	set boundR to (item 3 of theBounds) --myRightmostCoordinate
	set boundB to (item 4 of theBounds) -- myBottommostCoordinate
end tell

--Swatches 
tell application "Adobe Illustrator"
	set theModule to "Swatches"
	
	-- Make group
	set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
	
	--Question.
	--set theFullColour to {"All (CMYK)", "Cyan", "Magenta", "Yellow", "Black"}
	set theFullColour to {"Cyan", "Magenta", "Yellow", "Black"}
	
	set myCMYK to (choose from list theFullColour with title "CMYK colours" with prompt "Select (⌘) which CMYK colours are being used:" with multiple selections allowed and empty selection allowed)
	
	-- Get spot colors
	set mySwatches to get every swatch of theDoc whose color contains {class:spot color info, tint:100.0}
	
	-- Keeping count of all the CMYK and Spot Swatches, this will determine height of module
	set theCount to 0
	
	--Title
	set theText to make new text frame at end of myGroup with properties {kind:point text, contents:"Colours", position:{boundL + 6, boundB - 3}}
	set properties of the text of theText to textRegular1
	set properties of the text of theText to textBold & textCaps
	
	-- Make spot color swatches
	repeat with aSwatch in mySwatches
		set swatchName to get the name of aSwatch as string
		-- get spot color info of swatch
		set spotNumber to get spot of color of aSwatch
		set spotKind to spot kind of spotNumber
		-- if it is not PANTONE Lab color swatch, excluding spot cmyk color and spot rgb color and [Registration]
		if spotKind = spot lab color then
			-- Drawing the spot color swatches
			make new rectangle at end of myGroup with properties {name:("Swatch " & swatchName), bounds:{boundL + 6, boundB - 20, boundL + 20, boundB - 34}, fill color:{class:spot color info, spot:spotNumber, tint:100}, stroke color:{class:no color info}, stroke width:0}
			set theText to make new text frame at end of myGroup with properties {kind:point text, contents:swatchName, position:{boundL + 22, boundB - 20}}
			set properties of the text of theText to textRegular1
			set boundB to boundB - 17 --change position for the next swatch; next line
			set theCount to theCount + 1
			set theLabCount to theCount --counting only spot lab colors
		end if
	end repeat
	
	-- Make CMYK swatches
	if myCMYK ≠ false then
		repeat with aCMYK in myCMYK
			set CMYKname to aCMYK as string
			
			--if CMYKname is "All (CMYK)" then
			--All CMYK colors are being used
			
			if CMYKname is "Cyan" then
				--Cyan
				set swatchName to "Cyan"
				set theFill to {cyan:100.0, magenta:0.0, yellow:0.0, black:0.0}
			else if CMYKname = "Magenta" then
				--Magenta
				set swatchName to "Magenta"
				set theFill to {cyan:0.0, magenta:100.0, yellow:0.0, black:0.0}
			else if CMYKname = "Yellow" then
				--Yellow
				set swatchName to "Yellow"
				set theFill to {cyan:0.0, magenta:0.0, yellow:100.0, black:0.0}
			else
				--He's Black?	
				set swatchName to "Black"
				set theFill to {cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}
			end if
			make new rectangle at end of myGroup with properties {name:("Swatch " & swatchName), bounds:{boundL + 6, boundB - 20, boundL + 20, boundB - 34}, fill color:theFill, stroke color:{class:no color info}, stroke width:0}
			set theText to make new text frame at end of myGroup with properties {kind:point text, contents:swatchName, position:{boundL + 22, boundB - 20}}
			set properties of the text of theText to textRegular1
			set boundB to boundB - 17 --change position for the next swatch; next line
			set theCount to theCount + 1
		end repeat
	end if
	
	--  Module block
	set heightModule to (theCount * 17)
	set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB + heightModule, boundR, boundB - 6 - 17}} & lineBlock
	
	-- Get the size of this module to start the next module
	set theBounds to geometric bounds of myGroup
	set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
	set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
	set boundR to (item 3 of theBounds) --myRightmostCoordinate
	set boundB to (item 4 of theBounds) -- myBottommostCoordinate			
end tell

--White layer 
tell application "Adobe Illustrator"
	display dialog "You want a white layer warning?" buttons {"No", "Yes"} default button 1
	set uWhite to the button returned of the result
	if uWhite is "Yes" then
		set theModule to "White layer"
		
		-- Make group
		set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
		
		-- Module	
		set theRectanglePath to make new rectangle at end of myGroup with properties {position:{boundL + 6, boundB - 6}, height:14, width:108}
		set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, contents:"File contains a white layer!"}
		set properties of the text of theText to textRegular1
		set properties of the text of theText to textBold & textWhite
		set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB, boundR, boundB - 20}} & lineBlock
		set properties of theBlock to blackBlock
		
		-- Get the size of this module to start the next module
		set theBounds to geometric bounds of myGroup
		set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
		set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
		set boundR to (item 3 of theBounds) --myRightmostCoordinate
		set boundB to (item 4 of theBounds) -- myBottommostCoordinate		
	end if
end tell

--Notes 
tell application "Adobe Illustrator"
	set theModule to "Notes"
	
	-- Make group
	set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
	
	-- get the notes
	display dialog "Notes:" default answer "" buttons {"OK"} default button 1
	set myNotes to the text returned of the result
	set countNotes to count every character of myNotes
	set estimateLines to (countNotes / 33) as integer
	if myNotes ≠ "" then
		-- Module
		set heightModule to 20 + (estimateLines * 9)
		set theRectanglePath to make new rectangle at end of myGroup with properties {position:{boundL + 6, boundB - 6}, height:heightModule, width:108}
		set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, contents:"Notes" & return & myNotes}
		set properties of the text of theText to textRegular1
		set properties of characters 1 thru 5 of the text of theText to textBold & textCaps
		set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB, boundR, boundB - (heightModule + 12)}} & lineBlock
		
		-- Get the size of this module to start the next module
		set theBounds to geometric bounds of myGroup
		set boundL to (item 1 of theBounds) --myLeftmostCoordinate, x
		set boundT to (item 2 of theBounds) --myTopmostCoordinate, y
		set boundR to (item 3 of theBounds) --myRightmostCoordinate
		set boundB to (item 4 of theBounds) -- myBottommostCoordinate		
	end if
end tell

--Important 
tell application "Adobe Illustrator"
	--if there are no spot colors, then no warning
	if theLabCount is not 0 then
		set theModule to "Important"
		
		-- Make group
		set myGroup to my makeGroup(theModule, myInfoPanelGroup, theDoc)
		
		-- Module
		set theRectanglePath to make new rectangle at end of myGroup with properties {position:{boundL + 6, boundB - 6}, height:41, width:108}
		set theText to make new text frame at beginning of myGroup with properties {name:"Content", kind:area text, text path:theRectanglePath, contents:"IMPORTANT" & return & "When PANTONE colours are used, the colours must be matched with the official PANTONE guide."}
		set properties of the text of theText to textRegular1
		set properties of characters 1 thru 9 of the text of theText to textBold & textCaps
		
		set theBlock to make new rectangle at end of myGroup with properties {name:"Block", bounds:{boundL, boundB, boundR, boundB - 41 - 6}} & lineBlock
	end if
end tell

-- Make group
on makeGroup(theModule, myInfoPanelGroup, theDoc)
	tell application "Adobe Illustrator"
		tell theDoc
			set myGroup to make group item at beginning of myInfoPanelGroup with properties {name:theModule}
		end tell
	end tell
	return myGroup
end makeGroup