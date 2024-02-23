% PARCIAL 2021 BOLICHE - PARADIGMAS DE PROGRAMACION 
Enunciado: https://github.com/FranScolari208/ParadigmasDeProgramacion/blob/main/Parciales/Prolog/Parcial%20l%C3%B3gico%20Enunciado.pdf

Resolucion:https://github.com/FranScolari208/ParadigmasDeProgramacion/blob/main/Parciales/Prolog/Parcial.pl

%quedaEn(Boliche, Localidad).
quedaEn(pachuli, generalLasHeras).
quedaEn(why, generalLasHeras).
quedaEn(chaplin, generalLasHeras).
quedaEn(masDe40, sanLuis).
quedaEn(qma, caba).
%base de conocimiento punto 7
quedaEn(trabajamosYNosDivertimos, concordia).
quedaEn(elFinDelMundo, ushuaia).

%entran(Boliche, CapacidadDePersonas).
entran(pachuli, 500).
entran(why, 1000).
entran(chaplin, 700).
entran(masDe40, 1200).
entran(qma, 800).
%base de conocimiento punto 7
entran(trabajamosYNosDivertimos, 500).
entran(elFinDelMundo, 1500).
entran(misterio, 1000000).

%sirveComida(Boliche).
sirveComida(chaplin).
sirveComida(qma).
%base de conocimiento punto 7
sirveComida(trabajamosYNosDivertimos).
sirveComida(misterio).

%tematico(tematica).
%cachengue(listaDeCancionesHabituales).
%electronico(djDeLaCasa, horaQueEmpieza, horaQueTermina).
%esDeTipo(Boliche, Tipo).
esDeTipo(why, cachengue([elYYo, prrrram, biodiesel,buenComportamiento])).
esDeTipo(masDe40, tematico(ochentoso)).
esDeTipo(qma, electronico(djFenich, 2, 5)).
%base de conocimiento punto 7
esDeTipo(trabajamosYNosDivertimos, tematico(oficina)).
esDeTipo(elFinDelMundo, electronico(djLuis, 0, 6)).

% me van a servir para hacer inversibles los nuevos predicados.
boliche(Boliche):-
    quedaEn(Boliche, _).

localidad(Localidad):-
    quedaEn(_, Localidad).

%PUNTO 1: esPiola/1: sabemos que un boliche es piola cuando queda en General Las Heras o cuando es grande, 
%es decir, entran más de 700 personas.En ambos casos es necesario que sirvan comida.
esPiola(Boliche):-
    sirveComida(Boliche),
    esBolichePiola(Boliche).

esBolichePiola(Boliche):-
    entran(Boliche, CantidadPersonas),
    CantidadPersonas > 700.

esBolichePiola(Boliche):-
    quedaEn(Boliche, generalLasHeras).

%PUNTO 2: soloParaBailar/1: un bolichees solo para bailar cuando no sirve comida.
soloParaBailar(Boliche):-
    boliche(Boliche),
    not(sirveComida(Boliche)).

%PUNTO 3: podemosIrConEsa/1: cuando decimos que podemos ir con una localidad es porque 
%sabemos que todos sus boliches son piolas.
podemosIrConEsa(Localidad):-
    localidad(Localidad),
    forall(quedaEn(Boliche, Localidad), esPiola(Boliche)).

%PUNTO 4: puntaje/2: nos permite relacionar un boliche con su puntaje
puntaje(Boliche, Puntaje):-
    esDeTipo(Boliche, Tipo),
    puntajePorTipoDeBoliche(Tipo, Puntaje).

puntajePorTipoDeBoliche(tematico(Tematica), 7):-
    Tematica \= ochentoso.

puntajePorTipoDeBoliche(tematico(ochentoso), 9).

puntajePorTipoDeBoliche(electronico(_, HoraInicio, HoraFin), Puntaje):-
    Puntaje is HoraInicio + HoraFin.

puntajePorTipoDeBoliche(cachengue(ListaDeCanciones), 10):-
    member(biodiesel, ListaDeCanciones),
    member(buenComportamiento, ListaDeCanciones).

%PUNTO 5: elMasGrande/2: el boliche más grande de una localidad es aquel 
%que tiene la mayor capacidad
elMasGrande(Localidad, Boliche):-
    quedaEn(Boliche, Localidad),
    forall((quedaEn(OtroBoliche, Localidad), Boliche \= OtroBoliche), esMasGrande(Boliche, OtroBoliche)).
    
esMasGrande(Boliche, OtroBoliche):-
    entran(Boliche, Cantidad),
    entran(OtroBoliche, OtraCantidad),
    Cantidad > OtraCantidad.

%PUNTO 6: puedeAbastecer/2: una localidad puede abastecer a una determinada 
%cantidad de personas si la suma de capacidades de los boliches que 
%quedan en ella es mayor o igual a esa cantidad. Tener en cuenta que 
%este punto no puede ser totalmente inversible.

puedeAbastecer(Localidad, Cantidad):-
    localidad(Localidad),
    findall(Capacidad, capacidadDeBoliche(_, Localidad, Capacidad), ListaDeCapacidades),
    sum_list(ListaDeCapacidades, CapacidadMaxima),
    CapacidadMaxima >= Cantidad.

capacidadDeBoliche(Boliche, Localidad, Capacidad):-
    quedaEn(Boliche, Localidad),
    entran(Boliche, Capacidad).







