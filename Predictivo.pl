/*
PDEP-KEY
Sabemos lo que pensás
Se nos ha encargado la tarea de codificar un nuevo motor de predicciones para usuarios que envían mensajes de texto. El objetivo es que el usuario tenga que escribir la menor cantidad de palabras posibles; para lograrlo, el motor generará predicciones precisas sobre posibles próximas palabras según el texto que se esté escribiendo en el momento.
Luego de mucho debate, se decidió implementarlo en Prolog.

% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'qué', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'después', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','qué', 'onda', 'el','parcial', '?'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'después').
abreviatura('q', 'que').
abreviatura('q', 'qué').
abreviatura('bn', 'bien').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).

Se pide desarrollar los siguientes predicados de modo que sean totalmente inversibles (a menos que se explicite lo contrario):
recibioMensaje/2: relaciona una persona con un mensaje si recibió dicho mensaje del usuario ya sea de forma individual o grupal. Deberían ser posibles respuestas nico, lucas, maiu y mama, y no [nico, lucas, maiu].

demasidoFormal/1: se consideran demasiado formales los mensajes con más de 20 palabras que incluyen signos y los que comienzan con ‘¿’. A menos que tengan abreviaturas, en cuyo caso la formalidad se pierde.

esAceptable/2: saber si una palabra dada es aceptable para una persona. O sea, si pasa todos los filtros configurados para dicho usuario:
Actualmente existen 3 tipos de filtros, con posibilidad de agregarse más en un futuro cercano:
	masDe(N): La palabra es aceptada si su tasa de uso con esa persona es mayor a N. La tasa de uso de una palabra se calcula como la cantidad de apariciones de esa palabra en mensajes enviados a esa persona dividido por la cantidad de apariciones de esa palabra en mensajes enviados a cualquier persona o grupo.
	ignorar(ListaDePalabras): Las palabras de la lista no son aceptadas.
	soloFormal: Solamente es aceptable si la palabra se encuentra en algún mensaje demasiado  formal.
	No se espera que sea inversible.

dicenLoMismo/2: dos mensajes dicen lo mismo cuando todas las palabras de ambos se encuentran en el mismo orden y son equivalentes (las abreviaturas son equivalentes a sus correspondientes palabras). Por ejemplo el último mensaje enviado a lucas dice lo mismo que el último enviado a nico.

fraseCelebre/1: un mensaje es frase célebre cuando se usó con todos los contactos del usuario. Los contactos son simplemente las personas que recibieron algún mensaje del usuario. Debería ser cierto incluso si no fue escrito siempre de la misma forma, lo importante es que diga lo mismo. Para nuestra base de conocimientos fraseCelebre/1 sería cierto para cualquiera de las versiones usadas de “todo bien después hablamos”, pero no para el de “¿y qué onda el parcial?”.

prediccion/3: relaciona un mensaje a ser enviado, quién lo recibirá (persona o grupo) y una predicción. Una predicción es una posible palabra para continuar el mensaje.
Toda palabra que haya sido escrita en algún mensaje después de la última palabra del texto a enviar (o alguna equivalencia de la misma) es considerada una predicción potencial.
Para que la potencial predicción sea una respuesta, deberá ser aceptable para el/los receptor/es (si es un grupo debería ser aceptable para todos los que lo conforman).
Sin embargo, si el mensaje a enviar es alguna frase célebre, no se debe proveer una predicción porque se considera que el mensaje ya está completo.
Nota: Sólo se espera que sea inversible respecto a la predicción. El mensaje y el receptor son datos provistos por el usuario.

*/

