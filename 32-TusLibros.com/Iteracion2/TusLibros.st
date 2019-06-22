!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'ML 6/7/2019 18:08:12'!
aCatalog
	
	^ Dictionary new.! !

!CartTest methodsFor: 'support' stamp: 'ML 6/7/2019 21:21:11'!
aSalesBook
	
	^ Dictionary new.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'ML 6/7/2019 21:36:41'!
defaultCatalog
	
	^ Dictionary newFromPairs: (Array with: (self itemSellByTheStore) with: 200)! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CheckOutTest category: #TusLibros!
TestCase subclass: #CheckOutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 21:27:40'!
test01CantDoACheckoutOfAnEmptyCart
	| aCart aCreditCard aPerson aCatalog aSalesBook |
	aCatalog _ CartTest new defaultCatalog.
	aCart _ Cart acceptingItemsOf: aCatalog.
	aPerson _ 'Pepe'.
	aCreditCard _ 1234.
	aSalesBook _ CartTest new aSalesBook .	
	self should: [ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.] 
	raise: Error 
	withExceptionDo: [:anError| 
		self assert: 'Cant checkout an empty cart' equals: anError messageText.].! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:50:32'!
test02CheckoutKnowsItsClient
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 07 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.
	
	self assert: (aCheckout client = aPerson )! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:50:42'!
test03ACheckoutKnowsItsCart
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.

	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 08 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.
	
	self assert: (aCheckout cart = aCart )! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:50:51'!
test04ACheckoutKnowsItsCard
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.

	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 09 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.
	
	self assert: (aCheckout card = aCreditCard)! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:50:59'!
test05ACheckoutKnowsTotalToPurchase
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 08 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .
	
	self assert: (aCheckout total = (500*peso))! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:08'!
test06AnExipredCardShouldRiseError
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.

	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.
	
	self should: [aCheckout validateCard]
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) = 'La tarjeta está vencida'].! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:15'!
test07AnInvalidCardShouldRiseError

	self should: [CreditCard with: 'aPerson' number: 1234 expirationMonth: 06 expirationYear: (Date today yearNumber).]
	raise: Error
	withExceptionDo: [:anError| self assert: (anError messageText) = 'Numero de tarjeta invalido'].! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:23'!
test08FaildPurchaseSholdRiseError

	| merchantSim aCart aCreditCard aPerson aCatalog aCheckout aSalesBook merchantFeilure |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.

	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .

	merchantFeilure _ MerchantFailure new.
	merchantSim _ MerchantProcessorSimulator forFailure: merchantFeilure .
	self should:[aCheckout finalizePurchase: merchantSim]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = 'Purchase faild horribly']
! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:31'!
test09PurchaseCanBeSuccesful

	| merchantSim aCart aCreditCard aPerson aCatalog aCheckout aSalesBook merchantSuccess |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .

	merchantSuccess _ MerchantSuccess new.
	merchantSim _ MerchantProcessorSimulator forFailure: merchantSuccess .
	
	self assert: (aCheckout finalizePurchase: merchantSim).! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:40'!
test10ACheckoutKnowsItsSalesBook
	| aCart aCreditCard aPerson aCatalog aCheckout aSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).

	aSalesBook _ CartTest new aSalesBook.	
	
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 09 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook.
	
	self assert: (aCheckout salesBook = aSalesBook )! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:47'!
test11TheCartIsEmptyAfterASuccesfulPurchase

	| merchantSim aCart aCreditCard aPerson aCatalog aCheckout aSalesBook merchantSuccess |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .

	merchantSuccess _ MerchantSuccess new.
	merchantSim _ MerchantProcessorSimulator forFailure: merchantSuccess .
	
	self assert: ((aCheckout finalizePurchase: merchantSim) and: ((aCheckout cart) isEmpty))
	
	! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:51:55'!
