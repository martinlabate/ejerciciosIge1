!classDefinition: #TusLibrosClientWindow category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'userTextBox passTextBox user password clientPurchasesList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindow methodsFor: 'refresh' stamp: 'n 7/10/2019 22:45:58'!
refreshPurchasesList
	clientPurchasesList updateList.
! !


!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'n 7/10/2019 23:17:40'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self clientRow;
	addMorph: self passwordRow;
	addMorph: self buttonsRow;
	addMorph: self purchasesRow.! !

!TusLibrosClientWindow methodsFor: 'initialization' stamp: 'n 7/10/2019 22:45:58'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	self model when: #newSubstringsArrived send: #refreshPurchasesList to: self.! !


!TusLibrosClientWindow methodsFor: 'rows' stamp: 'n 7/10/2019 23:17:08'!
buttonsRow
	| sendRequestButton thirdRowLayout listPurchasesButton|
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestCreateCart  label: 'Create Cart'.
	listPurchasesButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestListPurchases  label: 'List Purchases'.
		
	thirdRowLayout := LayoutMorph newRow.
	thirdRowLayout separation: 10;
	padding: #left;
 	addMorph: sendRequestButton;
	addMorph: listPurchasesButton.
	^thirdRowLayout.! !

!TusLibrosClientWindow methodsFor: 'rows' stamp: 'n 7/10/2019 23:15:00'!
clientRow
	| firstRowLayout |
		
	userTextBox := TextModelMorph textProvider: self model textGetter: #clientName textSetter: #clientName: . 
	userTextBox textMorph setProperty: #keyStroke: toValue: [ :key | userTextBox textMorph acceptContents ] .
	userTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 10;
	padding: #left;
	addMorph: (StringMorph contents:'Enter user:        ');
	addMorph: userTextBox.
	^firstRowLayout.! !

!TusLibrosClientWindow methodsFor: 'rows' stamp: 'n 7/10/2019 23:16:50'!
passwordRow
	| secondRowLayout |
	
	passTextBox := TextModelMorph textProvider: self model textGetter: #clientPassword textSetter: #clientPassword:. 
	passTextBox textMorph setProperty: #keyStroke: toValue: [ :key | passTextBox textMorph acceptContents ] .
	passTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 10;
	padding: #left;
	addMorph: (StringMorph contents:'Enter password:');
	addMorph: passTextBox.
	^secondRowLayout.! !

!TusLibrosClientWindow methodsFor: 'rows' stamp: 'n 7/10/2019 23:17:40'!
purchasesRow
	| firstColumnLayoutOfSecondRow rowLayoutOfSecondRow|
	
	clientPurchasesList := PluggableListMorph model: self model listGetter: #purchasesList indexGetter: #purchasesListIndex indexSetter: #purchasesListIndex:.
	clientPurchasesList  borderColor: Color skyBlue.
	clientPurchasesList  borderWidth: 1.
	
	firstColumnLayoutOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Purchases');
	addMorph: clientPurchasesList.

	rowLayoutOfSecondRow := LayoutMorph newRow.
	rowLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'ListPurchases:        ');
	addMorph: firstColumnLayoutOfSecondRow.
		
	^rowLayoutOfSecondRow.! !


!TusLibrosClientWindow methodsFor: 'settings' stamp: 'n 7/10/2019 22:19:50'!
defaultExtent

	^ 600@600! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #TusLibrosVisual!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 22:15:12'!
open
	
	^self new initializeWith: 'TusLibros: CreateCart'.! !


!classDefinition: #TusLibrosClientWindowCartOperator category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindowCartOperator
	instanceVariableNames: 'booksInCart booksList ownerTextBox cardTextBox bookTextBox expirationDateTextBox'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowCartOperator methodsFor: 'initialization' stamp: 'n 7/10/2019 23:16:20'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self addingRow;
	addMorph: self listCartRow;
	addMorph: self cardsRow;
	addMorph: self checkoutRow.
	! !

!TusLibrosClientWindowCartOperator methodsFor: 'initialization' stamp: 'ML 7/10/2019 19:20:11'!
initializeFor: cartId with: webClient andTitle: aTitle.

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModelCartOperator new initializeFor: cartId with: webClient).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.		
	self model when: #newSubstringsArrived send: #refreshBookList to: self.! !


