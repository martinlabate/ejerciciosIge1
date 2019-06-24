!classDefinition: #ApiRestInternaTest category: #TusLibros!
TestCase subclass: #ApiRestInternaTest
	instanceVariableNames: 'testObjectsFactory debitBehavior validatorBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestInternaTest methodsFor: 'setUp' stamp: 'ML 6/23/2019 21:38:03'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!ApiRestInternaTest methodsFor: 'setUp' stamp: 'ML 6/23/2019 22:42:01'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	validatorBehavior _ [:anUserId :aPasword| ].! !

!ApiRestInternaTest methodsFor: 'setUp' stamp: 'ML 6/23/2019 23:01:21'!
validate: aClienteID withPassword: aPassword 
	^validatorBehavior value: aClienteID value: aPassword ! !


!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:17:50'!
testAddingBookToCartAddsTheBook
	
	|aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	self assert: ((unaCaraInterna listCart: aCartId) size = 1).	
	self assert: ((unaCaraInterna listCart: aCartId) includes: ((testObjectsFactory itemSellByTheStore))).! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:09:28'!
testAddingCartAddsCart
	
	| unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor: self andValidator: self.
	unaCaraInterna createCartOf: clienteID withPass: password.
	
	self deny: (unaCaraInterna listCarts isEmpty).! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 00:21:59'!
testCanGetClientPurchases
	
	|aCartId unaCaraInterna clienteID password otherClientId clientPurchases |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	otherClientId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: otherClientId withQuantity: 4.
	unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthToday)  andBelongsTo: 'Pepe'.
	unaCaraInterna checkOutCart: otherClientId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthToday)  andBelongsTo: 'Pepe'.
	
	clientPurchases _ unaCaraInterna listPurchasesOf: clienteID withPassword: password.
	
	self assert: (clientPurchases total = 50).
	self assert: ((clientPurchases items) size = 5).
	self assert: ((clientPurchases items) includes: (testObjectsFactory itemSellByTheStore)).
	self assert: (((clientPurchases items) occurrencesOf: (testObjectsFactory itemSellByTheStore)) = 5)! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 01:24:19'!
testCannotAddBooksToExpiredCart
	
	|aCartId unaCaraInterna clienteID password aCart |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	aCart _ (unaCaraInterna listCarts) at: aCartId. 
	unaCaraInterna update: aCartId withCart: aCart  at: DateAndTime yesterday.
	
	self should: [unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Invalid Cart')]. ! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'n 6/24/2019 11:02:10'!
testCannotAddBooksToInexistantCart
	
	|aCartId unaCaraInterna |
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ 1.
	self should: [unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Inexistant Cart Id')]. ! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:40:47'!
testCannotCheckoutWithExpiredCard
	
	|aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	
	self should: [unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthAYearAgo)  andBelongsTo: 'Pepe' ] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = (Cashier canNotChargeAnExpiredCreditCardErrorMessage))]. 
	 ! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:19:57'!
testCannotCheckoutWithInvalidCard
	
	|aStore aCartId unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	aStore _ StoreTestObjectsFactory new.
	unaCaraInterna _ ApiRestInterna withCatalog: aStore defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (aStore itemSellByTheStore) toCart: aCartId withQuantity: 1.
	
	self should: [unaCaraInterna checkOutCart: aCartId withCard: 123 thatExpires: (Date tomorrow )  andBelongsTo: 'Pepe' ] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Número de tarjeta inválido')]. 
	 ! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 00:14:33'!
testCannotCreateCartWithInvalidUser
	
	|unaCaraInterna clienteID password |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	
	
	validatorBehavior _ [:aClientId :aPassword | 
		self error:'Invalid user'
		].
	self should: [unaCaraInterna createCartOf: clienteID withPass: password.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Invalid user')]. 

	 
	! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:46:46'!
testCartCanBeBought
	
	|aCartId unaCaraInterna clienteID password aTransactionId |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.

	aTransactionId _ unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthToday)  andBelongsTo: 'Pepe'.
	
	self deny: aTransactionId isNil! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 01:20:10'!
testExpiredCartCannotBeBought
	
	|aCartId unaCaraInterna clienteID password aTransactionId aCart |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.
	aCart _ (unaCaraInterna listCarts) at: aCartId. 
	
	unaCaraInterna update: aCartId withCart: aCart  at: DateAndTime yesterday.
	
	self should: [aTransactionId _ unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthToday)  andBelongsTo: 'Pepe'.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Invalid Cart')]. 
	self assert: aTransactionId isNil! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 01:22:48'!
