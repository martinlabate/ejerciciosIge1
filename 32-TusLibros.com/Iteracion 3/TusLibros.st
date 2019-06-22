!classDefinition: #ApiRestInternaTest category: #TusLibros!
TestCase subclass: #ApiRestInternaTest
	instanceVariableNames: 'diccionarioIDCarrito salesBookGeneral'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestInternaTest methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:57:47'!
test00
	
	| unaInterfaz|
	unaInterfaz _ ApiRestInterna withCatalog: (StoreTestObjectsFactory new defaultCatalog) andMerchatProcessor: self.
	
	self assert: (unaInterfaz listCarts isEmpty).! !

!ApiRestInternaTest methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:53:35'!
test01
	
	| unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: StoreTestObjectsFactory new defaultCatalog andMerchatProcessor: self.
	unaCaraInterna createCartOf: clienteID withPass: password.
	
	self deny: (unaCaraInterna listCarts isEmpty).! !

!ApiRestInternaTest methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:53:42'!
test02
	
	|aStore aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	aStore _ StoreTestObjectsFactory new.
	unaCaraInterna _ ApiRestInterna withCatalog: aStore defaultCatalog andMerchatProcessor:self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (aStore itemSellByTheStore) toCart: aCartId withQuantity: 1.
	self assert: ((unaCaraInterna listCart: aCartId) size = 1)! !

!ApiRestInternaTest methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:57:37'!
test03
	
	|aStore aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	aStore _ StoreTestObjectsFactory new.
	unaCaraInterna _ ApiRestInterna withCatalog: aStore defaultCatalog andMerchatProcessor:self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (aStore itemSellByTheStore) toCart: aCartId withQuantity: 1.
	
	self should: [unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (Date yesterday)  andBelongsTo: 'Pepe' ] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = (Cashier canNotChargeAnExpiredCreditCardErrorMessage))]. 
	 ! !

!ApiRestInternaTest methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:53:59'!
test04
	
	|aStore aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	aStore _ StoreTestObjectsFactory new.
	unaCaraInterna _ ApiRestInterna withCatalog: aStore defaultCatalog andMerchatProcessor:self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (aStore itemSellByTheStore) toCart: aCartId withQuantity: 1.
	
	self should: [unaCaraInterna checkOutCart: aCartId withCard: 123 thatExpires: (Date tomorrow )  andBelongsTo: 'Pepe' ] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Número de tarjeta inválido')]. 
	 ! !


!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #ApiRestInterna category: #TusLibros!
Object subclass: #ApiRestInterna
	instanceVariableNames: 'diccionarioIDCarrito salesBookGeneral catalogoGeneral merchantProcessor lastCartId lastTransactionId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 19:26:02'!
add: aBook toCart: aCartID withQuantity: aQuantity
	|aCart|
	self isCartValid: aCartID.
	aCart _ diccionarioIDCarrito at: aCartID.
	aCart add: aQuantity of: aBook.
	aCart  setLastACtivity: DateAndTime now.
	diccionarioIDCarrito at: aCartID put: aCart.! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:20:22'!
cartIsNotEmpty: aCartID
	
	((diccionarioIDCarrito at: aCartID) isEmpty) ifTrue: [
		self error:'El carrito está vacío'.
		]! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:44:13'!
checkOutCart: aCartID withCard: aCardNumber thatExpires: aMonthOfYear andBelongsTo: aName
	|aCreditCard aCashier aCart aSalesBook|

	self isCartValid: aCartID.
	aCart _ diccionarioIDCarrito at: aCartID.

	aCreditCard _ CreditCard expiringOn: aMonthOfYear withNumber: aCardNumber.
	aSalesBook _ salesBookGeneral at: aCart clientID ifAbsentPut: [OrderedCollection new].

	aCashier _ Cashier toCheckout: aCart  charging: aCreditCard throught: merchantProcessor on: Date today registeringOn: aSalesBook.


	aCashier checkOut.

	salesBookGeneral at: aCart clientID put: aSalesBook.
	aCart  sold.
	diccionarioIDCarrito at: aCartID put: aCart . 
	^ self generateTransactionID .! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:14:20'!
createCartOf: clienteID withPass: password
	| aCart cartID |
	cartID _ self generateCartID.
	aCart _ Cart acceptingItemsOf: catalogoGeneral for: clienteID .
	aCart setLastACtivity: DateAndTime now.
	diccionarioIDCarrito at: cartID put: aCart.
	^ cartID ! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:42:03'!
generateCartID
	
	lastCartId _ lastCartId +1.
	^ lastCartId! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:42:20'!
generateTransactionID
	
	lastTransactionId _ lastTransactionId +1.
	^ lastTransactionId! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:54:37'!
