--Create Crop Marks v1
-- This script create cropmarks around a selected object (preferable a single reactangle).
-- Somehow this script doesn't work all the time
-- @dtrkrs
tell application "Adobe Illustrator"
	tell document 1
		set mySel to selection
		if mySel is {} then
			display dialog "Please select an object."
			return
		end if
		set myItem to item 1 of mySel
		set myBounds to geometric bounds of myItem
		my makeCrop(myBounds)
	end tell
end tell

on makeCrop(myBounds)
	tell application "Adobe Illustrator"
		tell document 1
			-- selection
			--set mySel to selection
			--set myItem to item 1 of mySel
			--set myBounds to geometric bounds of myItem
			set myX to (item 1 of myBounds)
			set myYh to (item 2 of myBounds)
			set myXb to (item 3 of myBounds)
			set myY to (item 4 of myBounds)
			-- dimensions
			set myCropMarkLength to "17"
			set myCropMarkOffset to "5"
			set myCropMarkWidth to "0.25"
			-- color
			set spotnumber to get spot of color of swatch "[Registration]"
			-- dimensions to algebra
			set myA to {myCropMarkLength + myCropMarkOffset} as string
			set myB to myCropMarkOffset
			--get the group
			set myGroup to my makeGroup()
			--drawing the cropmarks
			--linksonder
			make new path item at end of myGroup Â
				with properties {name:"p1", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myX - myA), (myY)}, point type:corner}, {anchor:{(myX - myB), (myY)}, point type:corner}}}
			make new path item at end of myGroup Â
				with properties {name:"p2", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myX), (myY - myB)}, point type:corner}, {anchor:{(myX), (myY - myA)}, point type:corner}}}
			--rechtsonder
			make new path item at end of myGroup Â
				with properties {name:"p3", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myXb + myB), (myY)}, point type:corner}, {anchor:{(myXb + myA), (myY)}, point type:corner}}}
			make new path item at end of myGroup Â
				with properties {name:"p4", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myXb), (myY - myB)}, point type:corner}, {anchor:{(myXb), (myY - myA)}, point type:corner}}}
			--linksboven
			make new path item at end of myGroup Â
				with properties {name:"p5", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myX - myA), (myYh)}, point type:corner}, {anchor:{(myX - myB), (myYh)}, point type:corner}}}
			make new path item at end of myGroup Â
				with properties {name:"p6", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myX), (myYh + myB)}, point type:corner}, {anchor:{(myX), (myYh + myA)}, point type:corner}}}
			--rechtsboven
			make new path item at end of myGroup Â
				with properties {name:"p7", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myXb + myB), (myYh)}, point type:corner}, {anchor:{(myXb + myA), (myYh)}, point type:corner}}}
			make new path item at end of myGroup Â
				with properties {name:"p8", stroked:true, stroke width:myCropMarkWidth, stroke color:{class:spot color info, spot:spotnumber, tint:100}, filled:false, entire path:{{anchor:{(myXb), (myYh + myB)}, point type:corner}, {anchor:{(myXb), (myYh + myA)}, point type:corner}}}
		end tell
	end tell
end makeCrop

on makeGroup()
	tell application "Adobe Illustrator"
		tell document 1
			if exists group item "cropmarks" then
				set myGroup to group item "cropmarks"
			else
				set myGroup to make group item at current layer with properties {name:"cropmarks"}
			end if
		end tell
	end tell
	return myGroup
end makeGroup