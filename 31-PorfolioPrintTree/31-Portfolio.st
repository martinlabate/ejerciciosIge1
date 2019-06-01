!classDefinition: #PortfolioTest category: #'31-Portfolio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'31-Portfolio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportsTest category: #'31-Portfolio'!
TestCase subclass: #ReportsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:29:14'!
testGivenAPortfolioThenTheAccountSummaryReportsItsSummary
	|aSummary anAccount aDeposit aWithdraw aTransference anotherAccount aPortfolio |
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit for: 1000.
	aWithdraw _ Withdraw for: 70.
	anAccount register: aDeposit.
	anAccount register: aWithdraw.
	
	anotherAccount _ ReceptiveAccount new.
	
	aTransference _ Transfer with: 200 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 20 from: anotherAccount to: anAccount .
	
	aPortfolio _ Portfolio new.
	aPortfolio add: anAccount.
	
	aSummary _ AccountSummary new.
	self assert: ((aSummary for: aPortfolio) = 'Deposito por 1000. Extracción por 70. Salida por transferencia de 200. Entrada por transferencia de 20. Balance 750.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:29:04'!
testGivenAPortfolioThenTheTransferNetReportsItsTransferNetValue
	|aTransferNetReporter anAccount aDeposit aWithdraw aTransference anotherAccount aPortfolio |
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit for: 1000.
	aWithdraw _ Withdraw for: 70.
	anAccount register: aDeposit.
	anAccount register: aWithdraw.
	
	anotherAccount _ ReceptiveAccount new.
	
	aTransference _ Transfer with: 200 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 100 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 30 from: anotherAccount to: anAccount . 
	
	aPortfolio _ Portfolio new.
	aPortfolio add: anAccount.
	
	aTransferNetReporter _ TransferNet new.
	self assert: ((aTransferNetReporter for: aPortfolio) = 'Neto de transferencias -270.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:04:24'!
testGivenAnAccountThenTheAccountSummaryReportsItsSummary
	|aSummary anAccount aDeposit aWithdraw aTransference anotherAccount|
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit for: 1000.
	aWithdraw _ Withdraw for: 70.
	anAccount register: aDeposit.
	anAccount register: aWithdraw.
	
	anotherAccount _ ReceptiveAccount new.
	
	aTransference _ Transfer with: 200 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 20 from: anotherAccount to: anAccount .
	
	aSummary _ AccountSummary new.
	self assert: ((aSummary for: anAccount) = 'Deposito por 1000. Extracción por 70. Salida por transferencia de 200. Entrada por transferencia de 20. Balance 750.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:21:55'!
testGivenAnAccountThenTheTransferNetReportsItsTransferNetValue
	|aTransferNetReporter anAccount aDeposit aWithdraw aTransference anotherAccount|
	anAccount _ ReceptiveAccount new.
	aDeposit _ Deposit for: 1000.
	aWithdraw _ Withdraw for: 70.
	anAccount register: aDeposit.
	anAccount register: aWithdraw.
	
	anotherAccount _ ReceptiveAccount new.
	
	aTransference _ Transfer with: 200 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 100 from: anAccount to: anotherAccount. 
	aTransference _ Transfer with: 30 from: anotherAccount to: anAccount . 
	
	aTransferNetReporter _ TransferNet new.
	self assert: ((aTransferNetReporter for: anAccount) = 'Neto de transferencias -270.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:30:32'!
testGivenAnEmptyAccountThenTheAccountSummaryReportsItsSummary
	|aSummary anAccount|
	anAccount _ ReceptiveAccount new.
	
	aSummary _ AccountSummary new.
	self assert: ((aSummary for: anAccount) = 'Deposito por 0. Extracción por 0. Salida por transferencia de 0. Entrada por transferencia de 0. Balance 0.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:32:32'!
testGivenAnEmptyAccountThenTheTransferNetReportsItsTransferNetValue
	|aTransferNetReporter anAccount |
	
	anAccount _ ReceptiveAccount new.
	
	aTransferNetReporter _ TransferNet new.
	self assert: ((aTransferNetReporter for: anAccount) = 'Neto de transferencias 0.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:31:08'!
testGivenAnEmptyPortfolioThenTheAccountSummaryReportsItsSummary
	|aSummary aPortfolio|
	aPortfolio _ Portfolio new.
	
	aSummary _ AccountSummary new.
	self assert: ((aSummary for: aPortfolio) = 'Deposito por 0. Extracción por 0. Salida por transferencia de 0. Entrada por transferencia de 0. Balance 0.').! !

!ReportsTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:32:01'!
testGivenAnEmptyPortfolioThenTheTransferNetReportsItsTransferNetValue
	|aTransferNetReporter aPortfolio |
	
	aPortfolio _ Portfolio new.
	
	aTransferNetReporter _ TransferNet new.
	self assert: ((aTransferNetReporter for: aPortfolio) = 'Neto de transferencias 0.').! !


!classDefinition: #TransferTest category: #'31-Portfolio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:17:52'!
testCantCreateATransferenceWithNegativeValues
	self 
		should: [ Transfer with: (-1)]
		raise: Error
		withExceptionDo: [ :anError | self assert: [(anError messageText) = 'La transacción debe ser por un valor positivo']]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:42:24'!
testCantCreateATransferenceWithNegativeValuesFromAnAccountToAnother
	| unaCuenta otraCuenta unDeposito |
	
	unaCuenta _ ReceptiveAccount new.
	unDeposito _ Deposit for: 100.
	unaCuenta register: unDeposito.
	
	otraCuenta _ ReceptiveAccount new.
	
	self 
		should: [ Transfer with: (-1) from: unaCuenta to: otraCuenta]
		raise: Error
		withExceptionDo: [ :anError | self assert: [(anError messageText) = 'La transacción debe ser por un valor positivo']]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:27:12'!
testCantCreateCircularTranferences
	| unaCuenta otraCuenta unDeposito |
	
	unDeposito _ Deposit for: 100.
	unaCuenta _ ReceptiveAccount new.
	unaCuenta register: unDeposito.
	
	otraCuenta _ ReceptiveAccount new.
	
	self 
		should: [Transfer with: 80 from: unaCuenta to: unaCuenta]
		raise: Error
		withExceptionDo: [ :anError | self assert: [(anError messageText) = 'No se pueden crear transferencias circulares']]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:41:57'!
testCantTransferAValueFromAnAccountThatHasLessCredit
	| unaCuenta otraCuenta |
	
	unaCuenta _ ReceptiveAccount new.
	otraCuenta _ ReceptiveAccount new.
	
	self 
		should: [Transfer with: 80 from: unaCuenta to: otraCuenta]
		raise: Error
		withExceptionDo: [ :anError | self assert: [(anError messageText) = 'La cuenta a debitar no tiene el credito suficiente']]
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:58:51'!
testCreateATransferenceFromAnAccountToAnotherAfectsBalancesAcounts
	| unaCuenta otraCuenta unDeposito unaTrasnferencia actualBalanceOtraCuenta actualBalanceUnaCuenta |
	
	unDeposito _ Deposit for: 100.
	unaCuenta _ ReceptiveAccount new.
	unaCuenta register: unDeposito.
	actualBalanceUnaCuenta _ unaCuenta balance.
		
	otraCuenta _ ReceptiveAccount new.
	actualBalanceOtraCuenta _ otraCuenta balance.	
	
	unaTrasnferencia _ Transfer with: 80 from: unaCuenta to: otraCuenta.
	
	self assert: ((unaCuenta balance isNotEqualTo: actualBalanceUnaCuenta) and: (otraCuenta balance isNotEqualTo: actualBalanceOtraCuenta)).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:02'!
testTheDepositLegAndTheWithdrawLegOfATransferenceKnowTheirTrancefence
	| unaCuenta otraCuenta unDeposito unaTrasnferencia |
	
	unDeposito _ Deposit for: 100.
	unaCuenta _ ReceptiveAccount new.
	unaCuenta register: unDeposito.
		
	otraCuenta _ ReceptiveAccount new.
	
	unaTrasnferencia _ Transfer with: 80 from: unaCuenta to: otraCuenta.
	
	self assert: ((unaTrasnferencia withdrawLeg transfer = unaTrasnferencia ) and: (unaTrasnferencia depositLeg transfer = unaTrasnferencia )).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:28:14'!
testTheTranferenceKnowItsValue

	| unaTransferencia |
	unaTransferencia _ Transfer with: 100.
	self assert: (unaTransferencia value = 100).! !


!classDefinition: #Account category: #'31-Portfolio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'31-Portfolio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'31-Portfolio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'31-Portfolio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'31-Portfolio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'31-Portfolio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'31-Portfolio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'31-Portfolio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'31-Portfolio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:51:50'!
affectBalance

	^self subclassResponsibility ! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:49:30'!
initializeWith: aTransfer

	transfer _ aTransfer.! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:49:00'!
transfer

	^transfer! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:47:36'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'31-Portfolio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'n 5/31/2019 17:06:09'!
with: aTransfer
	^ self new initializeWith: aTransfer .! !


!classDefinition: #DepostiLeg category: #'31-Portfolio'!
TransferLeg subclass: #DepostiLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!DepostiLeg methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:48:29'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #WithdrawLeg category: #'31-Portfolio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!WithdrawLeg methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:17:30'!
affectBalance: aBalance

	^aBalance - (self value).! !


!classDefinition: #Withdraw category: #'31-Portfolio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'31-Portfolio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: #'31-Portfolio'!
Object subclass: #Reports
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Reports methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:44:03'!
for: anAccount
	^self subclassResponsibility ! !

!Reports methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:17:04'!
reportSummaryByClass: aClass for: anAccount 
	|reportValue|
	reportValue _ 0.
	(anAccount transactions) do: [:aTransaction|  (aTransaction isKindOf: aClass) ifTrue: [reportValue _ aTransaction value + reportValue.]].
	^reportValue.! !


!classDefinition: #AccountSummary category: #'31-Portfolio'!
Reports subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:35:34'!
for: anAccount 
	|depositReport withdrawReport depositByTransferenceReport withdrawByTransferenceReport accountBalance |
	
	depositReport _ self reportSummaryByClass: Deposit for: anAccount.
	withdrawReport _ self reportSummaryByClass: Withdraw for: anAccount.
	depositByTransferenceReport _ self reportSummaryByClass: DepostiLeg for: anAccount.
	withdrawByTransferenceReport _ self reportSummaryByClass: WithdrawLeg for: anAccount.
	accountBalance _ depositReport-withdrawReport+depositByTransferenceReport-withdrawByTransferenceReport.
	
	^('Deposito por ',depositReport printString, '. Extracción por ',withdrawReport printString, '. Salida por transferencia de ',withdrawByTransferenceReport printString, '. Entrada por transferencia de ',depositByTransferenceReport printString, '. Balance ',accountBalance printString,'.'). ! !


!classDefinition: #TransferNet category: #'31-Portfolio'!
Reports subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 15:22:05'!
for: anAccount
	| depositByTransferenceReport withdrawByTransferenceReport |
	depositByTransferenceReport _ self reportSummaryByClass: DepostiLeg for: anAccount.
	withdrawByTransferenceReport _ self reportSummaryByClass: WithdrawLeg for: anAccount.
	^('Neto de transferencias ', (depositByTransferenceReport - withdrawByTransferenceReport) printString, '.' )
! !


!classDefinition: #Transfer category: #'31-Portfolio'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:02'!
depositLeg
 	^depositLeg ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:19'!
initializeWith: aValue
	(aValue < 1) ifTrue: [self error: 'La transacción debe ser por un valor positivo'].
 	depositLeg _ DepostiLeg with: self.
	withdrawLeg _ WithdrawLeg with: self.
	value _ aValue.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:31'!
initializeWith: aValue from: anAccount to: anotherAccount
	self initializeWith: aValue.
	self registerTransactionFrom: anAccount to: anotherAccount.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 13:40:29'!
registerTransactionFrom: anAccount to: anotherAccount
 	(anAccount isNotEqualTo: anotherAccount) ifFalse: [self error:'No se pueden crear transferencias circulares'].
	(anAccount balance < value) ifTrue: [self error: 'La cuenta a debitar no tiene el credito suficiente'].
	
	anAccount register: withdrawLeg.
	anotherAccount register: depositLeg.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'ML 5/30/2019 19:02:23'!
value
 	^value! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:01:44'!
withdrawLeg
 	^withdrawLeg ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'31-Portfolio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:20'!
with: aValue
	^self new initializeWith: aValue! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'n 6/1/2019 14:02:31'!
with: aValue from: anAccount to: anotherAccount
	^self new initializeWith: aValue from: anAccount to: anotherAccount.! !