%Base de conocimiento
% mensaje(ListaDePalabras, Receptor).
%	Los receptores posibles son:
%	Persona: un simple átomo con el nombre de la persona; ó
%	Grupo: una lista de al menos 2 nombres de personas que pertenecen al grupo.
mensaje(['hola', ',', 'qué', 'onda', '?'], nico).
mensaje(['todo', 'bien', 'dsp', 'hablamos'], nico).
mensaje(['q', 'parcial', 'vamos', 'a', 'tomar', '?'], [nico, lucas, maiu]).
mensaje(['todo', 'bn', 'dsp', 'hablamos'], [nico, lucas, maiu]).
mensaje(['todo', 'bien', 'después', 'hablamos'], mama).
mensaje(['¿','y','q', 'onda', 'el','parcial', '?'], nico).
mensaje(['¿','y','qué', 'onda', 'el','parcial', '?'], lucas).

% abreviatura(Abreviatura, PalabraCompleta) relaciona una abreviatura con su significado.
abreviatura('dsp', 'después').
abreviatura('q', 'que').
abreviatura('q', 'qué').
abreviatura('bn', 'bien').

% signo(UnaPalabra) indica si una palabra es un signo.
signo('¿').    signo('?').   signo('.').   signo(','). 

% filtro(Contacto, Filtro) define un criterio a aplicar para las predicciones para un contacto
filtro(nico, masDe(0.5)).
filtro(nico, ignorar(['interestelar'])).
filtro(lucas, masDe(0.7)).
filtro(lucas, soloFormal).
filtro(mama, ignorar(['dsp','paja'])).

%Punto 1:
recibioMensaje(Mensaje, Receptor):-
    mensaje(Mensaje,PosibleRecepto),
    receptor(PosibleRecepto, Receptor).

receptor(Receptor,Receptor):-%Esto me genera dudas pq, no sé si es la mejor forma para diferenciar los casos en los que no receptor no es una lista.
    not(member(_,Receptor)).
receptor(Receptores, Receptor):-
    member(Receptor, Receptores).

%Punto 2:
demasiadoFormal(Mensaje):-
    noTieneAbreviatura(Mensaje),
    tieneMasDe20CaracteresOEmpiezaConPregunta(Mensaje).

tieneAbreviatura(Mensaje):-
    abreviatura(Abreviatura,_),
    member(Abreviatura, Mensaje).
noTieneAbreviatura(Mensaje):-
    mensaje(Mensaje,_),
    not(tieneAbreviatura(Mensaje)).

tieneMasDe20CaracteresOEmpiezaConPregunta(Mensaje):-
    tieneMasDeNCaracteres(Mensaje,20).
tieneMasDe20CaracteresOEmpiezaConPregunta(Mensaje):-
    nth0(0,Mensaje,'¿').

tieneMasDeNCaracteres(Mensaje, Minimo):-
    length(Mensaje, Cantidad),
    Cantidad > Minimo.

%Punto 3:
esAceptable(Palabra,Persona):-
    palabra(Palabra),
    recibioMensaje(_,Persona),
    forall(filtro(Persona,Filtro), superaElFiltro(Palabra, Filtro, Persona)).

palabra(Palabra):-
    mensajeQueTienePalabra(_,Palabra).

superaElFiltro(Palabra, ignorar(Palabras), _):-
    not(member(Palabra,Palabras)).
superaElFiltro(Palabra,soloFormal,_):-
    demasiadoFormal(Mensaje),
    member(Palabra, Mensaje).
superaElFiltro(Palabra, masDe(Cantidad), Persona):-
    tasaDeUso(Palabra, Persona, TasaDeUso),
    TasaDeUso > Cantidad.

tasaDeUso(Palabra, Persona, TasaDeUso):-
    cantidadDeVecesQueApareceLaPalabra(Palabra,Persona,Cantidad),
    cantidadDeVecesQueApareceLaPalabra(Palabra,_, CantidadGeneral),
    TasaDeUso is Cantidad / CantidadGeneral.

cantidadDeVecesQueApareceLaPalabra(Palabra, Persona, Cantidad):-
    findall(Persona, recibioPalabra(Palabra, Persona), Personas),
    length(Personas, Cantidad).

