!classDefinition: #BooleanosTest category: #Booleanos!
DenotativeObject subclass: #BooleanosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanosTest class' category: #Booleanos!
BooleanosTest class
	instanceVariableNames: ''!

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:39:09'!
testFalsoOUnBooleanoIgualAUnBooleano
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero .
	Assert that: (Falso o: Falso) isEqualTo: Falso.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:17:37'!
testFalsoSiFalsoEvaluaElCousure
	
	| evaluacionDelBloque |
	
	evaluacionDelBloque _ #BloqueNoEvaluado.
	
	Falso siFalso: [evaluacionDelBloque _ #BloqueSiEvaluado ].
	
	Assert that: evaluacionDelBloque  isEqualTo: #BloqueSiEvaluado.
	! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:15:03'!
testFalsoSiVerdaderoNoEvaluaElCousure
	
	| evaluacionDelBloque |
	
	evaluacionDelBloque _ #BloqueNoEvaluado.
	
	Falso siVerdadero: [evaluacionDelBloque _ #BloqueSiEvaluado ].
	
	Assert that: evaluacionDelBloque  isEqualTo: #BloqueNoEvaluado.
	! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:35:30'!
testFalsoYUnBooleanoIgualAFalso
"testeamos funcionalidad"
	Assert that: (Falso y: Verdadero) isEqualTo: Falso .
	Assert that: (Falso y: Falso) isEqualTo: Falso .! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:31:44'!
testNoFalsoEsVerdadero
	Assert that: (Falso no) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:32:06'!
testNoVerdaderoEsFalso
	Assert that: (Verdadero no) isEqualTo: Falso .! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:35:38'!
testVerdaderoOUnBooleanoIgualAVerdadero
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero .
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:18:36'!
testVerdaderoSiFalsoEvaluaElCousure
	
	| evaluacionDelBloque |
	
	evaluacionDelBloque _ #BloqueNoEvaluado.
	
	Verdadero siFalso: [evaluacionDelBloque _ #BloqueSiEvaluado ].
	
	Assert that: evaluacionDelBloque  isEqualTo: #BloqueNoEvaluado.
	! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:09:04'!
testVerdaderoSiVerdaderoEvaluaElCousure
	
	| evaluacionDelBloque |
	
	evaluacionDelBloque _ #BloqueNoEvaluado.
	
	Verdadero siVerdadero: [evaluacionDelBloque _ #BloqueSiEvaluado ].
	
	Assert that: evaluacionDelBloque  isEqualTo: #BloqueSiEvaluado.
	! !

!BooleanosTest class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:39:29'!
testVerdaderoYUnBooleanoIgualAUnBooleano
"testeamos funcionalidad"
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero .
	Assert that: (Verdadero y: Falso) isEqualTo: Falso .! !


!classDefinition: #Falso category: #Booleanos!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Booleanos!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:18:11'!
no
	^Verdadero ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:20:49'!
o: otroBooleano
	^otroBooleano ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:16:11'!
siFalso: unClosure
	unClosure value.! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:13:30'!
siVerdadero: aBlockClosure ! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:56:03'!
y: unBooleano 
	^self .! !


!classDefinition: #Verdadero category: #Booleanos!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Booleanos'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Booleanos!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:18:37'!
no
	^Falso ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:21:03'!
o: otroBooleano
	^self! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:19:04'!
siFalso: unClosure ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:10:08'!
siVerdadero: unClosure 
	unClosure value. ! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:19:21'!
y: otroBooleano
	^ otroBooleano! !
