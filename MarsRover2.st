!classDefinition: #TestsMarsRoverCopy category: #MarsRover2!
TestCase subclass: #TestsMarsRoverCopy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:46:10'!
test01RoverDontChangeItsDirectionOrPositionWhenNotMoved
	
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: 'N'. 
	marsRover move: ''.
	self assert: marsRover position equals: 0@0.
	self assert: marsRover direction equals: 'N'.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:56:05'!
test02
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'f'.
	self assert: marsRover position equals: 0@1.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:56:10'!
test03	
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'r'.
	self assert: marsRover direction equals: #East.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:56:15'!
test04	
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'l'.
	self assert: marsRover direction equals: #West.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:56:21'!
test05
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'b'.
	self assert: marsRover position equals: 0@-1.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:56:26'!
test06	
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'rl'.
	self assert: marsRover direction equals: #North.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:30:32'!
test07
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	
	self
		should: [ marsRover move: 'x'. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Error' ]
		! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:34:16'!
test08
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'rf'.
	self assert: marsRover direction equals: #East.
	self assert: marsRover position equals: 1@0.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:30:57'!
test09
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'rr'.
	self assert: marsRover direction equals: #South.! !

!TestsMarsRoverCopy methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:34:29'!
test10
	|marsRover|
	marsRover _ MarsRover2 withPosiotion:0@0 andDirection: #North. 
	marsRover move: 'rffrrbbl'.
	self assert: marsRover direction equals: #South.
	self assert: marsRover position equals: 4@0.! !


!classDefinition: #MarsRover2 category: #MarsRover2!
Object subclass: #MarsRover2
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover2'!

!MarsRover2 methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:51:12'!
direction
	^direction! !

!MarsRover2 methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:48:51'!
initializeWithPosition: aPoint andDirection: aSymbol 
	position _ aPoint .
	direction _ aSymbol .! !

!MarsRover2 methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:30:07'!
move: aString
	|movements|
	movements:= aString asOrderedCollection.
	movements do:  [:element |  self singleMovement: (element asString ) ].! !

!MarsRover2 methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:50:59'!
position
	^position! !

!MarsRover2 methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 21:21:21'!
singleMovement: aString
	(aString = 'f' or: aString = 'b' or: aString ='r' or: aString = 'l' or: aString = '') ifFalse: [^self error: 'Error'].
	(aString = 'f') ifTrue: [
	(direction = #North) ifTrue: [position _ 0@1+position].
	(direction = #South) ifTrue: [position _ 0@-1+position].
	(direction = #East) ifTrue: [position _ 1@0+position].
	(direction = #West) ifTrue: [position _ -1@0+position].] .
	(aString = 'r') ifTrue: [
	(direction = #North) ifTrue: [^direction _ #East].
	(direction = #South) ifTrue: [^direction _ #West].
	(direction = #East) ifTrue: [^direction _ #South].
	(direction = #West) ifTrue: [^direction _ #North].] .
	(aString = 'b') ifTrue: [
	(direction = #North) ifTrue: [position _ 0@-1+position].
	(direction = #South) ifTrue: [position _ 0@1+position].
	(direction = #East) ifTrue: [position _ -1@0+position].
	(direction = #West) ifTrue: [position _ 1@0+position].] .
	(aString = 'l') ifTrue: [
	(direction = #East) ifTrue: [^direction _ #North].
	(direction = #West) ifTrue: [^direction _ #South].
	(direction = #South) ifTrue: [^direction _ #East].
	(direction = #North) ifTrue: [^direction _ #West].] .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover2 class' category: #MarsRover2!
MarsRover2 class
	instanceVariableNames: 'position direction'!

!MarsRover2 class methodsFor: 'as yet unclassified' stamp: 'ML 5/6/2019 20:48:19'!
withPosiotion: aPoint andDirection: aSymbol 
	^self new initializeWithPosition: aPoint andDirection: aSymbol .! !