recibioPalabra(Palabra, Persona):-
    recibioMensaje(Mensaje, Persona),
    member(Palabra, Mensaje).
    

%Punto 4:
dicenLoMismo(Mensaje, OtroMensaje):-
    mensaje(Mensaje,_),
    mensaje(OtroMensaje,_),
    forall(member(Palabra, Mensaje), hayEquivalenteEnSuPosicion(Palabra, Mensaje, OtroMensaje)).

hayEquivalenteEnSuPosicion(Palabra, MensajeDeReferencia, Mensaje):-
    nth0(Posicion,MensajeDeReferencia,Palabra),
    nth0(Posicion,Mensaje, OtraPalabra),
    esEquivalente(Palabra, OtraPalabra).

esEquivalente(Palabra,Palabra).
esEquivalente(UnaPalabra, OtraPalabra):-
    algunaEsAbreviatura(UnaPalabra, OtraPalabra).

algunaEsAbreviatura(Palabra,OtraPalabra):-
    abreviatura(Palabra, OtraPalabra).
algunaEsAbreviatura(Palabra, OtraPalabra):-
    abreviatura(OtraPalabra,Palabra).

%Version 2:
dicenLoMismoV2(Mensaje,OtroMensaje):-
    mensaje(Mensaje,_),
    mensaje(OtroMensaje,_),
    forall(palabrasEnMismaPosicion(Mensaje,OtroMensaje, Palabra, OtraPalabra), esEquivalente(Palabra, OtraPalabra)).

palabrasEnMismaPosicion(Mensaje, OtroMensaje, Palabra, OtraPalabra):-
    nth0(Posicion,Mensaje,Palabra),
    nth0(Posicion,OtroMensaje, OtraPalabra).

%Punto 5
fraseCelebre(FraseCelebre):-
    mensaje(FraseCelebre,_),
    forall(contacto(Receptor), recibioElMismoMensaje(FraseCelebre,Receptor)).

contacto(Receptor):-
    recibioMensaje(_,Receptor).

recibioElMismoMensaje(FraseCelebre, Receptor):-
    mensajeEquivalente(FraseCelebre, MensajeEquivalente),
    recibioMensaje(MensajeEquivalente, Receptor).

mensajeEquivalente(Mensaje, Mensaje).
mensajeEquivalente(Mensaje, MensajeEquivalente):-
    dicenLoMismoV2(Mensaje, MensajeEquivalente).

%Punto 6:
prediccion(Mensaje, Receptor, Prediccion):-
    not(fraseCelebre(Mensaje)),
    prediccionPotencial(Mensaje, Prediccion),
    esAceptableParaTodos(Receptor, Prediccion).

prediccionPotencial(Mensaje, Prediccion):-
    ultimaPalabra(Mensaje, UltimaPalabra),
    palabraQueSeUsoDespuesDe(Prediccion, UltimaPalabra).

ultimaPalabra(Mensaje, UltimaPalabra):-
    length(Mensaje, CantidadPalabras),
    nth1(CantidadPalabras, Mensaje, UltimaPalabra).

palabraQueSeUsoDespuesDe(PalabraSiguiente, PalabraDeReferencia):-
    mensajeQueTienePalabra(Mensaje, PalabraDeReferencia),
    nth0(PosicionPalabraRef,Mensaje, PalabraDeReferencia),
    nth0(PosicionSiguiente, Mensaje, PalabraSiguiente),
    PosicionSiguiente is PosicionPalabraRef + 1.

mensajeQueTienePalabra(Mensaje, Palabra):-
    mensaje(Mensaje,_),
    member(Palabra, Mensaje).

esAceptableParaTodos(Receptor,Palabra):-
    esAceptable(Palabra, Receptor).
esAceptableParaTodos(Receptores, Palabra):-
    member(_,Receptores),
    forall(member(Receptor, Receptores), esAceptable(Palabra,Receptor)).