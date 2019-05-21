!classDefinition: #TestTerniCapilli category: #TL!
TestCase subclass: #TestTerniCapilli
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 20:42:59'!
testEmptyBoardWhenNoneChipHasBeenPlaced
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self assert: [juego tableroVacio.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 20:43:03'!
testGameIsNotOverWhenGameHasJustStarted
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self deny: juego finished.! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 20:43:07'!
testNoXChipsOnNewGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self assert: [juego fichasX isEmpty.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 21:00:18'!
testNoYChipsBeforPlaying
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	self assert: [juego fichasY isEmpty.].! !

!TestTerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 20:43:14'!
testXStartTheGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self assert: [juego turno = #X].! !



!TestTerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:47:56'!
testAfterOPlaysX
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	self assert: [juego turno = #O].
	juego jugar: 0@1.
	self assert: [juego turno = #X].
! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:47:22'!
testAfterXPlaysO
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self assert: [juego turno = #X].
	juego jugar: 0@0.
	self assert: [juego turno = #O].! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:49:05'!
testCantPlacedMoreThan3Chips
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 2@2.
	juego jugar: 2@1.
	self should: [ juego jugar: 2@0.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'No hay más fichas']

	! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:43:39'!
testOneXChipAndOneOChipWhenEachPlayedOnce
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.
	self assert: [(juego fichasX size) = 1.].
	self assert: [(juego fichasY size) = 1.].! !

!TestTerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:43:31'!
testOneXChipWhenXPlayedOnce
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	self assert: [juego fichasX size = 1.].
	self assert: [juego fichasY isEmpty].! !


!TestTerniCapilli methodsFor: 'CheckPosition' stamp: 'ML 5/20/2019 20:43:51'!
testCantPlacedAChipInAInvalidPosition
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	self should: [ juego jugar: 0@-1. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Inválida']	! !

!TestTerniCapilli methodsFor: 'CheckPosition' stamp: 'ML 5/20/2019 20:43:46'!
testCantPlacedAChipOnAnOcupiedPosition
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	self should: [ juego jugar: 0@0. ]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Ocupada']	! !


!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:57:45'!
testAfterOMovesComesX
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.	
	juego jugar: 1@1.
	juego jugar: 0@2.
	juego jugar: 1@2.
	juego jugar: 1@0.
	juego move: 1@1 to: 2@1.
	self assert: (juego turno = #O).
	juego move: 1@0 to: 2@0.
	self assert: (juego turno = #X).
! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:57:11'!
testAfterXMovesComesO
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.	
	juego jugar: 1@1.
	juego jugar: 0@2.
	juego jugar: 1@2.
	juego jugar: 1@0.
	self assert: (juego turno = #X).
	juego move: 1@1 to: 2@1.
	self assert: (juego turno = #O).! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:44:41'!
testCantMakeAMovementBeforeXhipsArePlaced
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.
	juego jugar: 1@1.

	self should: [juego move: 1@1 to: 1@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Todavía no se puede efectuar este mvimiento']
! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:44:34'!
testCantMakeAnInvalidMovement
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 2@0.
	juego jugar: 2@1.
	self should: [ juego move: 0@0 to: 2@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Movimiento Inválido']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:44:29'!
testCantMoveToAnOcupiedPosition
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 2@2.
	juego jugar: 2@1.
	self should: [ juego move: 0@0 to: 1@0.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Ocupada']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:44:23'!
testCantMoveToInvalidPosition
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.
	juego jugar: 0@2.
	juego jugar: 2@0.
	juego jugar: 2@1.
	juego jugar: 2@2.
		
	self should: [ juego move: 0@0 to: 0@-1.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Posición Inválida']
	! !

!TestTerniCapilli methodsFor: 'CheckMovemets' stamp: 'ML 5/20/2019 20:44:37'!
testValidMoveChangesChipsPositions
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 2@2.
	juego jugar: 2@1.
	juego move:0@1  to: 0@2.
	self assert: [(juego fichasX) includes: 0@2].
	self deny: (juego fichasX includes: 0@1).! !


!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:43:57'!
testCantPlayIfGameOver
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 0@2.
	self should: [juego jugar: 2@2.]
		 raise: Error
		 withExceptionDo: [ :anError | self assert: anError messageText = 'Juego terminado']	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:44:03'!
testDiagonalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 1@1.
	juego jugar: 2@1.	
	juego jugar: 2@2.
	self assert: [juego finished].
	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:44:08'!
testHorizontalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 0@1.
	juego jugar: 1@1.	
	juego jugar: 0@2.
	self assert: [juego finished].
	! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:44:16'!
testMovingAChipCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 0@1.
	juego jugar: 1@1.
	juego jugar: 0@2.
	juego jugar: 1@2.
	juego jugar: 2@0.
	juego move: 1@2 to: 2@2.
	self assert: (juego finished).! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 21:15:41'!
testNonWinningSetupDoesNotEndGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@0.
	juego jugar: 1@2.
	juego jugar: 1@1.	
	juego jugar: 2@1.
	self deny: (juego finished).! !

!TestTerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:44:12'!
testVerticalPlacedChipsCanWinAGame
	|juego|
	juego _ TerniCapilli new.
	juego empezar.
	juego jugar: 0@0.
	juego jugar: 1@2.
	juego jugar: 1@0.
	juego jugar: 1@1.	
	juego jugar: 2@0.
	self assert: [juego finished].
	! !


!classDefinition: #TerniCapilli category: #TL!
Object subclass: #TerniCapilli
	instanceVariableNames: 'fichasX fichasY turno'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TL'!

!TerniCapilli methodsFor: 'Initialize' stamp: 'ML 5/20/2019 18:35:24'!
empezar
	fichasX _ OrderedCollection new.
	fichasY _ OrderedCollection new.
	turno _ #X! !


!TerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 20:34:16'!
jugar: unPunto
	(self isOcupied: unPunto) ifTrue: [self error: 'Posición Ocupada'].
	(self isValid: unPunto) ifFalse: [self error: 'Posición Inválida'].
	(self finished) ifTrue: [self error: 'Juego terminado'].

	turno = #X 
	ifTrue: [
		self jugarX: unPunto. 
		turno _ #O.
		] 
	ifFalse: [
		self jugarY: unPunto. 
		turno _ #X.
		]. ! !

!TerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 18:37:22'!
jugarX: unPunto
	fichasX size = 3 ifTrue: [self error: 'No hay más fichas']
	ifFalse:[fichasX add: unPunto.]
	! !

!TerniCapilli methodsFor: 'Playing' stamp: 'ML 5/20/2019 18:37:33'!
jugarY: unPunto
	fichasY size = 3 ifTrue: [self error: 'No hay más fichas']
	ifFalse:[fichasY add: unPunto.]
	! !


!TerniCapilli methodsFor: 'Sliding' stamp: 'ML 5/20/2019 19:58:19'!
move: unPunto to: otroPunto
	(self canMakeMovement) ifFalse: [self error: 'Todavía no se puede efectuar este mvimiento'].
	(self isOcupied: unPunto ) ifFalse: [self error: 'Posición inicial incorrecta'].
	(self isOcupied: otroPunto) ifTrue: [self error: 'Posición Ocupada'].
	(self isValid: otroPunto) ifFalse: [self error: 'Posición Inválida'].
	(self isValidMovementFrom: unPunto to: otroPunto) ifFalse: [self error: 'Movimiento Inválido'].
	
	turno = #X 
	ifTrue: [
		(fichasX includes: unPunto) ifTrue: [fichasX remove: unPunto.
			self jugarX: otroPunto. 
			turno _ #O.] 
		ifFalse: [self error: 'Esta ficha es O, no la podes mover'].
		] 
	ifFalse: [
		(fichasY includes: unPunto) ifTrue: [fichasY remove: unPunto.
			self jugarY: otroPunto. 
			turno _ #X.] 
		ifFalse: [self error: 'Esta ficha es X, no la podes mover'].
		]. ! !


!TerniCapilli methodsFor: 'CheckPosotion' stamp: 'ML 5/20/2019 18:22:46'!
isOcupied: unPunto

	^ (fichasX includes: unPunto) or: (fichasY includes: unPunto).! !

!TerniCapilli methodsFor: 'CheckPosotion' stamp: 'ML 5/20/2019 18:29:15'!
isValid: unPunto
	^ unPunto between: 0@0 and: 2@2
! !


!TerniCapilli methodsFor: 'Observadores' stamp: 'ML 5/20/2019 17:57:00'!
fichasX
	^ fichasX.! !

!TerniCapilli methodsFor: 'Observadores' stamp: 'ML 5/20/2019 17:57:12'!
fichasY
	^ fichasY.! !

!TerniCapilli methodsFor: 'Observadores' stamp: 'ML 5/20/2019 20:27:09'!
turno
	^turno ! !


!TerniCapilli methodsFor: 'CheckMovements' stamp: 'ML 5/20/2019 19:58:55'!
canMakeMovement
	^ (fichasX size = 3) and: (fichasY size = 3)! !

!TerniCapilli methodsFor: 'CheckMovements' stamp: 'ML 5/20/2019 21:19:00'!
isValidMovementFrom: unPunto to: otroPunto
	"self isValid: unPunto."
	^ (unPunto dist: otroPunto) = 1.! !


!TerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:34:16'!
finished
	^ (self won: fichasX )or: (self won: fichasY).! !

!TerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 20:30:22'!
tableroVacio
	^ (self fichasX size =0) and: (self fichasY size =0).! !

!TerniCapilli methodsFor: 'CheckState' stamp: 'ML 5/20/2019 21:14:07'!
won: unaListaDeFichas
	|ficha1 ficha2 ficha3|
	
	unaListaDeFichas sort.
	unaListaDeFichas size < 3 ifTrue: [^false].
	ficha1 _ unaListaDeFichas at: 1.
	ficha2 _ unaListaDeFichas at: 2.
	ficha3 _ unaListaDeFichas at: 3.
	
	^(ficha1 x = ficha2 x and: ficha1 x = ficha3 x) or:
	(ficha1 y = ficha2 y and: ficha1 y = ficha3 y) or:
	(((ficha1 x isNotEqualTo: ficha2 x) and: (ficha1 x isNotEqualTo: ficha3 x) and: (ficha3 x isNotEqualTo: ficha2 x)) and:
		(ficha1 y isNotEqualTo: ficha2 y) and: (ficha1 y isNotEqualTo: ficha3 y) and: (ficha3 y isNotEqualTo: ficha2 y) and:(ficha1 dist: ficha2) = (ficha2 dist: ficha3)) .
! !
