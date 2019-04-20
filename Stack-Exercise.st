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


!classDefinition: #BaseDeStack category: #'Stack-Exercise'!
Object subclass: #BaseDeStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:52:55'!
isEmpty
	^true.! !

!BaseDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 19:02:26'!
pop
	self error: 'Stack is empty'.! !

!BaseDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:53:47'!
size
	^0.! !

!BaseDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:54:33'!
top
	^self error: 'Stack is empty'! !


!classDefinition: #CuerpoDeStack category: #'Stack-Exercise'!
Object subclass: #CuerpoDeStack
	instanceVariableNames: 'prev elem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!CuerpoDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:56:27'!
initializeWith: anElement prev: anterior
	elem := anElement.
	prev:=anterior.
! !

!CuerpoDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:53:05'!
isEmpty
	^false.! !

!CuerpoDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 19:06:22'!
pop
	^elem.! !

!CuerpoDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:54:10'!
size
	^(1+prev size).! !

!CuerpoDeStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:58:20'!
top
	^elem.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 18:55:04'!
isEmpty
	^estado isEmpty ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'n 4/20/2019 19:04:23'!
pop
	|elementoExtraido|
	elementoExtraido _ estado pop.
	estado _ estado prev.! !


!OOStack methodsFor: 'nil' stamp: 'n 4/20/2019 18:41:33'!
initialize
	estado _ BaseDeStack new.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/20/2019 18:58:40'!
push: anElement
	estado _ CuerpoDeStack new initializeWith: anElement prev: estado.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/20/2019 18:53:34'!
size
	^estado size.! !

!OOStack methodsFor: 'nil' stamp: 'n 4/20/2019 18:47:55'!
top
	estado top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !



!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
