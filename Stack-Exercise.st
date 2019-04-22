!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 21:14:18'!
test01EmptyResultWhenNothingIsFound
	|unFinder unaPila coleccionVacia|
	
	coleccionVacia := OrderedCollection new.
	unaPila := OOStack new.
	unaPila push: 'What is a proverb?'.
	unaPila push: 'What time is it?'.
	unaPila push: 'A journey of a thousand miles begins with a single step'.
	unFinder := SentenceFinderByPrefix new initializeWith: unaPila.

	self assert: ( (unFinder find: 'How') isEqualTo: coleccionVacia ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 21:14:28'!
test02StackDoesNotChangeWhenSearched
	|unFinder unaPila copiaDeUnFinder matches|
	
	unaPila := OOStack new.
	unaPila push: 'What is a proverb?'.
	unaPila push: 'What time is it?'.
	unaPila push: 'A journey of a thousand miles begins with a single step'.
	unFinder := SentenceFinderByPrefix new initializeWith: unaPila.
	copiaDeUnFinder := unFinder.
	matches := unFinder find: 'What'.	

	self assert: ( unFinder isEqualTo: copiaDeUnFinder).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 21:14:45'!
test03FinderReturnsCorrectValuesOnSearch
	|unFinder unaPila matches expectedMatches|
	
	expectedMatches := OrderedCollection new.
	expectedMatches addFirst: 'What is a proverb?'.
	expectedMatches addFirst: 'What time is it?'.

	unaPila := OOStack new.
	unaPila push: 'What is a proverb?'.
	unaPila push: 'What time is it?'.	
	unaPila push: 'A journey of a thousand miles begins with a single step'.
	unFinder := SentenceFinderByPrefix new initializeWith: unaPila.

	matches := unFinder find: 'What'.	

	self assert: ( matches isEqualTo: expectedMatches ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:31:10'!
test04FinderIsCaseSensitive

	|aFinder aStack matches matchesOtherPrefix|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.	
	aStack push: 'A journey of a thousand miles begins with a single step'.
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.

	matches := aFinder find: 'What'.	
	matchesOtherPrefix :=  aFinder find: 'what'.
	self assert: ( matches isNotEqualTo: matchesOtherPrefix ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:29:33'!
test05EmptyResultWhenStackIsEmpty
	|aFinder aStack emptyStack|
	
	emptyStack := OrderedCollection new.
	aStack := OOStack new.
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.

	self assert: ( (aFinder find: 'How') isEqualTo: emptyStack ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:29:00'!
test06StackIsNotChangedOnFinderCreation
	|aFinder aStack stackCopy|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
	
	stackCopy := aStack.
	
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.

	self assert: ( aStack isEqualTo: stackCopy ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:25:55'!
test07FinderReturnsTopWhenSerched
	|aFinder aStack expectedMatches|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
		
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.
	
	expectedMatches := OrderedCollection new.
	expectedMatches add: 'What is a proverb?'.
	
	self assert: ( (aFinder find: 'What is a proverb?') isEqualTo: expectedMatches ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:35:55'!
test08EmptyResultFindingAnElementWhenWasPoped
	|aFinder aStack expectedMatches anElement|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
		
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.
	
	anElement := aStack pop.
	
	expectedMatches := OrderedCollection new.
	
	self assert: ( (aFinder find: anElement) isEqualTo: expectedMatches ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:38:09'!
test09FinderFindsTop
	|aFinder aStack expectedMatches topElement|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
		
	aFinder := SentenceFinderByPrefix new initializeWith: aStack.	
	
	topElement := 'A journey of a thousand miles begins with a single step'.
	
	expectedMatches := OrderedCollection new.
	expectedMatches add: topElement .
	
	self assert: ( (aFinder find: topElement) isEqualTo: expectedMatches ).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 10:00:13'!
test10ResultUnchangedWhenPushedAnElementWithoutASearchedPrefix
	|aFinder anotherFinder aStack anotherStack|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
	
	anotherStack := aStack copy.
	anotherStack push: 'The sky is Blue'.

	aFinder := SentenceFinderByPrefix new initializeWith: aStack.	
	anotherFinder := SentenceFinderByPrefix new initializeWith: anotherStack.	
	
	self assert: ( (aFinder find: 'What') isEqualTo: (anotherFinder find: 'What')).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 10:00:58'!
test11ResultChangesWhenPushedAnElementWithTheSearchedPrefix
	|aFinder anotherFinder aStack anotherStack|
	
	aStack := OOStack new.
	aStack push: 'What is a proverb?'.
	aStack push: 'What time is it?'.
	aStack push: 'A journey of a thousand miles begins with a single step'.
	
	anotherStack := aStack copy.
	anotherStack push: 'What is your name?'.

	aFinder := SentenceFinderByPrefix new initializeWith: aStack.	
	anotherFinder := SentenceFinderByPrefix new initializeWith: anotherStack.	
	
	self assert: ( (aFinder find: 'What') isNotEqualTo: (anotherFinder find: 'What')).
	! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'internalStackStructure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:01:29'!
isEmpty
	"Se analiza si la pila está vacia."

	^internalStackStructure isEmpty ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 08:59:21'!
pop
	"Se extrae un elemento de la pila y se devuelve como respuesta al mensaje pop, si fuera posible."

	|anExtractedElementValue|
	anExtractedElementValue _ internalStackStructure top.
	internalStackStructure _ internalStackStructure pop.
	^ anExtractedElementValue ! !


!OOStack methodsFor: 'nil' stamp: 'n 4/22/2019 09:01:46'!
initialize
	"Se crea una nueva pila."

	internalStackStructure _ StackBase new.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/22/2019 09:00:53'!
push: anElementValue
	"Se agrega un nuevo elemento a la pila como tope."

	internalStackStructure _ StackBody new initializeWith: anElementValue tail: internalStackStructure.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/22/2019 08:54:14'!
size
	"se analiza la cantidad de elementos que tiene la pila."
	^internalStackStructure size.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/22/2019 09:00:10'!
top
	"se devuelve el valor del elemento que se encuentra en el tope de la pila, si fuera posible"
	
	^internalStackStructure top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'n 4/20/2019 19:21:31'!
stackEmptyErrorDescription
	^ 'Stack is empty'! !



!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'aStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:10:50'!
find: aPrefix
	"Devuelve los elementos de la pila que tienen un prefijo común dado."
	|anElem matchingElems stackSize collectionElemsTemp|
	
	stackSize := aStack size.	
	collectionElemsTemp := OrderedCollection new.
	matchingElems := OrderedCollection new.
	
	stackSize timesRepeat: [
		anElem _ aStack pop.
		collectionElemsTemp addFirst: anElem.
		(anElem beginsWith: aPrefix) ifTrue: [matchingElems add: anElem.] ].
	
	stackSize timesRepeat: [
		anElem _ collectionElemsTemp removeFirst.
		aStack push: anElem.].

	^matchingElems.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 09:11:13'!
initializeWith: unaPila
	"Crea un nuevo finder."
	
	aStack _ unaPila.! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
Object subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:52:55'!
isEmpty
	^true.! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 19:22:29'!
pop
	^self error: 'Stack is empty'.! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:53:47'!
size
	^0.! !

!StackBase methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:54:33'!
top
	^self error: 'Stack is empty'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackBase class' category: #'Stack-Exercise'!
StackBase class
	instanceVariableNames: ''!

!StackBase class methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 19:21:41'!
stackEmptyErrorDescription
	^ 'Stack is empty'! !


!classDefinition: #StackBody category: #'Stack-Exercise'!
Object subclass: #StackBody
	instanceVariableNames: 'tail topValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBody methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 08:36:51'!
initializeWith: anElementValue tail: aTail
	topValue := anElementValue.
	tail:=aTail.
! !

!StackBody methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:53:05'!
isEmpty
	^false.! !

!StackBody methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 08:35:50'!
pop
	^tail.! !

!StackBody methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 08:35:57'!
size
	^(1+tail size).! !

!StackBody methodsFor: 'as yet unclassified' stamp: 'n 4/22/2019 08:36:29'!
top
	^topValue.! !