testExpiredCartCannotListed
	
	|aCartId unaCaraInterna clienteID password aListOfItems aCart |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.
	aCart _ (unaCaraInterna listCarts) at: aCartId. 
	
	unaCaraInterna update: aCartId withCart: aCart  at: DateAndTime yesterday.
	
	self should: [aListOfItems _ unaCaraInterna listCart: aCartId.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Invalid Cart')]. 
	self assert: aListOfItems isNil! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/23/2019 23:08:25'!
testNewApiRestInternaHasNoCarts
	
	| unaInterfaz|
	unaInterfaz _ ApiRestInterna withCatalog: (testObjectsFactory defaultCatalog) merchatProcessor: self andValidator: self.
	
	self assert: (unaInterfaz listCarts isEmpty).! !

!ApiRestInternaTest methodsFor: 'test' stamp: 'ML 6/24/2019 01:31:08'!
testSoldCartCannorBeListed
	
	|aCartId unaCaraInterna clienteID password aListOfItems |
	clienteID _ 1.
	password _ 1.
	unaCaraInterna _ ApiRestInterna withCatalog: testObjectsFactory defaultCatalog merchatProcessor:self andValidator: self.
	aCartId _ unaCaraInterna createCartOf: clienteID withPass: password.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 1.
	unaCaraInterna add: (testObjectsFactory itemSellByTheStore) toCart: aCartId withQuantity: 4.

	 unaCaraInterna checkOutCart: aCartId withCard: 1231231231231233 thatExpires: (testObjectsFactory monthToday)  andBelongsTo: 'Pepe'.
	
	self should: [aListOfItems _ unaCaraInterna listCart: aCartId.] raise: Error withExceptionDo: [:anError| self assert: (anError messageText = 'Invalid Cart')]. 
	
	self assert: aListOfItems isNil! !


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
	instanceVariableNames: 'merchantProcessor lastCartId lastTransactionId carts generalSalesBook generalCatalog userValidator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ApiRestInterna methodsFor: 'testing' stamp: 'ML 6/24/2019 01:27:47'!
isCartValid: aCartID
	
	|aCart|
	aCart _ carts at: aCartID ifAbsent: [self error:'Inexistant Cart Id'].
	aCart isInvalid ifTrue: [
		carts removeKey: aCartID.
		self error:'Invalid Cart'.
		]! !


!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/24/2019 00:32:43'!
add: aBook toCart: aCartID withQuantity: aQuantity
	|aCart|
	self isCartValid: aCartID.
	aCart _ carts at: aCartID.
	aCart add: aQuantity of: aBook.

	self update: aCartID withCart: aCart at: DateAndTime now! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/24/2019 00:33:59'!
createCartOf: aClienteID withPass: aPassword
	| aCart cartID |
	userValidator validate: aClienteID withPassword: aPassword .
	cartID _ self generateCartID.
	aCart _ Cart acceptingItemsOf: generalCatalog for: aClienteID .
	self update: cartID withCart: aCart at: DateAndTime now.
	^ cartID ! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/21/2019 20:42:03'!
generateCartID
	
	lastCartId _ lastCartId +1.
	^ lastCartId! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/24/2019 00:34:18'!
listCart: aCartID
	|aCart|
	self isCartValid: aCartID.
	aCart _ carts at: aCartID.
	self update: aCartID withCart: aCart at: DateAndTime now.
	^aCart getAllItems.! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/23/2019 22:13:20'!
listCarts
	^ carts ! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/24/2019 00:10:24'!
listPurchasesOf: aClientID withPassword: aPassword
	|saleList bagOfSales total|
	
	userValidator validate: aClientID withPassword: aPassword.
	bagOfSales _ Bag new.
	total  _ 0.
	saleList _ generalSalesBook at:aClientID.
	
	saleList do: [:aSale | 
		bagOfSales addAll: aSale items.
		total _ total + aSale total.
		].
	
	^Sale of: total withItems: bagOfSales .! !

!ApiRestInterna methodsFor: 'cart' stamp: 'ML 6/24/2019 00:33:40'!
update: aCartId withCart: aCart at: aDateTime
	
	aCart  setLastACtivity: aDateTime.
	carts at: aCartId put: aCart.! !


!ApiRestInterna methodsFor: 'checkout' stamp: 'ML 6/24/2019 01:38:18'!
checkOutCart: aCartID withCard: aCardNumber thatExpires: aMonthOfYear andBelongsTo: aName
	|aCreditCard aCashier aCart aSalesBook|

	self isCartValid: aCartID.
	aCart _ carts at: aCartID.

	aCreditCard _ CreditCard expiringOn: aMonthOfYear withNumber: aCardNumber.
	aSalesBook _ generalSalesBook at: aCart clientID ifAbsentPut: [OrderedCollection new].

	aCashier _ Cashier toCheckout: aCart  charging: aCreditCard throught: merchantProcessor on: Date today registeringOn: aSalesBook.


	aCashier checkOut.

	generalSalesBook at: aCart clientID put: aSalesBook.
	aCart  sold.
	carts at: aCartID put: aCart . 
	^ self generateTransactionID .! !

!ApiRestInterna methodsFor: 'checkout' stamp: 'ML 6/21/2019 20:42:20'!
generateTransactionID
	
	lastTransactionId _ lastTransactionId +1.
	^ lastTransactionId! !


!ApiRestInterna methodsFor: 'initialization' stamp: 'ML 6/23/2019 23:00:45'!
initializeWithCatalog: aCatalog merchatProcessor: aMerchantProcessor andValidator: aUserValidator
	carts _ Dictionary new.
	generalCatalog _ aCatalog.
	generalSalesBook _ Dictionary new.
	lastCartId _ 0.
	lastTransactionId _ 0.
	merchantProcessor _ aMerchantProcessor.
	userValidator _ aUserValidator .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ApiRestInterna class' category: #TusLibros!
ApiRestInterna class
	instanceVariableNames: ''!

!ApiRestInterna class methodsFor: 'as yet unclassified' stamp: 'ML 6/23/2019 23:01:03'!
withCatalog: aCatalog merchatProcessor: aMerchantProcessor andValidator: userValidator 
	^self new initializeWithCatalog: aCatalog merchatProcessor: aMerchantProcessor andValidator: userValidator.! !


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


!Cart methodsFor: 'queries' stamp: 'ML 6/21/2019 20:16:48'!
clientID
	^clientId ! !

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

!Cart methodsFor: 'testing' stamp: 'ML 6/24/2019 01:17:32'!
isInvalid
	^ sold or: (lastActivity < ( DateAndTime now - (Duration minutes: 30)))! !

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

!Cashier methodsFor: 'checkout - private' stamp: 'ML 6/23/2019 21:45:49'!
createSale

	^ Sale of: total withItems: cart getAllItems .
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


!Cashier methodsFor: 'initialization' stamp: 'ML 6/24/2019 01:33:43'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

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

!Cashier class methodsFor: 'assertions' stamp: 'ML 6/24/2019 01:35:58'!
assertIsValidCardNumber: aCreditCardNumber 

	(aCreditCardNumber decimalDigitLength = 16) ifFalse: [self error: 'Número de tarjeta inválido']! !


!Cashier class methodsFor: 'instance creation' stamp: 'ML 6/24/2019 01:36:17'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	self assertIsValidCardNumber: aCreditCard number.
	
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

!CreditCard methodsFor: 'testing' stamp: 'ML 6/23/2019 22:23:14'!
isExpiredOn: aDate 

	^(expiration start) < ((Month month: aDate monthIndex year: aDate yearNumber) start).
! !


!CreditCard methodsFor: 'initialization' stamp: 'ML 6/21/2019 19:39:50'!
initializeExpiringOn: aMonth withNumber: aNumber
	
	expiration _ aMonth .
	number _ aNumber.! !


!CreditCard methodsFor: 'observadores' stamp: 'ML 6/21/2019 21:42:47'!
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

!Sale methodsFor: 'initialization' stamp: 'ML 6/21/2019 20:07:06'!
initializeTotal: aTotal withItems: someItems

	total _ aTotal.
	items _ someItems.! !


!Sale methodsFor: 'observadores' stamp: 'ML 6/21/2019 20:34:54'!
items
	^items.! !

!Sale methodsFor: 'observadores' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !

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


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ML 6/23/2019 23:40:47'!
monthAYearAgo
	
	^ (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'ML 6/23/2019 23:41:29'!
monthToday
	
	^ (Month month: today monthIndex year: today yearNumber)! !

!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
