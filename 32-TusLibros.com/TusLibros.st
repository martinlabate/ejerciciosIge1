!classDefinition: #TestACart category: #TusLibros!
TestCase subclass: #TestACart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:22:04'!
test01TheCartIsEmptyWhenHasJustBeenCreated
	|aCart aPassword anIdCliente |
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.

	aCart := ACart withClient: anIdCliente pass: aPassword.
	self assert: (aCart isEmpty) ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:29'!
test02ACartKnowsItsClient
	|aCart aPassword anIdCliente |
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
	self assert: (aCart cliente isEqualTo: anIdCliente) ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:25:53'!
test03TheCartIsValidWhenHasJustBeenCreated
	|aCart aPassword anIdCliente |
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.

	aCart := ACart withClient: anIdCliente pass: aPassword.
	self assert: (aCart isValid) ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:29'!
test04ACartKnowsItsBooks
	|aCart aPassword anIdCliente aBook bookMap|
	
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aBook _ 'cuento1'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
	aCart addBook: aBook.
	
	bookMap _ Dictionary new.
	bookMap at: aBook put: 1.
	
	self assert: (aCart books isEqualTo: bookMap keys). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:29'!
test05ACartKnowsIfHasABook
	|aCart aPassword anIdCliente aBook|
	
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aBook _ 'cuento1'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
	aCart addBook: aBook.
	
	self assert: (aCart has: aBook). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:29'!
test06ACartKnowsThatHasOneCopyOfABook
	|aCart aPassword anIdCliente aBook|
	
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aBook _ 'cuento1'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
	aCart addBook: aBook.	
	self assert: ((aCart copiesQuantity: aBook) isEqualTo: 1). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:29'!
test07ACartKnowsHowManyCopiesOfABookHas
	|aCart aPassword anIdCliente aBook|
	
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aBook _ 'cuento1'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
	aCart addBook: aBook.
	aCart addBook: aBook.
	aCart addBook: aBook.
		
	self assert: ((aCart copiesQuantity: aBook) isEqualTo: 3). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:21:07'!
test08ACartKnowsHasCeroCopiesOfAnAbsentBook
	|aCart aPassword anIdCliente aBook|
	
	anIdCliente _ 'id0'.
	aPassword _ 'abc'.
	aBook _ 'cuento1'.
	aCart _ ACart withClient: anIdCliente pass: aPassword.
			
	self assert: ((aCart copiesQuantity: aBook) isEqualTo: 0). ! !


!classDefinition: #ACart category: #TusLibros!
Object subclass: #ACart
	instanceVariableNames: 'books client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ACart methodsFor: 'observadores' stamp: 'n 5/31/2019 15:18:01'!
books
	^ books keys.! !

!ACart methodsFor: 'observadores' stamp: 'n 5/31/2019 15:18:11'!
cliente
	^ client.! !


!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:22:30'!
addBook: aBook
	books at: aBook ifPresent: [:avalue| books at: aBook put: (avalue+1)] ifAbsent:[books at: aBook put:1].
	! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:01'!
copiesQuantity: aBook
	^(books at: aBook ifAbsent: 0).! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:01'!
has: aBook
	^ books includesKey: aBook! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:30:13'!
initializeWith: aClient pass: aPassword 
	books _ Dictionary new.
	client _ aClient .! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:01'!
isEmpty
	^ books isEmpty.! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:29:24'!
isValid
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ACart class' category: #TusLibros!
ACart class
	instanceVariableNames: ''!

!ACart class methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 13:46:10'!
withClient: aClient pass: aPassword 
	^ self new initializeWith: aClient pass: aPassword.! !