!TusLibrosClientWindowCartOperator methodsFor: 'settings' stamp: 'n 7/10/2019 20:56:37'!
defaultExtent

	^ 1200@600
	! !


!TusLibrosClientWindowCartOperator methodsFor: 'refresh' stamp: 'ML 7/10/2019 19:44:45'!
refreshBookList
	booksInCart updateList.
! !


!TusLibrosClientWindowCartOperator methodsFor: 'rows' stamp: 'n 7/10/2019 23:14:27'!
addingRow
	| firstRowLayout sendRequestButton |
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestAddToCart  label: 'Add To Cart'.

	bookTextBox := TextModelMorph textProvider: self model textGetter: #itemToAdd textSetter: #itemToAdd: . 
	bookTextBox textMorph setProperty: #keyStroke: toValue: [ :key | bookTextBox textMorph acceptContents ] .
	bookTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 20;
	padding: #left;
	addMorph: (StringMorph contents:'AddBook:        ');
	addMorph: bookTextBox;
 	addMorph: sendRequestButton.
	^firstRowLayout.! !

!TusLibrosClientWindowCartOperator methodsFor: 'rows' stamp: 'n 7/10/2019 23:16:08'!
cardsRow
	| secondRowLayout |
	
	cardTextBox := TextModelMorph textProvider: self model textGetter: #cardNumber textSetter: #cardNumber:. 
	cardTextBox textMorph setProperty: #keyStroke: toValue: [ :key | cardTextBox textMorph acceptContents ] .
	cardTextBox  borderWidth: 1; borderColor: Color skyBlue.

	ownerTextBox := TextModelMorph textProvider: self model textGetter: #clientName textSetter: #clientName:. 
	ownerTextBox textMorph setProperty: #keyStroke: toValue: [ :key | ownerTextBox textMorph acceptContents ] .
	ownerTextBox borderWidth: 1; borderColor: Color skyBlue.

	expirationDateTextBox := TextModelMorph textProvider: self model textGetter: #expirationCardDate textSetter: #expirationCardDate:. 
	expirationDateTextBox textMorph setProperty: #keyStroke: toValue: [ :key | expirationDateTextBox textMorph acceptContents ] .
	expirationDateTextBox borderWidth: 1; borderColor: Color skyBlue.
		
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 10;
	padding: #left;
	addMorph: (StringMorph contents:'Enter owner name:');
	addMorph: ownerTextBox;
	addMorph: (StringMorph contents:'Enter card number:');
	addMorph: cardTextBox;
	addMorph: (StringMorph contents:'Enter expitarion date:');
	addMorph: expirationDateTextBox.

	^secondRowLayout.! !

!TusLibrosClientWindowCartOperator methodsFor: 'rows' stamp: 'n 7/10/2019 23:16:20'!
checkoutRow
	| firstRowLayout sendRequestButton |
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestCheckout  label: 'Checkout'.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 20;
	padding: #right;
 	addMorph: sendRequestButton.
	^firstRowLayout.! !

!TusLibrosClientWindowCartOperator methodsFor: 'rows' stamp: 'n 7/10/2019 23:15:52'!
listCartRow
	| firstColumnLayoutOfSecondRow rowLayoutOfSecondRow|
	
	booksInCart := PluggableListMorph model: self model listGetter: #booksList indexGetter: #booksListIndex indexSetter: #booksListIndex:.
	booksInCart  borderColor: Color skyBlue.
	booksInCart  borderWidth: 1.
	
	firstColumnLayoutOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Books');
	addMorph: booksInCart.

	rowLayoutOfSecondRow := LayoutMorph newRow.
	rowLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'ListCart:        ');
	addMorph: firstColumnLayoutOfSecondRow.
		
	^rowLayoutOfSecondRow.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowCartOperator class' category: #TusLibrosVisual!
TusLibrosClientWindowCartOperator class
	instanceVariableNames: ''!