test12TheCartIsNotEmptyAfterAFeilurePurchase

	| merchantSim aCart aCreditCard aPerson aCatalog aCheckout aSalesBook merchantFailure |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aSalesBook _ CartTest new aSalesBook.

	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .

	merchantFailure _ MerchantFailure new.
	merchantSim _ MerchantProcessorSimulator forFailure: merchantFailure.
	self should:[aCheckout finalizePurchase: merchantSim]
		raise: Error
		withExceptionDo: [:anError | self assert: anError messageText = 'Purchase faild horribly'].
	
	self deny: (((aCheckout cart) isEmpty))
	
	! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:52:03'!
test13SalesBookHasTheCorrectBooksBought

	| merchantSim aCart aCreditCard aPerson aCatalog aCheckout aSalesBook merchantSuccess pepeSalesBook |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aCatalog at: 'HT' put: (700*peso).
	aCatalog at: 'HV' put: (800*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	aCart add: 'HT'.
	aCart add: 'HV'.
	
	aPerson _ 'Pepe'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	aCheckout _ CheckOut with: aCart of: aPerson withCard: aCreditCard andSalesBook: aSalesBook .

	merchantSuccess _ MerchantSuccess new.
	merchantSim _ MerchantProcessorSimulator forFailure: merchantSuccess .
 	aCheckout finalizePurchase: merchantSim.
	pepeSalesBook _ aCheckout salesBook associationAt: aPerson.
	self assert: (pepeSalesBook value includes: 'HP').
	self assert: (pepeSalesBook value includes: 'HT').
	self assert: (pepeSalesBook value includes: 'HV').
	! !

!CheckOutTest methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:53:23'!
test14WongCardOwnerRaiseError

	| aCart aCreditCard aPerson aCatalog aSalesBook anotherPerson |
	aCatalog _ CartTest new aCatalog.
	aCatalog at: 'HP' put: (500*peso).
	aCatalog at: 'HT' put: (700*peso).
	aCatalog at: 'HV' put: (800*peso).
	aSalesBook _ CartTest new aSalesBook.
	aCart _ Cart acceptingItemsOf: aCatalog.
	
	aCart add: 'HP'.
	aCart add: 'HT'.
	aCart add: 'HV'.
	
	aPerson _ 'Pepe'.
	anotherPerson _ 'Juan'.
	aCreditCard _ CreditCard with: aPerson number: 1234567891234567 expirationMonth: 06 expirationYear: (Date today yearNumber).
	self 
	should: [CheckOut with: aCart of: anotherPerson withCard: aCreditCard andSalesBook: aSalesBook .] 
	raise: Error 
	withExceptionDo: [:anError| self assert: anError messageText = 'Tarjeta equivocada']
	

! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'ML 6/7/2019 18:29:44'!
total
	^ items inject: (0*peso) into: [:atotal :anItem| (catalog at: anItem) + atotal ]! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'ML 6/7/2019 21:32:50'!
add: aQuantity of: anItem

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ].
	catalog at: anItem ifAbsent: [ self error: self invalidItemErrorMessage].
	
	1 to: aQuantity do: [:aNumber | items add: anItem]! !

!Cart methodsFor: 'adding' stamp: 'ML 6/9/2019 20:41:30'!
addItemsToBook: aSalesBook ofClient: aClient

	|cartItems|
	aSalesBook at: aClient 
		ifPresent:[
			cartItems _ aSalesBook associationAt: aClient.
			cartItems addAll: items.
			aSalesBook at: aClient put: cartItems] 
		ifAbsent: [
			aSalesBook at: aClient put: items.
			].! !


!Cart methodsFor: 'nil' stamp: 'n 6/9/2019 18:27:34'!
items
	^ items! !


!Cart methodsFor: 'modify' stamp: 'n 6/9/2019 17:36:51'!
getEmpty
	items _ OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CheckOut category: #TusLibros!
Object subclass: #CheckOut
	instanceVariableNames: 'cart client card salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:23:23'!
card
	^card ! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:13:31'!
cart
	^cart! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:13:22'!
client
	^client ! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 18:03:52'!
