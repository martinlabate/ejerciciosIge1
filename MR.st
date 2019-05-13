!classDefinition: #TestMR category: #MRExcercise!
TestCase subclass: #TestMR
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:05:34'!
testEmptyProcessDoesNothing
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: ''.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: North new). ! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:01:59'!
testInvalidProcessRisesError
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	
	self should: [ aRobot process: 'x'. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid command' ]
! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:35'!
testMoveBBRRLF
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'bbrrlf'.
	self assert: (aRobot isAt: 1@-2).
	self assert: (aRobot isPointingAt: East new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:28'!
testMoveBBRRLFAndRisesError
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	self should: [ aRobot process: 'bbrrlfxffrr'. ]
		 raise: Error
		 withExceptionDo: [ :anError | 
			self assert: (aRobot isAt: 1@-2).
			self assert: (aRobot isPointingAt: East new).
			self assert: anError messageText = 'Invalid command' ].! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:21'!
testMoveBackwardPointingNorth
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'b'.
	self assert: (aRobot isAt: 0@-1).
	self assert: (aRobot isPointingAt: North new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:15'!
testMoveFFBBRotatingLeft
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'flflblb'.
	self assert: (aRobot isAt: -2@2).
	self assert: (aRobot isPointingAt: East new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:09'!
testMoveFFBBRotatingRight
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'frfrbrb'.
	self assert: (aRobot isAt: 2@2).
	self assert: (aRobot isPointingAt: West new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:06:04'!
testMoveForwardPointingNorth
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'f'.
	self assert: (aRobot isAt: 0@1).
	self assert: (aRobot isPointingAt: North new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:05:57'!
testRotateLeftFromEast
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: East new.
	aRobot process: 'l'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: North new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:05:51'!
testRotateRightMoveForward
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'rf'.
	self assert: (aRobot isAt: 1@0).
	self assert: (aRobot isPointingAt: East new).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'n 5/13/2019 10:02:00'!
testRotateRightPointingNorth
	|aRobot|
	aRobot := MarsRover new initializeAt: 0@0 pointing: North new.
	aRobot process: 'r'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: East new).! !


!classDefinition: #MarsRover category: #MRExcercise!
Object subclass: #MarsRover
	instanceVariableNames: 'mrPosition mrDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!MarsRover methodsFor: 'Processing' stamp: 'n 5/11/2019 18:38:48'!
process: aSecuenceOfComands 
	
	aSecuenceOfComands do:[:aComand| self singleProcess: aComand asString ].! !

!MarsRover methodsFor: 'Processing' stamp: 'ML 5/12/2019 19:49:38'!
singleProcess: aComand 

	(aComand = 'r' or: aComand = 'l')
	ifTrue: [ mrDirection _ mrDirection turn: aComand]
	ifFalse: [
		(aComand = 'f' or: aComand = 'b')
		ifTrue: [mrPosition _ mrPosition + (mrDirection move: aComand)] 
		ifFalse: [self error:'Invalid command'].
	].! !


!MarsRover methodsFor: 'initialization' stamp: 'ML 5/12/2019 19:17:25'!
initializeAt: aPoint pointing: aDirection
	mrPosition _ aPoint .
	mrDirection _ aDirection.! !


!MarsRover methodsFor: 'Comparators' stamp: 'n 5/11/2019 17:53:26'!
isAt: aPoint 
	^ mrPosition = aPoint ! !

!MarsRover methodsFor: 'Comparators' stamp: 'n 5/13/2019 09:54:30'!
isPointingAt: aDirection 
	^mrDirection class = aDirection class! !


!classDefinition: #MarsRoverDirection category: #MRExcercise!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:24'!
goBackward
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:30'!
goForeward
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:30:07'!
move: forwardsOrBackwards
	^forwardsOrBackwards = 'f' ifTrue:[self goForeward]  ifFalse:[self goBackward].! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:30:12'!
turn: leftOrRight
	^leftOrRight = 'l' ifTrue:[self turnLeft]  ifFalse:[self turnRight].! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:00'!
turnLeft
	self subclassResponsibility.! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:44:21'!
turnRight
	self subclassResponsibility.! !


!classDefinition: #East category: #MRExcercise!
MarsRoverDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!East methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:02:31'!
goBackward
	^(-1)@0! !

!East methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:02:53'!
goForeward
	^1@0! !

!East methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:16:32'!
turnLeft
	^North new.! !

!East methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:16:36'!
turnRight
	^South new.! !


!classDefinition: #North category: #MRExcercise!
MarsRoverDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!North methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:03:54'!
goBackward
	^0@(-1)! !

!North methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:04:09'!
goForeward
	^0@1! !

!North methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:16:42'!
turnLeft
	^West new.! !

!North methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:16:47'!
turnRight
	^East new.! !


!classDefinition: #South category: #MRExcercise!
MarsRoverDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!South methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:05:04'!
goBackward
	^0@1! !

!South methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:05:20'!
goForeward
	^0@(-1)! !

!South methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:35:48'!
turnLeft
	^East new.! !

!South methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:35:54'!
turnRight
	^West new.! !


!classDefinition: #West category: #MRExcercise!
MarsRoverDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MRExcercise'!

!West methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:06:18'!
goBackward
	^1@0! !

!West methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:06:26'!
goForeward
	^(-1)@0! !

!West methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:36:05'!
turnLeft
	^South new.! !

!West methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:36:17'!
turnRight
	^North new.! !