!TusLibrosClientWindowCartOperator class methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:38:58'!
openFor: cartId with: webClient
	
	^self new initializeFor: cartId with: webClient andTitle: 'TusLibros: Operator'.! !


!classDefinition: #TusLibrosClientWindowModelCartOperator category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindowModelCartOperator
	instanceVariableNames: 'userTextBox passTextBox webClient cartId cardNumber clientName itemToAdd itemsInCartList itemsInCartListIndex expirationCardDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowModelCartOperator methodsFor: 'setters' stamp: 'n 7/10/2019 23:02:51'!
booksListIndex: aBooksList
	itemsInCartListIndex _ aBooksList.
	^true! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'setters' stamp: 'n 7/10/2019 23:10:07'!
cardNumber: aNumber
	cardNumber _ aNumber.
	^ true.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'setters' stamp: 'n 7/10/2019 23:10:57'!
clientName: anOwnerName
	clientName _ anOwnerName.
	^true.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'setters' stamp: 'n 7/10/2019 23:10:32'!
expirationCardDate: anExpitarionDate
	expirationCardDate _ anExpitarionDate.
	^true.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'setters' stamp: 'n 7/10/2019 23:07:20'!
itemToAdd: aBook
	itemToAdd _ aBook.
	^true.! !


!TusLibrosClientWindowModelCartOperator methodsFor: 'initialization' stamp: 'n 7/10/2019 23:22:14'!
initializeFor: aCartId with: aWebClient
	
	webClient _ aWebClient.
	cartId _ aCartId.
	itemsInCartListIndex _ 0.
	itemToAdd _ ''.
	itemsInCartList _ OrderedCollection new.
	cardNumber _ ''.
	clientName _ ''.
	expirationCardDate _ ''.! !


!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:02:31'!
booksList
	^itemsInCartList! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:02:51'!
booksListIndex
	^ itemsInCartListIndex! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:09:53'!
cardNumber
	^cardNumber! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:10:47'!
clientName
	^clientName! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:10:22'!
expirationCardDate
	^expirationCardDate! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'getters' stamp: 'n 7/10/2019 23:07:08'!
itemToAdd
	^itemToAdd.! !


!TusLibrosClientWindowModelCartOperator methodsFor: 'request' stamp: 'n 7/10/2019 23:02:31'!
sendRequestAddToCart
	|listRequestResponse addRequestResponse division counter lastDivision internalCounter|
	addRequestResponse _ webClient sendRequestAdd: 1 of: itemToAdd toCartIdentifiedAs: cartId.
	listRequestResponse _ webClient sendRequestListCartIdentifiedAs: cartId.
	itemsInCartList _ OrderedCollection new.
	division _ OrderedCollection new.
	division add: 0.
	counter _ 0.
	internalCounter _ 0.
	listRequestResponse do: [:aChar |
		counter _ counter +1.
		(aChar = $|) ifTrue: 
		[
			internalCounter _ internalCounter +1.
			(internalCounter = 2) ifTrue: 
			[
			division add: counter.
			internalCounter _ 0.
			].
		].
	].
	lastDivision _ division at: (division size).
	1 to: division size do: 
	[:index | 
		((division at: index) = lastDivision) ifTrue: [
			itemsInCartList add: (listRequestResponse copyFrom: ((division at: index) +1)  to: listRequestResponse size).
		] ifFalse: [
			itemsInCartList add: (listRequestResponse copyFrom: ((division at: index) +1)  to: ((division at: (index +1)))-1).
		].
	].
	self triggerEvent: #newSubstringsArrived with: self.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'request' stamp: 'n 7/10/2019 23:03:04'!
sendRequestCheckout
	|response|
	response _ webClient sendRequestCheckOutCartIdentifiedAs: cartId withCreditCardNumbered: cardNumber ownedBy: clientName expiringOn: expirationCardDate.

	self triggerEvent: #newSubstringsArrived with: self.! !


!classDefinition: #TusLibrosClientWindowModel category: #TusLibrosVisual!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'webClient clientPassword clientName cartId purchasesList purchasesListIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowModel methodsFor: 'initialization' stamp: 'n 7/10/2019 22:18:40'!
initialize

	webClient := TusLibrosWebClient new.
	cartId _ ''.
	clientPassword _ ''.
	clientName _ ''.
	purchasesListIndex _ 0.
	purchasesList _ OrderedCollection new.! !


