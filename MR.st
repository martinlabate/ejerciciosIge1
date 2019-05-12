!classDefinition: #TestMR category: #MR!
TestCase subclass: #TestMR
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:31:25'!
test03
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: East new.
	aRobot process: 'r'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (South new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:31:29'!
test04
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: South new.
	aRobot process: 'r'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (West new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:01'!
test05
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: West new.
	aRobot process: 'r'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (North new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:07'!
test06
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: South new.
	aRobot process: 'l'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:14'!
test07
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: West new.
	aRobot process: 'l'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (South new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:19'!
test08
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'l'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (West new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:25'!
test09
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: South new.
	aRobot process: 'f'.
	self assert: (aRobot isAt: 0@-1).
	self assert: (aRobot isPointingAt: (South new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:29'!
test10
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: East new.
	aRobot process: 'f'.
	self assert: (aRobot isAt: 1@0).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:35'!
test11
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: West new.
	aRobot process: 'f'.
	self assert: (aRobot isAt: -1@0).
	self assert: (aRobot isPointingAt: (West new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:42'!
test12
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: South new.
	aRobot process: 'b'.
	self assert: (aRobot isAt: 0@1).
	self assert: (aRobot isPointingAt: (South new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:51'!
test13
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: East new.
	aRobot process: 'b'.
	self assert: (aRobot isAt: -1@0).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:34:57'!
test14
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: West new.
	aRobot process: 'b'.
	self assert: (aRobot isAt: 1@0).
	self assert: (aRobot isPointingAt: (West new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:36:51'!
test15
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'bbrrlf'.
	self assert: (aRobot isAt: 1@-2).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:38:09'!
testEmptyProcessDoesNothing
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: ''.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: North new). 
	"Se puede sacar o no este initialize prque isPointingAt pregunta por igualdad de clases"! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:37:58'!
testInvalidProcessRisesError
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	
	self should: [ aRobot process: 'x'. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Invalid command' ]
! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:48:29'!
testMoveBBRRLF
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'bbrrlf'.
	self assert: (aRobot isAt: 1@-2).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:56:20'!
testMoveBBRRLFAndRisesError
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	self should: [ aRobot process: 'bbrrlfxffrr'. ]
		 raise: Error
		 withExceptionDo: [ :anError | 
			self assert: (aRobot isAt: 1@-2).
			self assert: (aRobot isPointingAt: (East new)).
			self assert: anError messageText = 'Invalid command' ].! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:41:30'!
testMoveBackwardPointingNorth
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'b'.
	self assert: (aRobot isAt: 0@-1).
	self assert: (aRobot isPointingAt: (North new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 20:00:17'!
testMoveFFBBRotatingLeft
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'flflblb'.
	self assert: (aRobot isAt: -2@2).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:47:44'!
testMoveFFBBRotatingRight
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'frfrbrb'.
	self assert: (aRobot isAt: 2@2).
	self assert: (aRobot isPointingAt: (West new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:40:12'!
testMoveForwardPointingNorth
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'f'.
	self assert: (aRobot isAt: 0@1).
	self assert: (aRobot isPointingAt: (North new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:39:50'!
testRotateLeftFromEast
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: East new.
	aRobot process: 'l'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: (North new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:44:15'!
testRotateRightMoveForward
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'rf'.
	self assert: (aRobot isAt: 1@0).
	self assert: (aRobot isPointingAt: (East new)).! !

!TestMR methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:39:30'!
testRotateRightPointingNorth
	|aRobot|
	aRobot := MR new initializeAt: 0@0 pointing: North new.
	aRobot process: 'r'.
	self assert: (aRobot isAt: 0@0).
	self assert: (aRobot isPointingAt: East new).! !


!classDefinition: #MR category: #MR!
Object subclass: #MR
	instanceVariableNames: 'mrPosition mrDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

!MR methodsFor: 'Observators' stamp: 'ML 5/12/2019 19:08:20'!
isAt
	^ mrPosition! !

!MR methodsFor: 'Observators' stamp: 'ML 5/12/2019 19:08:32'!
isPointingAt
	^mrDirection! !


!MR methodsFor: 'Processing' stamp: 'n 5/11/2019 18:38:48'!
process: aSecuenceOfComands 
	
	aSecuenceOfComands do:[:aComand| self singleProcess: aComand asString ].! !

!MR methodsFor: 'Processing' stamp: 'ML 5/12/2019 19:49:38'!
singleProcess: aComand 

	(aComand = 'r' or: aComand = 'l')
	ifTrue: [ mrDirection _ mrDirection turn: aComand]
	ifFalse: [
		(aComand = 'f' or: aComand = 'b')
		ifTrue: [mrPosition _ mrPosition + (mrDirection move: aComand)] 
		ifFalse: [self error:'Invalid command'].
	].! !


!MR methodsFor: 'initialization' stamp: 'ML 5/12/2019 19:17:25'!
initializeAt: aPoint pointing: aDirection
	mrPosition _ aPoint .
	mrDirection _ aDirection.! !


!MR methodsFor: 'Comparators' stamp: 'n 5/11/2019 17:53:26'!
isAt: aPoint 
	^ mrPosition = aPoint ! !

!MR methodsFor: 'Comparators' stamp: 'n 5/11/2019 19:51:24'!
isPointingAt: aDirection 
	^mrDirection class = aDirection class! !


!classDefinition: #MRDirection category: #MR!
Object subclass: #MRDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

!MRDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:24'!
goBackward
	self subclassResponsibility.! !

!MRDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:30'!
goForeward
	self subclassResponsibility.! !

!MRDirection methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:30:07'!
move: forwardsOrBackwards
	^forwardsOrBackwards = 'f' ifTrue:[self goForeward]  ifFalse:[self goBackward].! !

!MRDirection methodsFor: 'as yet unclassified' stamp: 'ML 5/12/2019 19:30:12'!
turn: leftOrRight
	^leftOrRight = 'l' ifTrue:[self turnLeft]  ifFalse:[self turnRight].! !

!MRDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:45:00'!
turnLeft
	self subclassResponsibility.! !

!MRDirection methodsFor: 'as yet unclassified' stamp: 'n 5/11/2019 18:44:21'!
turnRight
	self subclassResponsibility.! !


!classDefinition: #East category: #MR!
MRDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

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


!classDefinition: #North category: #MR!
MRDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

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


!classDefinition: #South category: #MR!
MRDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

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


!classDefinition: #West category: #MR!
MRDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MR'!

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
