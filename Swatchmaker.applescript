-- Swatchmaker - v3.0.2
-- *This script requires you delete all unused swatches from the Swatches panel prior to run*
-- @dtrkrs

tell application "Adobe Illustrator"
	activate
	
	-- Exclude swatches list
	set myExcluded to {"[Registration]", "[Registratie]", "size", "stans", "diecut", "Diecut", "die cut", "cutter", "CUTTER", "CONTOUR", "Standtekening", "Tubemaat", "EUROLOG", "DIELINE"} -- a list of the swatches to exclude
	
	set theDoc to current document
	
	tell theDoc
		-- Check whether or not document is RGB
		set docColour to color space
		if docColour is RGB then
			display alert "RGB" message Â
				"The document's color space is RGB." & return & return & Â
				"Please convert the color space to CMYK" & return & Â
				"to properly run this script." buttons {"OK"} default button 1
			-- Stops the script
			return
		end if
	end tell
	
	tell theDoc
		-- CMYK swatch or not?
		display dialog "Include CMYK Swatch?" buttons {"No", "Yes"} default button 2
		set FullColor to the button returned of the result
		
		-- Reset ruler origin to 0,0
		set properties to {ruler origin:{0, 0}}
		
		-- Starting coordinates
		set centerpee to center point of view 1
		set cpX to item 1 of centerpee
		set cpY to item 2 of centerpee
		set orx to 0 + cpX
		set ory to -76 + cpY
		set oryb to -76 + cpY
		set oryc to -78 + cpY
		
		-- Let's see if the active layer is locked or not.
		set theLayer to the current layer
		set theLayProp to the properties of theLayer
		if theLayProp contains {locked:true} then
			display alert "Locked layer" message "The active layer is locked." & return & "Unlock this layer or select an unlocked layer." buttons {"OK"} default button 1
		else
			-- Get spot colors
			set mySpotlist to get every swatch whose color contains {class:spot color info, tint:100.0}
			
			-- Group swatches
			set myGroup to my makeGroup(theLayer, theDoc)
			
			-- Make spot color swatches
			repeat with theSpot in mySpotlist
				set swatchname to get the name of theSpot as string
				if the swatchname is not in myExcluded then --ignore certain swatches
					set spotnumber to get spot of color of theSpot
					-- Drawing the swatches
					make new rectangle at end of myGroup with properties {bounds:{orx, ory, orx + 42, ory + 42}, fill color:{class:spot color info, spot:spotnumber, tint:100}, stroke width:0, stroke color:{class:no color info}}
					set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx, oryc + 14}, height:12, width:42} -- 14pt up
					set theText to make new text frame at beginning of myGroup with properties {name:swatchname, kind:area text, text path:theRectanglePath, contents:swatchname} -- text on top
					set properties of the text of theText to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}, justification:center, size:4.5, leading:5} -- white text, leading adjusted, centered, no indent
					set orx to orx + 49 --change position for the next swatch
				end if
			end repeat
			
			-- Make CMYK swatches
			if FullColor is "Yes" then
				--Make Cyan swatch
				set swatchname to "C"
				make new rectangle at end of myGroup with properties {bounds:{orx, ory + 21, orx + 21, ory + 42}, fill color:{cyan:100.0, magenta:0.0, yellow:0.0, black:0.0}, stroke width:0, stroke color:{class:no color info}}
				set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx, oryc + 30}, height:12, width:21}
				set theText to make new text frame at beginning of myGroup with properties {name:swatchname, kind:area text, text path:theRectanglePath, contents:swatchname} -- text on top
				set properties of the text of theText to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}, justification:center, size:4.5, leading:5} -- white text, leading adjusted, centered, no indent
				set orx to orx + 21
				--Make Magenta swatch
				set swatchname to "M"
				make new rectangle at end of myGroup with properties {bounds:{orx, ory + 21, orx + 21, ory + 42}, fill color:{cyan:0.0, magenta:100.0, yellow:0.0, black:0.0}, stroke width:0, stroke color:{class:no color info}}
				set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx, oryc + 30}, height:12, width:21}
				set theText to make new text frame at beginning of myGroup with properties {name:swatchname, kind:area text, text path:theRectanglePath, contents:swatchname} -- text on top
				set properties of the text of theText to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}, justification:center, size:4.5, leading:5} -- white text, leading adjusted, centered, no indent
				set orx to orx - 21
				set ory to ory - 21
				--Make Yellow swatch
				set swatchname to "Y"
				make new rectangle at end of myGroup with properties {bounds:{orx, ory + 21, orx + 21, ory + 42}, fill color:{cyan:0.0, magenta:0.0, yellow:100.0, black:0.0}, stroke width:0, stroke color:{class:no color info}}
				set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx, oryc + 9}, height:12, width:21}
				set theText to make new text frame at beginning of myGroup with properties {name:swatchname, kind:area text, text path:theRectanglePath, contents:swatchname} -- text on top
				set properties of the text of theText to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}, justification:center, size:4.5, leading:5} -- white text, leading adjusted, centered, no indent
				set orx to orx + 21
				--Make Black swatch
				set swatchname to "K"
				make new rectangle at end of myGroup with properties {bounds:{orx, ory + 21, orx + 21, ory + 42}, fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:100.0}, stroke width:0, stroke color:{class:no color info}}
				set theRectanglePath to make new rectangle at end of myGroup with properties {position:{orx, oryc + 9}, height:12, width:21}
				set theText to make new text frame at beginning of myGroup with properties {name:swatchname, kind:area text, text path:theRectanglePath, contents:swatchname} -- text on top
				set properties of the text of theText to {fill color:{cyan:0.0, magenta:0.0, yellow:0.0, black:0.0}, justification:center, size:4.5, leading:5} -- white text, leading adjusted, centered, no indent
				--set orx to orx + 49 --if you want to add another swatch
			end if
			
		end if
	end tell
	-- Set all text of swatches to system font Helvetica Bold
	try
		set selection to every text frame of group item "Swatches" of theDoc
		set text font of text of selection of theDoc to text font "Helvetica-Bold"
	end try
end tell

-- Make group
on makeGroup(theLayer, theDoc)
	tell application "Adobe Illustrator"
		tell theDoc
			if exists group item "Swatches" then
				set myGroup to group item "Swatches"
			else
				set myGroup to make group item at beginning of theLayer with properties {name:"Swatches"}
			end if
		end tell
	end tell
	return myGroup
end makeGroup