!TusLibrosClientWindowModel methodsFor: 'requests' stamp: 'n 7/10/2019 22:43:31'!
sendRequestListPurchases
	|listRequestResponse division counter lastDivision internalCounter|
	listRequestResponse _ webClient sendRequestListPurchasesOf: clientName authenticatingWith: clientPassword.
	
	self triggerEvent: #newSubstringsArrived with: self.
  
	purchasesList _ OrderedCollection new.
	division _ OrderedCollection new.
	division add: 0.
	counter _ 0.
	internalCounter _ 0.
	listRequestResponse do: [:aChar |
	counter _ counter +1.
	(aChar = $|) ifTrue: 
	[
	internalCounter _ internalCounter +1.
      (internalCounter = 2) ifTrue: 
      [
      division add: counter.
      internalCounter _ 0.
      ].
    ].
  ].
  lastDivision _ division at: (division size).
  1 to: division size do: 
  [:index | 
    ((division at: index) = lastDivision) ifTrue: [
      purchasesList add: ('Total: ',(listRequestResponse copyFrom: ((division at: index) +1)  to: listRequestResponse size)).
    ] ifFalse: [
      purchasesList add: (listRequestResponse copyFrom: ((division at: index) +1)  to: ((division at: (index +1)))-1).
    ].
  ].
  self triggerEvent: #newSubstringsArrived with: self.! !


!TusLibrosClientWindowModel methodsFor: 'setters' stamp: 'n 7/10/2019 23:06:51'!
clientName: aUser
	clientName _ aUser.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'setters' stamp: 'n 7/10/2019 23:05:34'!
clientPassword: aPassword
	clientPassword _ aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'setters' stamp: 'n 7/10/2019 22:17:20'!
purchasesListIndex: aListIndex
	purchasesListIndex _ aListIndex.
	^true.! !


!TusLibrosClientWindowModel methodsFor: 'getters' stamp: 'n 7/10/2019 23:06:37'!
clientName
	^clientName
	! !

!TusLibrosClientWindowModel methodsFor: 'getters' stamp: 'n 7/10/2019 23:05:11'!
clientPassword
	^clientPassword! !

!TusLibrosClientWindowModel methodsFor: 'getters' stamp: 'n 7/10/2019 22:16:39'!
purchasesList
	^purchasesList! !

!TusLibrosClientWindowModel methodsFor: 'getters' stamp: 'n 7/10/2019 22:16:54'!
purchasesListIndex
	^purchasesListIndex! !

!TusLibrosClientWindowModel methodsFor: 'getters' stamp: 'n 7/10/2019 23:33:16'!
sendRequestCreateCart

	cartId := webClient sendRequestCreateCart: clientName withPassword: clientPassword.
	
	TusLibrosClientWindowCartOperator openFor: cartId with: webClient.
	self triggerEvent: #newSubstringsArrived with: self.! !


!classDefinition: #TusLibrosServer category: #TusLibrosVisual!
Object subclass: #TusLibrosServer
	instanceVariableNames: 'webServer port facade catalogo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosServer methodsFor: 'server' stamp: 'n 7/8/2019 20:00:31'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServer methodsFor: 'server' stamp: 'n 7/8/2019 20:00:53'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	! !

!TusLibrosServer methodsFor: 'server' stamp: 'n 7/8/2019 20:01:12'!
startListening
	
	webServer startListener ! !

!TusLibrosServer methodsFor: 'server' stamp: 'n 7/8/2019 20:01:29'!
stopListening
	
	webServer stopListener! !


