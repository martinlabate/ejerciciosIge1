!classDefinition: #TestACart category: #TusLibros!
TestCase subclass: #TestACart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:33:59'!
test01TheCartIsEmptyWhenHasJustBeenCreated
	|aCart |

	aCart := ACart new.
	self assert: (aCart isEmpty) ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:34:37'!
test03TheCartIsValidWhenHasJustBeenCreated
	|aCart|

	aCart := ACart new.
	self assert: (aCart isValid) ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:35:19'!
test04ACartKnowsItsBooks
	|aCart aBook bookMap|
	
	aBook _ 'cuento1'.
	aCart _ ACart new.
	aCart addBook: aBook.
	
	bookMap _ Dictionary new.
	bookMap at: aBook put: 1.
	
	self assert: (aCart books isEqualTo: bookMap keys). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:35:59'!
test05ACartKnowsIfHasABook
	|aCart aBook|
	aBook _ 'cuento1'.
	aCart _ ACart new.
	aCart addBook: aBook.
	
	self assert: (aCart has: aBook). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:36:15'!
test06ACartKnowsThatHasOneCopyOfABook
	|aCart aBook|
	aBook _ 'cuento1'.
	aCart _ ACart new.
	aCart addBook: aBook.	
	self assert: ((aCart copiesAmount: aBook) isEqualTo: 1). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:40:17'!
test07ACartKnowsHowManyCopiesOfABookHas
	|aCart aBook|

	aBook _ 'cuento1'.
	aCart _ ACart new.
	aCart addAmount: 3 ofABook: aBook.
		
	self assert: ((aCart copiesAmount: aBook) isEqualTo: 3). ! !

!TestACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:36:51'!
test08ACartKnowsHasCeroCopiesOfAnAbsentBook
	|aCart aBook|
	
	aBook _ 'cuento1'.
	aCart _ ACart new.
			
	self assert: ((aCart copiesAmount: aBook) isEqualTo: 0). ! !


!classDefinition: #ACart category: #TusLibros!
Object subclass: #ACart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ACart methodsFor: 'observadores' stamp: 'n 5/31/2019 15:18:01'!
books
	^ books keys.! !

!ACart methodsFor: 'observadores' stamp: 'n 5/31/2019 15:18:11'!
cliente
	^ client.! !


!ACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:39:15'!
addAmount: anAmount ofABook: aBook
	books at: aBook ifPresent: [:avalue| books at: aBook put: (avalue+anAmount )] ifAbsent:[books at: aBook put:anAmount ].
	! !

!ACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:39:34'!
addBook: aBook
	self addAmount: 1 ofABook: aBook .	! !

!ACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:14:56'!
copiesAmount: aBook
	^(books at: aBook ifAbsent: 0).! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:01'!
has: aBook
	^ books includesKey: aBook! !

!ACart methodsFor: 'as yet unclassified' stamp: 'ML 6/2/2019 13:32:20'!
initialize 
	books _ Dictionary new.! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:18:01'!
isEmpty
	^ books isEmpty.! !

!ACart methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 15:29:24'!
isValid
	^true.! !
