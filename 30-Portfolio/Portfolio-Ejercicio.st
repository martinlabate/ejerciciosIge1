!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:28:42'!
test01PortfolioVacioDeberiaTenerBalanceCero
	|unPortfolio|
	
	unPortfolio := Portfolio new initialize.	
	self assert: (unPortfolio balance = 0).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:28:37'!
test02UnPortfolioConUnaCuentaDebeTenerComoBalanceLaSumaDelBalanceDeSusEntidades
	|unaCuenta unaTransaccion unPortfolio|
	
	unaTransaccion := Deposit new initializeFor: 100.
	unaCuenta := ReceptiveAccount new initialize .
	unaCuenta register: unaTransaccion.
	
	unPortfolio := Portfolio new initialize.
	unPortfolio agregar: unaCuenta.
	
	self assert: (unPortfolio balance = 100).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:59:07'!
test03UnPortfolioConCuentasYPortfoliosDebeTenerComoBalanceLaSumaDelBalanceDeSusEntidades
	|unaCuenta unaTransaccion unaTransaccion2 unaTransaccion3 unPortfolio otroPortfolio otraCuenta otraCuenta2|
	
	unaTransaccion := Deposit for: 100.
	unaTransaccion2 := Deposit for: 200.
	unaTransaccion3 := Deposit for: 300.
	unaCuenta := ReceptiveAccount new .
	unaCuenta register: unaTransaccion.
	
	otraCuenta _ ReceptiveAccount new.
	otraCuenta2 _ ReceptiveAccount new.
	otraCuenta register: unaTransaccion.
	otraCuenta register: unaTransaccion2.
	otraCuenta2 register: unaTransaccion3.
	otraCuenta2 register: unaTransaccion.
	
	unPortfolio := Portfolio new.
	unPortfolio agregar: unaCuenta.
	otroPortfolio _ Portfolio new.
	otroPortfolio agregar: otraCuenta.
	otroPortfolio agregar: otraCuenta2.
	unPortfolio agregar: otroPortfolio.
	
	self assert: (unPortfolio balance = 800).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:21:25'!
test04NoSePermiteAgregarUnaEntidadQueComparteCuentas
	|cuentaNro1 portfolioNro1 portfolioNro2 cuentaNro2|
	
	cuentaNro1 := ReceptiveAccount new .	
	cuentaNro2 _ ReceptiveAccount new.
	
	portfolioNro1 := Portfolio new.
	portfolioNro1 agregar: cuentaNro1.
	portfolioNro2 _ Portfolio new.
	portfolioNro2 agregar: cuentaNro1.
	portfolioNro2 agregar: cuentaNro2.
	self should: [portfolioNro1 agregar: portfolioNro2.] raise: Error withExceptionDo: [:error | self assert: [error messageText = (EntidadBancaria accountsRepetedMessage)]].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:23:18'!
test05NoSePuedeAgregarUnaCuentaAPortfolioHijoSiPerteneceAAlgunPadre
	|cuentaNro1 portfolioPadreNro1 portfolioHijo cuentaNro2 cuentaNro3 portfolioPadreNro2 cuentaNro4 |
	
	cuentaNro1 := ReceptiveAccount new .
	cuentaNro2 _ ReceptiveAccount new.
	cuentaNro3 _ ReceptiveAccount new.
	cuentaNro4 _ ReceptiveAccount new.
	
	portfolioPadreNro1 := Portfolio new.
	portfolioPadreNro1 agregar: cuentaNro1.

	portfolioHijo _ Portfolio new.
	portfolioHijo agregar: cuentaNro2 .
	portfolioHijo agregar: cuentaNro3.

	portfolioPadreNro2 _ Portfolio new.
	portfolioPadreNro2 agregar: cuentaNro4.
	portfolioPadreNro2 agregar: portfolioHijo.
	
	portfolioPadreNro1 agregar: portfolioHijo. 
	
	self should: [portfolioHijo agregar: cuentaNro4.] raise: Error withExceptionDo: [:error | self assert: [error messageText = (EntidadBancaria accountsRepetedMessage)]].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:21:17'!
test06PortfolioKnowsItsTransacctions
	|cuentaNro1 portfolioNro1 transaccionNro1 transaccionNro2 transaccionNro3 transacciones|
	
	transaccionNro1 _ Deposit for: 100.
	transaccionNro2 _ Withdraw for: -10.
	transaccionNro3 _ Deposit for: 20.

	transacciones _ OrderedCollection new.
	transacciones add: transaccionNro1.
	transacciones add: transaccionNro2.
	transacciones add: transaccionNro3.

	cuentaNro1 := ReceptiveAccount new .
	cuentaNro1 register: transaccionNro1.
	cuentaNro1 register: transaccionNro2.
	cuentaNro1 register: transaccionNro3.
	
	portfolioNro1 := Portfolio new.
	portfolioNro1 agregar: cuentaNro1.
	
	self assert: (transacciones = portfolioNro1 transactions).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:28:10'!
test07EmptyPortfolioShouldHaveNoTransacctions
	|portfolioNro1|

	portfolioNro1 := Portfolio new.
	
	self assert: (portfolioNro1 transactions isEmpty).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:31:29'!