!TusLibrosServer methodsFor: 'initialization' stamp: 'n 7/8/2019 21:50:37'!
initializeAuthenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog debitingThrought: aMerchantProcessor measuringTimeWith: aClock
	|aSalesBook|
	webServer := WebServer new listenOn: self port.
	
	aSalesBook _ OrderedCollection new.
	facade _ TusLibrosSystemFacade authenticatingWith: aValidUsersAndPasswords acceptingItemsOf: aCatalog registeringOn: aSalesBook debitingThrought: aMerchantProcessor measuringTimeWith: aClock.
	catalogo _ aCatalog.
	
	webServer addService: '/createCart' action:[:request | |user password|
		user _ request fields at:'clientId'.
		password _ request fields at:'password'.
		request send200Response: (self createCartFor: user authenticatedWith: password)].
	
	webServer addService: '/addToCart' action:[:request | |cartId bookId quantity|
		cartId _ request fields at:'cartId'.
		bookId _ request fields at:'bookIsbn'.
		quantity _ request fields at:'bookQuantity'.	
		request send200Response: (self add: quantity of: bookId toCartIdentifiedAs: cartId)].

	webServer addService: '/listCart' action:[:request | |cartId|
		cartId _ request fields at:'cartId'.
		request send200Response: (self listCartIdentifiedAs: cartId)].

	webServer addService: '/checkoutCart' action:[:request | |cartId ccn cced cco|
		cartId _ request fields at:'cartId'.
		ccn _ request fields at:'ccn'.
		cced _ request fields at:'cced'.
		cco _ request fields at:'cco'.
		request send200Response: (self checkOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: cced)].

	webServer addService: '/listPurchases' action:[:request | |aUser aPassword|
		aUser _ request fields at:'clientId'.
		aPassword _ request fields at:'password'.
		request send200Response: (self listPurchasesOf: aUser authenticatingWith: aPassword)].

	"webServer addService: '/substrings' action:[:request | |substringsAsJson sentence substrings |
		
		[sentence := (request fields at:'sentence').
		substrings := sentence substrings.
		substringsAsJson:= WebUtils jsonEncode: (substrings).
		request send200Response: (substringsAsJson)
		 ] 
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]]."! !


!TusLibrosServer methodsFor: 'facade' stamp: 'ML 7/10/2019 18:45:31'!
add: quantity of: bookId toCartIdentifiedAs: cartId
	[facade add: (quantity asInteger) of: bookId toCartIdentifiedAs: (cartId asInteger) .
		^ '0|OK'.] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].! !

!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/10/2019 21:51:24'!
checkOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: cced
	|checkoutId aMonthOfYear aMonth aYear|
	[	aMonth _ ((cced copyFrom: 1 to: 2) asInteger).
		aYear _ (('20', (cced copyFrom: 4 to: 5)) asInteger).
		aMonthOfYear _ Month month: aMonth year: aYear.
		checkoutId _ (facade checkOutCartIdentifiedAs: (cartId asInteger) withCreditCardNumbered: ccn ownedBy: cco expiringOn: aMonthOfYear) total.
		^ '0|',(checkoutId asString).] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].! !

!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/9/2019 21:06:07'!
createCartFor: aUser authenticatedWith: aPassword
	|id|
	[id _ facade createCartFor: aUser authenticatedWith: aPassword. 
		^ '0|',(id asString).] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].
	! !

!TusLibrosServer methodsFor: 'facade' stamp: 'ML 7/10/2019 19:11:05'!
listCartIdentifiedAs: cartId
	|items keys stream|
	[items _ (facade listCartIdentifiedAs: (cartId asInteger)) contents.
		keys _ items keys.
		stream _ String streamContents: 
			[:str |
				str nextPutAll: '0'.
				keys do: [:aKey| 
					str nextPutAll: '|',aKey,'|'.
					str nextPutAll: ((items at: aKey) asString).
					].
			].
		^ stream .] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].! !

!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/8/2019 21:25:40'!
listPurchasesOf: aUser authenticatingWith: aPassword

	|purchases keys stream sum|
	[purchases _ (facade listPurchasesOf: aUser authenticatingWith: aPassword).
		keys _ purchases keys.
		stream _ String streamContents: 
			[:str |
				sum _ 0.
				str nextPutAll: '0'.
				keys do: [:aKey| 
					sum _ sum +(purchases at: aKey).
					str nextPutAll: '|',aKey,'|'.
					str nextPutAll: (((purchases at: aKey)/(catalogo at:aKey)) asString).
					].
				str nextPutAll: '|',(sum asString).
			].
		^ stream .] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].! !


