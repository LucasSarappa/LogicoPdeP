/*
https://docs.google.com/document/d/1VPvQQQJwVH20ziLA-96Hy1mKXHOQZpCJ9SW2rWOL2Zg/edit

Vacaciones

Llegó el momento de armar las valijas y emprender el hermoso viaje... de programar en Lógico! Necesitamos modelar la información que se detalla a continuación.

Punto 1: El destino es así, lo se... (2 puntos)
Sabemos que Dodain se va a Pehuenia, San Martín (de los Andes), Esquel, Sarmiento, Camarones y Playas Doradas. Alf, en cambio, se va a Bariloche, San Martín de los Andes y El Bolsón. Nico se va a Mar del Plata, como siempre. Y Vale se va para Calafate y El Bolsón.

Además Martu se va donde vayan Nico y Alf. 
Juan no sabe si va a ir a Villa Gesell o a Federación
Carlos no se va a tomar vacaciones por ahora

Se pide que defina los predicados correspondientes, y justifique sus decisiones en base a conceptos vistos en la cursada.
Punto 2: Vacaciones copadas (4 puntos)
Incorporamos ahora información sobre las atracciones de cada lugar. Las atracciones se dividen en
un parque nacional, donde sabemos su nombre
un cerro, sabemos su nombre y la altura
un cuerpo de agua (cuerpoAgua, río, laguna, arroyo), sabemos si se puede pescar y la temperatura promedio del agua
una playa: tenemos la diferencia promedio de marea baja y alta
una excursión: sabemos su nombre
Agregue hechos a la base de conocimientos de ejemplo para dejar en claro cómo modelaría las atracciones. Por ejemplo: Esquel tiene como atracciones un parque nacional (Los Alerces) y dos excursiones (Trochita y Trevelin). Villa Pehuenia tiene como atracciones un cerro (Batea Mahuida de 2.000 m) y dos cuerpos de agua (Moquehue, donde se puede pescar y tiene 14 grados de temperatura promedio y Aluminé, donde se puede pescar y tiene 19 grados de temperatura promedio).

Queremos saber qué vacaciones fueron copadas para una persona. Esto ocurre cuando todos los lugares a visitar tienen por lo menos una atracción copada. 
un cerro es copado si tiene más de 2000 metros
un cuerpoAgua es copado si se puede pescar o la temperatura es mayor a 20
una playa es copada si la diferencia de mareas es menor a 5
una excursión que tenga más de 7 letras es copado
cualquier parque nacional es copado
El predicado debe ser inversible. 

Punto 3: Ni se me cruzó por la cabeza (2 puntos)
Cuando dos personas distintas no coinciden en ningún lugar como destino decimos que no se cruzaron. Por ejemplo, Dodain no se cruzó con Nico ni con Vale (sí con Alf en San Martín de los Andes). Vale no se cruzó con Dodain ni con Nico (sí con Alf en El Bolsón). El predicado debe ser completamente inversible.

Punto 4: Vacaciones gasoleras (2 puntos)
Incorporamos el costo de vida de cada destino:
Destino
Costo de vida
Sarmiento
100
Esquel
150
Pehuenia
180
San Martín de los Andes
150
Camarones
135
Playas Doradas
170
Bariloche
140
El Calafate
240
El Bolsón
145
Mar del Plata
140


Queremos saber si unas vacaciones fueron gasoleras para una persona. Esto ocurre si todos los destinos son gasoleros, es decir, tienen un costo de vida menor a 160. Alf, Nico y Martu hicieron vacaciones gasoleras.
El predicado debe ser inversible.


Punto 5: Itinerarios posibles (3 puntos)
Queremos conocer todas las formas de armar el itinerario de un viaje para una persona sin importar el recorrido. Para eso todos los destinos tienen que aparecer en la solución (no pueden quedar destinos sin visitar).

Por ejemplo, para Alf las opciones son
[bariloche, sanMartin, elBolson]
[bariloche, elBolson, sanMartin]
[sanMartin, bariloche, elBolson]
[sanMartin, elBolson, bariloche]
[elBolson, bariloche, sanMartin]
[elBolson, sanMartin, bariloche]

(claramente no es lo mismo ir primero a El Bolsón y después a Bariloche que primero a Bariloche y luego a El Bolsón, pero el itinerario tiene que incluir los 3 destinos a los que quiere ir Alf).

NOTA
12,50 - 13 puntos = 10 | 11,50 - < 12,50 = 9 | 10 - < 11,50 = 8 | 9 - < 10 = 7 | 8 - < 9 = 6 | 7 - < 8 = Revisión | 4 - < 7 = 4 | menos de 4 = 2

*/

