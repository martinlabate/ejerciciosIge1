"estos son los comandos que usamos para crear el servidor y la ventana. 
como le pusimos los objetos por default, el user es validUser y su password validUserPassword.
asì el item valido es validBook.
si se ingresan valores invàlidos se lanza un error explicando el motivo en el messageError.
los valores de tarjeta, por ejemplo que el largo de la tarjeta sea el correspondiente, 
no fueron testeados en la solucion de la catedra, por lo que el sistema permite el ingreso de valores que consideramos invàlidos.

nos hubiera gustado poder hacer que se cierren las ventanas una vez que se realizan las operaciones de checkout y create cart,
para que en la realidad el sistema no permita tocar el boton de checkout 2 veces. no supimos como hacerlo.
saludos."

server := (TusLibrosServer new initializeAuthenticatingWith: (TusLibrosSystemFacadeTest new validUsersAndPasswords) acceptingItemsOf: (StoreTestObjectsFactory new defaultCatalog) debitingThrought: (TusLibrosSystemFacadeTest new) measuringTimeWith: (ManualClock now: (StoreTestObjectsFactory new today))).

server startListening.

TusLibrosClientWindow open.
