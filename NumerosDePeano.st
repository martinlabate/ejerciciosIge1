!classDefinition: #I category: #NumerosDePeano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NumerosDePeano!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:46:56'!
* unNumeroDePeano
	^ unNumeroDePeano. ! !

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:46:29'!
+ unNumeroDePeano
	^ unNumeroDePeano next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 20:48:47'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^ self].
	self error: ['no se puede dividir por un numero distinto de uno'].! !

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:35:20'!
leRestoA: unNumeroDePeano
	^ unNumeroDePeano prev! !

!I class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:44:17'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !


!classDefinition: #II category: #NumerosDePeano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NumerosDePeano!
II class
	instanceVariableNames: 'next prev'!

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:53:09'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:53:20'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:52:47'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:05'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	prev := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:53:00'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:51:50'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:52:26'!
prev
	^ prev.! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:54:09'!
prev: previus
	prev _ previus ! !

!II class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 21:54:39'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #III category: #NumerosDePeano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #NumerosDePeano!
III class
	instanceVariableNames: 'next prev'!

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	prev := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
prev
	^ prev.! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
prev: previus
	prev _ previus ! !

!III class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #IIII category: #NumerosDePeano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #NumerosDePeano!
IIII class
	instanceVariableNames: 'next prev'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	prev := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:11'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:12'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:12'!
prev
	^ prev.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:12'!
prev: previus
	prev _ previus ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:12'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #IIIII category: #NumerosDePeano!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #NumerosDePeano!
IIIII class
	instanceVariableNames: 'next prev'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	prev := IIII.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev
	^ prev.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev: previus
	prev _ previus ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #IIIIII category: #NumerosDePeano!
DenotativeObject subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #NumerosDePeano!
IIIIII class
	instanceVariableNames: 'next prev'!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	prev := IIIII.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev
	^ prev.! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev: previus
	prev _ previus ! !

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #IIIIIII category: #NumerosDePeano!
DenotativeObject subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: #NumerosDePeano!
IIIIIII class
	instanceVariableNames: 'next prev'!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	prev := IIIIII.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev
	^ prev.! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev: previus
	prev _ previus ! !

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !


!classDefinition: #IIIIIIII category: #NumerosDePeano!
DenotativeObject subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NumerosDePeano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: #NumerosDePeano!
IIIIIIII class
	instanceVariableNames: 'next prev'!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
* unNumeroDePeano
	^ self + ((unNumeroDePeano prev) * self). ! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
+ unNumeroDePeano
	^ self prev + unNumeroDePeano next.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
- unNumeroDePeano
	^ unNumeroDePeano leRestoA: self! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
/ unNumeroDePeano
	self = unNumeroDePeano ifTrue: [^I].
	^ (self - unNumeroDePeano / unNumeroDePeano) +I.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:43'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	prev := IIIIIII.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
leRestoA: unNumeroDePeano
	^ self prev leRestoA: unNumeroDePeano prev! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
next
	next ifNil:
		[
		next _ self cloneNamed: (self name, 'I'). 
		next prev: self.
		].
	^ next ! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev
	^ prev.! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
prev: previus
	prev _ previus ! !

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'ML 3/28/2019 22:00:19'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]
! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!