!classDefinition: #TusLibrosClientWindow category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: 'userTextBox passTextBox user password'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 11:45:18'!
build1stRow
	| firstRowLayout |
		
	userTextBox := TextModelMorph textProvider: self model textGetter: #userName textSetter: #userName: . 
	userTextBox textMorph setProperty: #keyStroke: toValue: [ :key | userTextBox textMorph acceptContents ] .
	userTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 20;
	padding: #left;
	addMorph: (StringMorph contents:'Enter user:        ');
	addMorph: userTextBox.
	^firstRowLayout.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 19:35:04'!
build2ndRow
	| secondRowLayout |
	
	passTextBox := TextModelMorph textProvider: self model textGetter: #password textSetter: #password:. 
	passTextBox textMorph setProperty: #keyStroke: toValue: [ :key | passTextBox textMorph acceptContents ] .
	passTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	secondRowLayout := LayoutMorph newRow.
	secondRowLayout separation: 20;
	padding: #left;
	addMorph: (StringMorph contents:'Enter password:');
	addMorph: passTextBox.
	^secondRowLayout.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 19:35:19'!
build3rdRow
	| sendRequestButton thirdRowLayout |
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestCreateCart  label: 'Create Cart'.
		
	thirdRowLayout := LayoutMorph newRow.
	thirdRowLayout separation: 20;
	padding: #left;
 	addMorph: sendRequestButton.
	^thirdRowLayout.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 11:40:50'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build2ndRow;
	addMorph: self build3rdRow.! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 22:31:20'!
defaultExtent

	^ 630@435
	! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 23:28:15'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	"self model when: #newSubstringsArrived send: #refreshSubstringList to: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: #TusLibrosVisual!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 22:15:12'!
open
	
	^self new initializeWith: 'TusLibros: CreateCart'.! !


!classDefinition: #TusLibrosClientWindowCartOperator category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindowCartOperator
	instanceVariableNames: 'userTextBox passTextBox booksInCart booksList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:55:51'!
build1stColumn2ndRow
	| firstColumnLayoutOfSecondRow |
	
	booksInCart := PluggableListMorph model: self model listGetter: #booksList indexGetter: #booksListIndex indexSetter: #booksListIndex:.
	booksInCart  borderColor: Color skyBlue.
	booksInCart  borderWidth: 1.
		
	firstColumnLayoutOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutOfSecondRow separation: 5;
	padding: #left;
	addMorph: (StringMorph contents:'Books');
	addMorph: booksInCart.
		
	^firstColumnLayoutOfSecondRow.
	! !

!TusLibrosClientWindowCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:22:02'!
build1stRow
	| firstRowLayout sendRequestButton |
	
	sendRequestButton := PluggableButtonMorph model: self model stateGetter: nil  action: #sendRequestAddToCart  label: 'Add To Cart'.

	userTextBox := TextModelMorph textProvider: self model textGetter: #aBook textSetter: #aBook: . 
	userTextBox textMorph setProperty: #keyStroke: toValue: [ :key | userTextBox textMorph acceptContents ] .
	userTextBox  borderWidth: 1; borderColor: Color skyBlue.
		
	firstRowLayout := LayoutMorph newRow.
	firstRowLayout separation: 20;
	padding: #left;
	addMorph: (StringMorph contents:'AddBook:        ');
	addMorph: userTextBox;
 	addMorph: sendRequestButton.
	^firstRowLayout.! !

!TusLibrosClientWindowCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:58:15'!
buildMorphicWindow
		
	self layoutMorph beColumn;
	separation: 15;
	padding: #left;
	addMorph: self build1stRow;
	addMorph: self build1stColumn2ndRow.! !

!TusLibrosClientWindowCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:18:19'!
defaultExtent

	^ 630@435
	! !

!TusLibrosClientWindowCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:40:03'!
initializeFor: cartId with: webClient andTitle: aTitle.

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModelCartOperator new initializeFor: cartId with: webClient).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	self yourself.
			
	"self model when: #newSubstringsArrived send: #refreshSubstringList to: self."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowCartOperator class' category: #TusLibrosVisual!
TusLibrosClientWindowCartOperator class
	instanceVariableNames: ''!

!TusLibrosClientWindowCartOperator class methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:18:19'!
open
	
	^self new initializeWith: 'TusLibros: CreateCart'.! !

!TusLibrosClientWindowCartOperator class methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:38:58'!
openFor: cartId with: webClient
	
	^self new initializeFor: cartId with: webClient andTitle: 'TusLibros: Operator'.! !


!classDefinition: #TusLibrosClientWindowModelCartOperator category: #TusLibrosVisual!
Panel subclass: #TusLibrosClientWindowModelCartOperator
	instanceVariableNames: 'userTextBox passTextBox booksList webClient cartId book booksListIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:49:09'!
aBook
	^book.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:49:02'!
aBook: aBook
	book _ aBook.
	^true.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:55:11'!