initializeWithCatalog: aCatalog andMerchatProcessor: aMerchantProcessor
	diccionarioIDCarrito _ Dictionary new.
	catalogoGeneral _ aCatalog.
	salesBookGeneral _ Dictionary new.
	lastCartId _ 0.
	lastTransactionId _ 0.
	merchantProcessor _ aMerchantProcessor.! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:50:35'!
isCartValid: aCartID
	
	|aCart|
	aCart _ diccionarioIDCarrito at: aCartID ifAbsent: [self error:'Id de carrito inexistente'].
	aCart isInvalid ifTrue: [
		diccionarioIDCarrito remove: aCartID.
		self error:'Este carrito es invalido'.
		]! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:23:19'!
listCart: aCartID
	|aCart|
	self isCartValid: aCartID.
	aCart _ diccionarioIDCarrito at: aCartID.
	aCart  setLastACtivity: DateAndTime now.
	diccionarioIDCarrito at: aCartID put: aCart .
	^aCart getAllItems.! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 18:17:47'!
listCarts
	^ diccionarioIDCarrito ! !

!ApiRestInterna methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:36:39'!
listPurchases: aClientID withPassword: aPassword
	|saleList bagOfSales total|
	
	bagOfSales _ Bag new.
	total  _ 0.
	saleList _ diccionarioIDCarrito at:aClientID.
	
	saleList do: [:aSale | 
		bagOfSales addAll: aSale items.
		total _ total + aSale total.
		].
	
	^Sale of: total withItems: bagOfSales .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRestInterna class' category: #TusLibros!
ApiRestInterna class
	instanceVariableNames: ''!

!ApiRestInterna class methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:55:55'!
withCatalog: aCatalog andMerchatProcessor: aMerchantProcessor
	^self new initializeWithCatalog: aCatalog andMerchatProcessor: aMerchantProcessor .! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items lastActivity sold clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'ML 6/21/2019 18:27:20'!
getLastActivity
	^lastActivity ! !

!Cart methodsFor: 'assertions' stamp: 'ML 6/21/2019 18:27:57'!
setLastACtivity: newActivityTime

	lastActivity _ newActivityTime.! !


!Cart methodsFor: 'initialization' stamp: 'ML 6/21/2019 20:15:03'!
initializeAcceptingItemsOf: aCatalog for: aClientId

	catalog := aCatalog.
	items := OrderedCollection new.
	sold _ false.
	clientId _ aClientId ! !


!Cart methodsFor: 'queries' stamp: 'ML 6/21/2019 19:23:01'!
getAllItems

	^items ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'ML 6/21/2019 19:07:12'!
isInvalid
	^ sold or: ((DateAndTime now - lastActivity ) minutes >( 30*minute))! !

!Cart methodsFor: 'testing' stamp: 'ML 6/21/2019 20:01:45'!
sold
	sold _ true.! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:16:48'!
clientID
	^clientId ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'ML 6/21/2019 20:15:19'!
acceptingItemsOf: aCatalog for: aClientId

	^self new initializeAcceptingItemsOf: aCatalog for: aClientId .! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ML 6/21/2019 20:09:16'!
createSale

	^ Sale of: total withItems: cart items .
! !

!Cashier methodsFor: 'checkout - private' stamp: 'ML 6/21/2019 19:50:21'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'ML 6/21/2019 20:52:43'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	self isValidCardNumber: aCreditCard number.
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !


!Cashier methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:17:28'!
isValidCardNumber: aCreditCardNumber
	^ (aCreditCardNumber decimalDigitLength = 16) ifFalse: [self error: 'Número de tarjeta inválido']! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'ML 6/21/2019 21:44:26'!
isExpiredOn: aDate 
	|expirationDasd|
	expirationDasd  _ (expiration start) < ((Month month: aDate monthIndex year: aDate yearNumber) start).
	^expirationDasd ! !


!CreditCard methodsFor: 'initialization' stamp: 'ML 6/21/2019 19:39:50'!
initializeExpiringOn: aMonth withNumber: aNumber
	
	expiration _ aMonth .
	number _ aNumber.! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 21:42:47'!
number
	^ number.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ML 6/21/2019 19:38:23'!
expiringOn: aMonth withNumber: aNumber
	
	^self new initializeExpiringOn: aMonth withNumber: aNumber .! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'ML 6/21/2019 20:07:06'!
initializeTotal: aTotal withItems: someItems

	total _ aTotal.
	items _ someItems.! !


!Sale methodsFor: 'as yet unclassified' stamp: 'ML 6/21/2019 20:34:54'!
items
	^items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'ML 6/21/2019 20:08:39'!
of: aTotal withItems: someItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: someItems .! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'ML 6/21/2019 20:14:35'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog for: 123! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ML 6/21/2019 19:36:50'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withNumber: 4242424242424242! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ML 6/21/2019 19:36:59'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withNumber: 4242424242424242! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