!classDefinition: #TusLibrosWebClient category: #TusLibrosVisual!
Object subclass: #TusLibrosWebClient
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosWebClient methodsFor: 'senders' stamp: 'n 7/10/2019 21:02:58'!
sendRequestAdd: quantity of: bookId toCartIdentifiedAs: cartId

	| fieldDict resp operationSuccess respContent responseMessage |
		
	fieldDict := Dictionary newFromPairs: {'bookQuantity'. quantity.}.
	fieldDict at: 'bookIsbn' put: bookId.
	fieldDict at: 'cartId' put: cartId.
		
	resp:= WebClient htmlSubmit: (self url,'/addToCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[ 
			respContent _ (resp content). 
			operationSuccess _ respContent copyFrom: 1 to: 1.
			responseMessage _ respContent copyFrom: 3 to: (respContent size). 
			(operationSuccess = '0') 
				ifTrue: [^responseMessage.] 
				ifFalse: [^self error: responseMessage.]
			]
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'senders' stamp: 'n 7/10/2019 21:48:24'!
sendRequestCheckOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: cced

	| fieldDict resp operationSuccess respContent responseMessage |
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId.}.
	fieldDict at: 'ccn' put: ccn.
	fieldDict at: 'cced' put: cced.
	fieldDict at: 'cco' put: cco.

	resp:= WebClient htmlSubmit: (self url,'/checkoutCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[ 
			respContent _ (resp content). 
			operationSuccess _ respContent copyFrom: 1 to: 1.
			responseMessage _ respContent copyFrom: 3 to: (respContent size). 
			self halt.
			(operationSuccess = '0') 
				ifTrue: [^responseMessage.] 
				ifFalse: [^self error: responseMessage.]
			]
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'senders' stamp: 'n 7/9/2019 22:37:37'!
sendRequestCreateCart: clientId withPassword: aPassword

	| fieldDict resp respContent responseMessage operationSuccess|
	
	fieldDict := Dictionary newFromPairs: {'clientId'. clientId.}.
	fieldDict at: 'password' put: aPassword.
	
	resp:= WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[
			respContent _ (resp content). 
			operationSuccess _ respContent copyFrom: 1 to: 1.
			responseMessage _ respContent copyFrom: 3 to: (respContent size). 
			(operationSuccess = '0') 
				ifTrue: [^responseMessage.] 
				ifFalse: [^self error: responseMessage.]
			]
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'senders' stamp: 'n 7/10/2019 21:03:13'!
sendRequestListCartIdentifiedAs: cartId

	| fieldDict resp respContent operationSuccess responseMessage|
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId.}.
	
	resp:= WebClient htmlSubmit: (self url,'/listCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[ 
			respContent _ (resp content). 
			operationSuccess _ respContent copyFrom: 1 to: 1.
			responseMessage _ respContent copyFrom: 3 to: (respContent size). 
			(operationSuccess = '0') 
				ifTrue: [^responseMessage.] 
				ifFalse: [^self error: responseMessage.]
			]
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'senders' stamp: 'n 7/10/2019 21:49:35'!
sendRequestListPurchasesOf: aUser authenticatingWith: aPassword

	| fieldDict resp respContent operationSuccess responseMessage|
	fieldDict := Dictionary newFromPairs: {'clientId'. aUser.}.
	fieldDict at: 'password' put: aPassword.
	resp:= WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.

	resp isSuccess 
		ifTrue:[ 
			respContent _ (resp content). 
			operationSuccess _ respContent copyFrom: 1 to: 1.
			responseMessage _ respContent copyFrom: 3 to: (respContent size). 
			(operationSuccess = '0') 
				ifTrue: [^responseMessage.] 
				ifFalse: [^self error: responseMessage.]
			]
		ifFalse:[^self error: resp content]! !


!TusLibrosWebClient methodsFor: 'settings' stamp: 'n 7/8/2019 21:41:53'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosWebClient methodsFor: 'settings' stamp: 'n 7/8/2019 21:42:23'!
url
	
	^'http://localhost:', self port asString! !