booksList
	^booksList! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:53:33'!
booksListIndex
	^ booksListIndex! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:31:22'!
booksListIndex: aBooksList
	booksListIndex _ aBooksList.
	^true! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:35:20'!
initializeFor: aCartId with: aWebClient
	
	webClient _ aWebClient.
	cartId _ aCartId.
	booksListIndex _ 0.
	book _ ''.
	booksList _ OrderedCollection new.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:27:26'!
sendRequestAddToCart
	|listRequestResponse addRequestResponse|
	addRequestResponse _ webClient sendRequestAdd: 1 of: book toCartIdentifiedAs: cartId.
	self halt.
	listRequestResponse _ webClient sendRequestListCartIdentifiedAs: cartId.
	self triggerEvent: #newSubstringsArrived with: self.! !

!TusLibrosClientWindowModelCartOperator methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:42:51'!
sendRequestCheckout

	"cartId := webClient sendRequestCheckOutCartIdentifiedAs:  withCreditCardNumbered:  ownedBy:  expiringOn:"
	
	self triggerEvent: #newSubstringsArrived with: self.! !


!classDefinition: #TusLibrosClientWindowModel category: #TusLibrosVisual!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'webClient clientPassword clientName cartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosVisual'!

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:36:04'!
initialize

	webClient := TusLibrosWebClient new.
	cartId _ ''.
	clientPassword _ ''.
	clientName _ ''.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 23:24:24'!
password
	^clientPassword! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 23:24:24'!
password: aPassword
	clientPassword _ aPassword.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 21:37:52'!
sendRequestCreateCart

	cartId := webClient sendRequestCreateCart: clientName withPassword: clientPassword.
	
	TusLibrosClientWindowCartOperator openFor: cartId with: webClient.
	self triggerEvent: #newSubstringsArrived with: self.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 23:24:40'!
userName
	^clientName
	! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 23:24:40'!
userName: aUser
	clientName _ aUser.
	^true.! !


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


!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/8/2019 21:04:18'!
add: quantity of: bookId toCartIdentifiedAs: cartId
	[facade add: quantity of: bookId toCartIdentifiedAs: cartId.
		^ '0|OK'.] 
	on: Error 
	do: [:anError| ^ '1|',anError messageText.].! !

!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/8/2019 21:27:05'!
checkOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: cced
	|checkoutId aMonthOfYear aMonth aYear|
	[	aMonth _ ((cced copyFrom: 1 to: 2) asInteger).
		aYear _ (('20', (cced copyFrom: 4 to: 5)) asInteger).
		aMonthOfYear _ Month month: aMonth year: aYear.
		checkoutId _ facade checkOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: aMonthOfYear.
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

!TusLibrosServer methodsFor: 'facade' stamp: 'n 7/8/2019 21:26:39'!
listCartIdentifiedAs: cartId
	|items keys stream|
	[items _ (facade listCartIdentifiedAs: cartId) contents.
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

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 21:41:53'!
port
	
	^port ifNil: [port:=8080].! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 23:04:03'!
sendRequestAdd: quantity of: bookId toCartIdentifiedAs: cartId

	| fieldDict resp operationSuccess respContent responseMessage |
		
	fieldDict := Dictionary newFromPairs: {'bookQuantity'. quantity.}.
	fieldDict at: 'bookIsbn' put: bookId.
	fieldDict at: 'cartId' put: cartId.
		
	resp:= WebClient htmlSubmit: (self url,'/addToCart') fields: fieldDict.
	
	"revisar"
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

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 21:58:57'!
sendRequestCheckOutCartIdentifiedAs: cartId withCreditCardNumbered: ccn ownedBy: cco expiringOn: cced

	| fieldDict resp|
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId.}.
	fieldDict at: 'ccn' put: ccn.
	fieldDict at: 'cced' put: cced.
	fieldDict at: 'cco' put: cco.

	resp:= WebClient htmlSubmit: (self url,'/checkoutCart') fields: fieldDict.
	
	"revisar"
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:37:37'!
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

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/9/2019 22:25:08'!
sendRequestListCartIdentifiedAs: cartId

	| fieldDict resp|
	
	fieldDict := Dictionary newFromPairs: {'cartId'. cartId.}.
	
	resp:= WebClient htmlSubmit: (self url,'/listCart') fields: fieldDict.
	
	"revisar"
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 22:01:01'!
sendRequestListPurchasesOf: aUser authenticatingWith: aPassword

	| fieldDict resp|
	
	fieldDict := Dictionary newFromPairs: {'clientId'. aUser.}.
	fieldDict at: 'password' put: aPassword.
	
	resp:= WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.
	
	"revisar"
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)) asOrderedCollection .] 
		ifFalse:[^self error: resp content]! !

!TusLibrosWebClient methodsFor: 'as yet unclassified' stamp: 'n 7/8/2019 21:42:23'!
url
	
	^'http://localhost:', self port asString! !
