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


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:19:03'!
isEmpty

	self subclassResponsibility.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:13:45'!
pop
	
	self subclassResponsibility 
! !


!OOStack methodsFor: 'nil' stamp: 'n 4/16/2019 14:08:58'!
initialize
	^InicioDePila create.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/16/2019 12:20:40'!
push: anElement
	
	self subclassResponsibility.
	! !

!OOStack methodsFor: 'nil' stamp: 'n 4/16/2019 12:24:52'!
size
	self subclassResponsibility.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/16/2019 12:26:00'!
top
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'nil' stamp: 'ML 4/15/2019 21:05:21'!
initialize
	^self new initialize ! !


!classDefinition: #Elemento category: #'Stack-Exercise'!
OOStack subclass: #Elemento
	instanceVariableNames: 'prevElem value nextElem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:35:49'!
initializeWith: anElement prev: previo
	prevElem := previo.
	value := anElement.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:19:24'!
isEmpty
	^ false.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 14:04:47'!
pop
	prevElem removeNext.
	^value.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:50:40'!
push: anElement
	nextElem := Elemento with: anElement prev: self.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:18:16'!
removeNext
	nextElem := nil! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:25:40'!
size
	^ (1+ prevElem size).! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:36:01'!
top
	^self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Elemento class' category: #'Stack-Exercise'!
Elemento class
	instanceVariableNames: ''!

!Elemento class methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:44:12'!
with: anElement prev: previo
	^self new initializeWith: anElement prev: previo.! !


!classDefinition: #InicioDePila category: #'Stack-Exercise'!
OOStack subclass: #InicioDePila
	instanceVariableNames: 'nextElem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:27:54'!
initialize
	nextElem:=nil ! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:19:16'!
isEmpty
	^ true.! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:14:19'!
pop
	self error: 'Stack is empty'.! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:39:46'!
push: anElement

	nextElem := Elemento with: anElement prev: self.! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:17:53'!
removeNext
	nextElem := nil! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:25:09'!
size
	^0.! !

!InicioDePila methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:26:42'!
top
	self error: 'Stack is empty'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InicioDePila class' category: #'Stack-Exercise'!
InicioDePila class
	instanceVariableNames: ''!

!InicioDePila class methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:41:24'!
create
	^ self new initialize .! !

!InicioDePila class methodsFor: 'as yet unclassified' stamp: 'n 4/16/2019 12:27:37'!
initialize
	^ self new initialize .! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

OOStack initialize!
InicioDePila initialize!