finalizePurchase: aMerchantProcessor
	((aMerchantProcessor doPurchaseWithCard: card number withExpiration: ((card expirationMonth asString) , (card expirationYear asString)) for: card owner forAmount: self total) = 1 )
	ifTrue:[self error: 'Purchase faild horribly']
	ifFalse:[
		self writeSale.
		cart getEmpty. 
		^true].! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 20:46:58'!
initializeWith: aCart of: aPerson withCard: aCardNumber andSalesBook: aSalesBook
	aCart isEmpty ifTrue: [self error: 'Cant checkout an empty cart'].
	(aCardNumber owner = aPerson) ifFalse: [self error: 'Tarjeta equivocada'].
	cart _ aCart.
	client _ aPerson.
	card _ aCardNumber .
	salesBook _ aSalesBook.! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 21:17:58'!
salesBook
	^salesBook! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:25:30'!
total
	^cart total! !

!CheckOut methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:35:49'!
validateCard
	| hoy |
	hoy _ Date today.
	( (hoy yearNumber > card expirationYear) 
	or: 
	  ( (hoy yearNumber = card expirationYear) 
	    and: (hoy monthIndex  > card expirationMonth) ) ) 
	ifFalse: [self error: 'La tarjeta está vencida'].
! !


!CheckOut methodsFor: 'nil' stamp: 'n 6/9/2019 20:04:34'!
writeSale
	cart addItemsToBook: salesBook ofClient: client.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CheckOut class' category: #TusLibros!
CheckOut class
	instanceVariableNames: ''!

!CheckOut class methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:00:27'!
with: aCart of: aString withCard: aSmallInteger 
	^self new initializeWith: aCart of: aString withCard: aSmallInteger .! !

!CheckOut class methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 21:20:40'!
with: aCart of: aString withCard: aSmallInteger andSalesBook: aSalesBook
	^self new initializeWith: aCart of: aString withCard: aSmallInteger andSalesBook: aSalesBook.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'owner number expirationMonth expirationYear'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 18:22:21'!
checkValidCardNumber: aNumber
	aNumber decimalDigitLength = 16 ifFalse: [self error:'Numero de tarjeta invalido'].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:44:07'!
checkValidNumber: aNumber
	aNumber decimalDigitLength = 16 ifFalse: [self error:'Numero de tarjeta invalido'].! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:23:17'!
expirationMonth
	^expirationMonth! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:23:57'!
expirationYear
	^expirationYear ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 18:22:21'!
initializeWith: aPerson number: aNumber expirationMonth: aMonth expitationYear: aYear
	self checkValidCardNumber: aNumber.
	owner _ aPerson .
	number _ aNumber .
	expirationYear _ aYear.
	expirationMonth _ aMonth.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:34:01'!
number
	^number ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 18:33:51'!
owner
	^owner ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:33:14'!
with: aPerson number: aNumber expirationMonth: aMonth expirationYear: aYear.
	^ self new initializeWith: aPerson number: aNumber  expirationMonth:  aMonth expitationYear: aYear.! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'number fail'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 17:57:21'!
doPurchaseWithCard: aCardNumber withExpiration: anExpirationDate for: aCardOwner forAmount: anAmount.
	^fail value.! !

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'n 6/9/2019 17:48:08'!
intitializeForFailure: aMerchantState
	fail _ aMerchantState .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'ML 6/7/2019 20:57:32'!
forFailure: aBoolean
	^self new intitializeForFailure: aBoolean.! !


!classDefinition: #MerchantProcessorSimulatorState category: #TusLibros!
Object subclass: #MerchantProcessorSimulatorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulatorState methodsFor: 'nil' stamp: 'n 6/9/2019 17:50:17'!
value
	self subclassResponsibility ! !


!classDefinition: #MerchantFailure category: #TusLibros!
MerchantProcessorSimulatorState subclass: #MerchantFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantFailure methodsFor: 'nil' stamp: 'n 6/9/2019 17:50:01'!
value
	^1! !


!classDefinition: #MerchantSuccess category: #TusLibros!
MerchantProcessorSimulatorState subclass: #MerchantSuccess
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantSuccess methodsFor: 'nil' stamp: 'n 6/9/2019 17:49:53'!
value
	^0! !
