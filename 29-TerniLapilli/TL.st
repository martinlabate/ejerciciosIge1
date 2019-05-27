!classDefinition: #TestTerniCapilli category: #TL!
TestCase subclass: #TestTerniCapilli
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 16:40:33'!
testEmptyBoardWhenNoneChipHasBeenPlaced

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self assert: [juego boardIsEmpty.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 16:40:41'!
testGameIsNotOverWhenGameHasJustStarted

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self deny: juego finished.! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 16:40:47'!
testNoXChipsOnNewGame

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self assert: [juego xChips isEmpty.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 16:40:55'!
testNoYChipsBeforPlaying

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	self assert: [juego oChips isEmpty.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 16:41:03'!
testXStartTheGame

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self assert: [juego nextPlayer isKindOf: XPlayer].! !


!TestTerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:41:16'!
testAfterOPlaysX

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	self assert: [juego nextPlayer isKindOf: OPlayer].
	juego playIn: 0@1.
	self assert: [juego nextPlayer isKindOf: XPlayer].! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:41:28'!
testAfterXPlaysO

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self assert: [juego nextPlayer isKindOf: XPlayer].
	juego playIn: 0@0.
	self assert: [juego nextPlayer isKindOf: OPlayer].! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:36:57'!
testCantPlacedMoreThan3Chips
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 2@2.
	juego playIn: 2@1.
	self should: [ juego playIn: 2@0.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'No hay más fichas']! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:36:58'!
testOneXChipAndOneOChipWhenEachPlayedOnce
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.
	self assert: [(juego xChips size) = 1.].
	self assert: [(juego oChips size) = 1.].! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:41:39'!
testOneXChipWhenXPlayedOnce

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	self assert: [juego xChips size = 1.].
	self assert: [juego oChips isEmpty].! !


!TestTerniCapilli methodsFor: 'CheckPosition' stamp: 'n 5/26/2019 20:18:01'!
testCantPlacedAChipInAInvalidPosition

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	self should: [ juego playIn: 0@-1. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Inválida']	! !

!TestTerniCapilli methodsFor: 'CheckPosition' stamp: 'n 5/25/2019 16:41:57'!
testCantPlacedAChipOnAnOcupiedPosition

	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	self should: [ juego playIn: 0@0. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Ocupada']	! !


!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:58'!
testAfterOMovesComesX
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.	
	juego playIn: 1@1.
	juego playIn: 0@2.
	juego playIn: 1@2.
	juego playIn: 1@0.
	juego move: 1@1 to: 2@1.
	self assert: (juego nextPlayer isKindOf: OPlayer).
	juego move: 1@0 to: 2@0.
	self assert: (juego nextPlayer isKindOf: XPlayer).! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:57'!
testAfterXMovesComesO
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.	
	juego playIn: 1@1.
	juego playIn: 0@2.
	juego playIn: 1@2.
	juego playIn: 1@0.
	self assert: (juego nextPlayer isKindOf: XPlayer).
	juego move: 1@1 to: 2@1.
	self assert: (juego nextPlayer isKindOf: OPlayer).! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:58'!
testCantMakeAnInvalidMovement
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 2@0.
	juego playIn: 2@1.
	self should: [ juego move: 0@0 to: 2@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Movimiento Invá¡lido']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/26/2019 20:21:47'!
testCantMoveBeforeAllChipsArePlaced
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.
	juego playIn: 1@1.

	self should: [juego move: 1@1 to: 1@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Todavía no se puede efectuar este mvimiento']
! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/26/2019 20:13:48'!
testCantMoveFromAnEmptyPosition
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 2@2.	
	juego playIn: 2@1.
	self should: [ juego move: 2@0 to: 1@1.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Desocupada']! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:58'!
testCantMoveOtherPlayersChip
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.
	juego playIn: 1@1.
	juego playIn: 0@2.
	juego playIn: 1@2.
	juego playIn: 1@0.

	self should: [juego move: 1@0 to: 2@0.] raise: Error withExceptionDo: [:anError | self assert: anError messageText = 'Esta ficha no la podes mover']. ! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:57'!
testCantMoveToAnOcupiedPosition
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 2@2.
	juego playIn: 2@1.
	self should: [ juego move: 0@0 to: 1@0.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Ocupada']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/26/2019 20:17:41'!
testCantMoveToInvalidPosition
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.
	juego playIn: 0@2.
	juego playIn: 2@0.
	juego playIn: 2@1.
	juego playIn: 2@2.
		
	self should: [ juego move: 0@0 to: 0@-1.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Inválida']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'n 5/25/2019 16:36:57'!
testValidMoveChangesChipsPositions
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 2@2.
	juego playIn: 2@1.
	juego move:0@1  to: 0@2.
	self assert: [(juego xChips) includes: 0@2].
	self deny: (juego xChips includes: 0@1).! !


!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:58'!
testCantPlayIfGameOver
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 0@2.
	self should: [juego playIn: 2@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Juego terminado']	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:58'!
testDiagonalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 1@1.
	juego playIn: 2@1.	
	juego playIn: 2@2.
	self assert: [juego finished].
	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:58'!
testHorizontalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 0@1.
	juego playIn: 1@1.	
	juego playIn: 0@2.
	self assert: [juego finished].
	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:57'!
testMovingAChipCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 0@1.
	juego playIn: 1@1.
	juego playIn: 0@2.
	juego playIn: 1@2.
	juego playIn: 2@0.
	juego move: 1@2 to: 2@2.
	self assert: (juego finished).! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:58'!
testNonWinningSetupDoesNotEndGame
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@0.
	juego playIn: 1@2.
	juego playIn: 1@1.	
	juego playIn: 2@1.
	self deny: (juego finished).! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:36:58'!
testVerticalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego initGame.
	juego playIn: 0@0.
	juego playIn: 1@2.
	juego playIn: 1@0.
	juego playIn: 1@1.	
	juego playIn: 2@0.
	self assert: [juego finished].
	! !


!classDefinition: #TerniCapilli category: #TL!
Object subclass: #TerniCapilli
	instanceVariableNames: 'xChips oChips nextPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!TerniCapilli methodsFor: 'Initialize' stamp: 'n 5/25/2019 15:51:04'!
initGame
	xChips _ OrderedCollection new.
	oChips _ OrderedCollection new.
	nextPlayer _ XPlayer new.! !


!TerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:35:09'!
changePlayer: aPlayer
	nextPlayer _ aPlayer .! !

!TerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:37:17'!
oPlaysIn: aChipPosition
	self playingIn: aChipPosition withChips: oChips.! !

!TerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:36:57'!
playIn: aChipPosition
	self isNotOcupied: aChipPosition.
	self isValid: aChipPosition.
	self isNotFinished.
	nextPlayer play: aChipPosition in: self.! !

!TerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:37:17'!
playingIn: aChipPosition withChips: aChipsCollection

	aChipsCollection size = 3 ifTrue: [self error: 'No hay más fichas']
	ifFalse:[aChipsCollection add: aChipPosition.]	! !

!TerniCapilli methodsFor: 'Playing' stamp: 'n 5/25/2019 16:37:26'!
xPlaysIn: aChipPosition

	self playingIn: aChipPosition withChips: xChips	! !


!TerniCapilli methodsFor: 'Sliding' stamp: 'n 5/25/2019 16:34:56'!
move: aChipPosition to: otherChipPosition
	self canMakeMovement.
	self isOcupied: aChipPosition.
	self isNotOcupied: otherChipPosition.
	self isValid: otherChipPosition.
	self isValidMovementFrom: aChipPosition to: otherChipPosition.
	nextPlayer move: aChipPosition to: otherChipPosition in: self! !

!TerniCapilli methodsFor: 'Sliding' stamp: 'n 5/25/2019 16:34:41'!
moveO: aChipPosition to: otherChipPosition

	self moving: aChipPosition to: otherChipPosition chips: oChips  nextPlayer: XPlayer new.! !

!TerniCapilli methodsFor: 'Sliding' stamp: 'n 5/25/2019 16:34:23'!
moveX: aChipPosition to: otherChipPosition
	self moving: aChipPosition to: otherChipPosition chips: xChips  nextPlayer: OPlayer new.! !

!TerniCapilli methodsFor: 'Sliding' stamp: 'n 5/25/2019 16:36:57'!
moving: aChipPosition to: otherChipPosition chips: aChipsCollection nextPlayer: aPlayer

	(aChipsCollection includes: aChipPosition) ifTrue: [aChipsCollection remove: aChipPosition.
	self playIn: otherChipPosition.
	self changePlayer: aPlayer.]
	ifFalse: [self error: 'Esta ficha no la podes mover'].! !


!TerniCapilli methodsFor: 'CheckPosotion' stamp: 'n 5/25/2019 16:37:52'!
isNotOcupied: aChipPosition

	^ ((xChips includes: aChipPosition) or: (oChips includes: aChipPosition)) ifTrue: [self error: 'Posición Ocupada'].! !

!TerniCapilli methodsFor: 'CheckPosotion' stamp: 'n 5/25/2019 16:38:05'!
isOcupied: aChipPosition

	^ ((xChips includes: aChipPosition) or: (oChips includes: aChipPosition)) ifFalse: [self error: 'Posición Desocupada'].! !

!TerniCapilli methodsFor: 'CheckPosotion' stamp: 'n 5/26/2019 20:17:32'!
isValid: aChipPosition

	^ (aChipPosition between: 0@0 and: 2@2) ifFalse: [self error: 'Posición Inválida'].
! !


!TerniCapilli methodsFor: 'Observadores' stamp: 'n 5/25/2019 16:13:50'!
nextPlayer

	^nextPlayer ! !

!TerniCapilli methodsFor: 'Observadores' stamp: 'n 5/25/2019 16:13:55'!
oChips
	^ oChips.! !

!TerniCapilli methodsFor: 'Observadores' stamp: 'n 5/25/2019 16:14:02'!
xChips

	^ xChips.! !


!TerniCapilli methodsFor: 'CheckMovements' stamp: 'n 5/25/2019 16:13:44'!
canMakeMovement

	^ ((xChips size = 3) and: (oChips size = 3)) ifFalse: [self error: 'Todavía no se puede efectuar este mvimiento']! !

!TerniCapilli methodsFor: 'CheckMovements' stamp: 'n 5/25/2019 16:38:49'!
isValidMovementFrom: aChipPosition to: otherChipPosition

	^ ((aChipPosition dist: otherChipPosition) = 1) ifFalse: [self error: 'Movimiento Invá¡lido'].! !


!TerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:12:57'!
boardIsEmpty

	^ (self xChips size =0) and: (self oChips size =0).! !

!TerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:13:03'!
finished

	^((self won: xChips )or: (self won: oChips)).! !

!TerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:13:08'!
isNotFinished

	^((self won: xChips )or: (self won: oChips)) ifTrue: [self error: 'Juego terminado'].! !

!TerniCapilli methodsFor: 'CheckState' stamp: 'n 5/25/2019 16:40:10'!
won: aChipCollection

	|chipNumber1 chipNumber2 chipNumber3|
		
	aChipCollection sort.
	aChipCollection size < 3 ifTrue: [^false].
	chipNumber1 _ aChipCollection at: 1.
	chipNumber2 _ aChipCollection at: 2.
	chipNumber3 _ aChipCollection at: 3.
	
	^(chipNumber1 x = chipNumber2 x and: chipNumber1 x = chipNumber3 x) or:
	(chipNumber1 y = chipNumber2 y and: chipNumber1 y = chipNumber3 y) or:
	(((chipNumber1 x isNotEqualTo: chipNumber2 x) and: (chipNumber1 x isNotEqualTo: chipNumber3 x) and: (chipNumber3 x isNotEqualTo: chipNumber2 x)) and:
		(chipNumber1 y isNotEqualTo: chipNumber2 y) and: (chipNumber1 y isNotEqualTo: chipNumber3 y) and: (chipNumber3 y isNotEqualTo: chipNumber2 y) and:(chipNumber1 dist: chipNumber2) = (chipNumber2 dist: chipNumber3)) .! !


!classDefinition: #TerniCapilliPlayer category: #TL!
Object subclass: #TerniCapilliPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!TerniCapilliPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:20:40'!
move: unPunto to: otroPunto in: aTerniCapilliGame

	self subclassResponsibility! !

!TerniCapilliPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:20:35'!
play: unPunto in: aTerniCapilliGame

	self subclassResponsibility.
	! !


!classDefinition: #OPlayer category: #TL!
TerniCapilliPlayer subclass: #OPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!OPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:20:59'!
move: unPunto to: otroPunto in: aTerniCapilliGame

	aTerniCapilliGame moveO: unPunto to: otroPunto.
	aTerniCapilliGame changePlayer: XPlayer new.! !

!OPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:36:46'!
play: unPunto in: aTerniCapilliGame

	aTerniCapilliGame oPlaysIn: unPunto.
	aTerniCapilliGame changePlayer: XPlayer new.! !


!classDefinition: #XPlayer category: #TL!
TerniCapilliPlayer subclass: #XPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!XPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:21:07'!
move: unPunto to: otroPunto in: aTerniCapilliGame

	aTerniCapilliGame moveX: unPunto to: otroPunto.
	aTerniCapilliGame changePlayer: OPlayer new.! !

!XPlayer methodsFor: 'as yet unclassified' stamp: 'n 5/25/2019 16:37:26'!
play: unPunto in: aTerniCapilliGame

	aTerniCapilliGame xPlaysIn: unPunto.
	aTerniCapilliGame changePlayer: OPlayer new.! !