test08PortfolioKnowsIfATransacctionHasBeenRegistered
	|cuentaNro1 portfolioNro1 transaccionNro1 transaccionNro2 transaccionNro3 transacciones|
	
	transaccionNro1 _ Deposit for: 100.
	transaccionNro2 _ Withdraw for: -10.
	transaccionNro3 _ Deposit for: 20.

	cuentaNro1 := ReceptiveAccount new .
	cuentaNro1 register: transaccionNro1.
	cuentaNro1 register: transaccionNro2.
	cuentaNro1 register: transaccionNro3.
	
	portfolioNro1 := Portfolio new.
	portfolioNro1 agregar: cuentaNro1.
	
	self assert: (portfolioNro1 hasRegistered: transaccionNro1).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:32:12'!
test09PortfolioKnowsIfATransacctionHasNotBeenRegistered
	|cuentaNro1 portfolioNro1 transaccionNro1 transaccionNro2 transaccionNro3 transacciones|
	
	transaccionNro1 _ Deposit for: 100.
	transaccionNro2 _ Withdraw for: -10.
	transaccionNro3 _ Deposit for: 20.

	cuentaNro1 := ReceptiveAccount new .
	cuentaNro1 register: transaccionNro2.
	cuentaNro1 register: transaccionNro3.
	
	portfolioNro1 := Portfolio new.
	portfolioNro1 agregar: cuentaNro1.
	
	self deny: (portfolioNro1 hasRegistered: transaccionNro1).! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balanceChange' stamp: 'ML 5/23/2019 20:49:17'!
affectBalance: currentBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ML 5/23/2019 20:32:10'!
balanceValue

	^ self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balanceChange' stamp: 'ML 5/23/2019 20:46:35'!
affectBalance: currentBalance
	^currentBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'ML 5/23/2019 20:20:45'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ML 5/23/2019 20:32:20'!
balanceValue

	^ self value * -1! !

!Withdraw methodsFor: 'value' stamp: 'ML 5/23/2019 20:21:03'!
value

	^ value! !


!Withdraw methodsFor: 'balanceChange' stamp: 'ML 5/23/2019 20:47:18'!
affectBalance: currentBalance 
	^currentBalance - value .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #EntidadBancaria category: #'Portfolio-Ejercicio'!
Object subclass: #EntidadBancaria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!EntidadBancaria methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:35:02'!
addPerent: aPortfolio! !

!EntidadBancaria methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:18:42'!
balance
	self subclassResponsibility ! !

!EntidadBancaria methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:18:52'!
cuentas
		self subclassResponsibility ! !

!EntidadBancaria methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:19:55'!
hasRegistered: unaTransaccion
	self subclassResponsibility ! !

!EntidadBancaria methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:19:16'!
transactions
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EntidadBancaria class' category: #'Portfolio-Ejercicio'!
EntidadBancaria class
	instanceVariableNames: ''!

!EntidadBancaria class methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:22:12'!
accountsRepetedMessage
	^'Este portfolio ya contiene una o más cuentas de las que se quieren agregar'! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
EntidadBancaria subclass: #Portfolio
	instanceVariableNames: 'entidadesBancarias padres'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:35:02'!
addPerent: aPortfolio
	padres add: aPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:41:03'!
agregar: unaEntidad
	self checkearRepetidos: unaEntidad .
	unaEntidad addPerent: self.
	entidadesBancarias add: unaEntidad.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:01:07'!
balance

	^entidadesBancarias 
		inject: 0
		into: [ :balance :unaEntidad | unaEntidad balance + balance ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 19:23:32'!
checkearRepetidos: unaEntidad
	padres 
		ifEmpty: [ 
			|cuetnas|
			cuetnas _ unaEntidad cuentas.
			(cuetnas anySatisfy: [: unaCuenta | self cuentas includes: unaCuenta ]) ifTrue: [self error: self class accountsRepetedMessage].] 
		ifNotEmpty: [padres do: [:unPadre | unPadre checkearRepetidos: unaEntidad.] ].
	! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/23/2019 21:54:53'!
cuentas
	|cuentas|
	cuentas _ OrderedCollection new.
	entidadesBancarias do:[:unaEntidad | cuentas addAll:(unaEntidad cuentas)].
	^cuentas.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 17:55:13'!
hasRegistered: aTtransaction
	
	^ entidadesBancarias anySatisfy: [:entidad | entidad hasRegistered: aTtransaction ]

! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 18:36:40'!
initialize
	entidadesBancarias := OrderedCollection new.
	padres _ OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'ML 5/24/2019 17:56:29'!
transactions 

	|transacciones|
	transacciones _ OrderedCollection new.
	entidadesBancarias do:[:unaEntidad | transacciones addAll:(unaEntidad transactions)].
	^transacciones.! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
EntidadBancaria subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ML 5/23/2019 20:45:23'!
balance

	^transactions 
		inject: 0
		into: [ :balance :aTransaction | aTransaction affectBalance: balance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'ML 5/23/2019 21:32:37'!
cuentas

	|listaDeCuentas|
	listaDeCuentas _ OrderedCollection new.
	listaDeCuentas add: self.
	^listaDeCuentas .
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !
