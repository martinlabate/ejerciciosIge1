!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:11:29'!
addAndSuspendCostumer: aCostumer Of: customerBook

	customerBook addCustomerNamed: aCostumer .
	customerBook suspendCustomerNamed: aCostumer .

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 19:55:05'!
checkFailureOf: operation withError: errorType checking: asserts

	[ operation value.
	self fail ]
		on: errorType 
		do: [ :anError | asserts value: anError.]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:07:47'!
checkNumberOfActiveCostumers: activeCostumers SuspendedCostumers: suspendedCostumers Of: costumerBook

	self assert: activeCostumers equals: costumerBook numberOfActiveCustomers.
	self assert: suspendedCostumers equals: costumerBook numberOfSuspendedCustomers.
	self assert: (activeCostumers+suspendedCostumers) equals: costumerBook numberOfCustomers.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 19:37:21'!
do: operation inMax: miliseconds

	|millisecondsBeforeRunning millisecondsAfterRunning |
		
	millisecondsBeforeRunning := self getCurrentTimeInMilliseconds.
	operation value.
	millisecondsAfterRunning := self getCurrentTimeInMilliseconds.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < miliseconds
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 19:33:36'!
getCurrentTimeInMilliseconds
	^Time millisecondClockValue * millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 21:25:25'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook|
	
	customerBook := CustomerBook new.
	
	self do: [customerBook addCustomerNamed: 'John Lennon'] 
	inMax: 50 * millisecond.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 21:25:31'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook millisecondsBeforeRunning millisecondsAfterRunning paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self do: [customerBook removeCustomerNamed: paulMcCartney] 
	inMax: 100 * millisecond.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 21:25:10'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self checkFailureOf: [customerBook addCustomerNamed: ''] 
	withError: Error 
	checking: [:anError|self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. self assert: customerBook isEmpty].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:48:17'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self checkFailureOf: [customerBook removeCustomerNamed: 'Paul McCartney'] 
	withError: NotFound 
	checking: [:anError | self assert: customerBook numberOfCustomers = 1. self assert: (customerBook includesCustomerNamed: johnLennon)]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:11:49'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCostumer: paulMcCartney Of: customerBook.
		
	self checkNumberOfActiveCostumers: 0 SuspendedCostumers: 1 Of: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:27:26'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addAndSuspendCostumer: paulMcCartney Of: customerBook.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkNumberOfActiveCostumers: 0 SuspendedCostumers: 0 Of: customerBook. 
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 20:28:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self checkFailureOf: [customerBook suspendCustomerNamed: 'Paul McCartney'.]  
	withError: CantSuspend 
	checking: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon).]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'n 4/4/2019 21:24:04'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addAndSuspendCostumer: johnLennon Of: customerBook.

	self checkFailureOf: [customerBook suspendCustomerNamed: johnLennon.] 
	withError: CantSuspend 
	checking: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon).]
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active class'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 21:27:07'!
addCustomerNamed: aCustomer

	aCustomer isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aCustomer) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aCustomer ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 20:43:29'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 21:27:29'!
removeCustomerNamed: aCustomer 
	active remove: aCustomer
	 ifAbsent: [suspended remove: aCustomer
		 ifAbsent: [^NotFound signal.]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 20:45:01'!
signalCustomerAlreadyExists 

	self signalCustomerWithMessage: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 20:46:37'!
signalCustomerNameCannotBeEmpty 

	self signalCustomerWithMessage: self class customerCanNotBeEmptyErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 21:28:06'!
signalCustomerWithMessage: aMessage

	self error: aMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'n 4/4/2019 21:27:51'!
suspendCustomerNamed: aCustomer 
	
	(active includes: aCustomer) ifFalse: [^CantSuspend signal].
	
	active remove: aCustomer.
	
	suspended add: aCustomer.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