% Vacaciones
destino(dodain,pehuenia).
destino(dodain,sanMartinDeLosAndes).
destino(dodain,esquel).
destino(dodain,sarmiento).
destino(dodain,camarones).
destino(dodain,playasDoradas).
destino(alf,bariloche).
destino(alf,sanMartinDeLosAndes).
destino(alf,bolson).
destino(nico,marDelPlata).
destino(vale,calafate).
destino(vale,bolson).

%%%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%%%%%%

destino(martu,Lugar):-destino(nico,Lugar).
destino(martu,Lugar):-destino(alf,Lugar).


%% juan no sabe a que destino va a ir , entonces por concepto de universo cerrado , no se agrega a la base de conocimiento.

%% carlos no se va a tomar vacaciones, por ende, no tiene un destino, entonces  por Concepto de Universo
%%Cerrado , tampoco se agrega a la base de conocimientos.

%%%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%%%%%%

atracciones(esquel,parqueNacional(losAlerces)).
atracciones(esquel,excursion(trochita)).
atracciones(esquel,excursion(trevelin)).
atracciones(pehuenia,cerro(bateaMathuida,2000)).
atracciones(pehuenia,cuerpoDeAgua(moquehue,puedePescar,14)).%%14
atracciones(pehuenia,cuerpoDeAgua(alumine,puedePescar,19)).
atracciones(marDelPlata,playa(3,4)).%% marea mas baja, marea mas alta
atracciones(bariloche,boliche(8)).%% 8 es la cantidad de horas que esta abierto en un dia.




vacacionesCopadas(Persona):-
    destino(Persona,_),%% necesito esto para inversibilidad , si pusiera  destino(Persona,Sitio), entonces ya estoy asignando la persona al 
    %%sitio y siempre el forall va a tomar al mismo Sitio
    forall(destino(Persona,Sitio),esUnDestinoCopado(Sitio)).

esUnDestinoCopado(Sitio):-
    atracciones(Sitio, Atraccion),
    tieneAlmenosUnaAtraccionCopada(Atraccion).

tieneAlmenosUnaAtraccionCopada(cerro(_,Altura)):- Altura > 2000.

tieneAlmenosUnaAtraccionCopada(cuerpoDeAgua(,,Temperatura)):- Temperatura > 20.
tieneAlmenosUnaAtraccionCopada(cuerpoDeAgua(,puedePescar,)).

tieneAlmenosUnaAtraccionCopada(playa(MareaBaja,MareaAlta)):-
    DiferenciaDeMareas is MareaAlta - MareaBaja,
    DiferenciaDeMareas < 5.

tieneAlmenosUnaAtraccionCopada(excursion(Palabra)):-
    length(Palabra, CantidadDeLetras),
    CantidadDeLetras > 7.
tieneAlmenosUnaAtraccionCopada(bariloche(HorasAbierto)):- HorasAbierto > 6.


%% deberia estar el parquenacional como copado , osea
tieneAlmenosUnaAtraccionCopada(parqueNacional(_)). 

%% al ser cualquier Parque Nacional Copado , seria lo mismo que no ponerlo, porque en el predicado , evaluo
%% si tiene al menos una atraccion copada. 

%% es atractivo bariloche si los boliches hablen como minimo 6hs


%%%%%%%%%%% PUNTO 3 %%%%%%%%%%%%%%%

niSeMeCruzoPorLaCabeza(Persona,PersonaQueNoSeCruzo):-
  destino(Persona,_),
  destino(PersonaQueNoSeCruzo,_),
  Persona\=PersonaQueNoSeCruzo,
  forall((destino(Persona, Sitio), destino(PersonaQueNoSeCruzo, Lugar)), Sitio \= Lugar).

%%%%%%%%%%% PUNTO 4 %%%%%%%%%%%%%%%

costo(sarmiento,100).
costo(esquel,150).
costo(pehuenia,180).
costo(sanMartinDeLosAndes,150).
costo(camarones,135).
costo(playasDoradas,170).
costo(bariloche,140).
costo(calafate,240).
costo(bolson,145).
costo(marDelPlata,140).

vacacionesGasoleras(Persona):-
    destino(Persona,_),
    forall((destino(Persona,Lugar),costo(Lugar,LoQueCuesta)),LoQueCuesta<160).

%%%%%%%%%%% PUNTO 5 %%%%%%%%%%%%%%%

itinerarioDeViaje(Persona, LugaresPosibles) :-
    destino(Persona, _),
    findall(Lugar, destino(Persona, Lugar), Lugares),
    combinacionDeLugares(Lugares,LugaresPosibles).
combinacionDeLugares([], []).
combinacionDeLugares(Lugares, [Lugar|LugaresPosibles]) :-
    select(Lugar, Lugares, RestoDeLugares),
combinacionDeLugares(RestoDeLugares, LugaresPosibles).