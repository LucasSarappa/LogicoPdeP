/*
La Cárcel: https://docs.google.com/document/d/12zUNFV4K7Iofc47FN-b7O-gXjTrqgP4dQh47yJVlvw0/edit
Resolucion: https://www.youtube.com/watch?v=yId9hLw5CwE&list=PL7wy4vA6RpN51gkoPaU6xmtg7KkZy2aHG&index=15


Gestionar una cárcel no es tarea fácil y para lograrlo requerimos la ayuda de un programa en Prolog. Se cuenta con la siguiente base de conocimiento, que contiene 
información acerca de varias cárceles y qué personas residen allí: tanto guardias como prisioneros.

De los guardias sabemos su nombre y de los prisioneros, su nombre y los crímenes que cometieron. Se contemplan tres tipos de crímenes:
    Homicidio, que registra la víctima.
    Narcotráfico, que indica la lista de drogas traficadas.
    Robo, que relaciona cuánto dinero en dólares fue robado.

Por ejemplo, una base de conocimiento de referencia podría verse así:

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico[heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).



Teniendo en cuenta la base de conocimiento planteada, se pide resolver los siguientes puntos, asegurándose de implementar todos los predicados que se piden de modo 
que sean completamente inversibles. Recuerden que no está permitido el uso de OR (;), CUT (!) y que los usos de findall/3 deben ser restringidos a las situaciones 
donde es indispensable.



1. Dado el predicado controla/2:


        % controla(Controlador, Controlado)

        controla(piper, alex).
        controla(bennett, dayanara).
        controla(Guardia, Otro):- prisionero(Otro,_), not(controla(Otro, Guardia)).


Indicar, justificando, si es inversible y, en caso de no serlo, dar ejemplos de las consultas que NO podrían hacerse y corregir la implementación para que se pueda.


2. conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean guardias o prisioneros) si no se controlan mutuamente y existe algún tercero al cual ambos controlan.


3. peligroso/1: Se cumple para un preso que sólo cometió crímenes graves.
        Un robo nunca es grave.
        Un homicidio siempre es grave.
        Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a la vez, o incluye metanfetaminas.


4. ladronDeGuanteBlanco/1: Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.


5. condena/2: Relaciona a un prisionero con la cantidad de años de condena que debe cumplir. Esto se calcula como la suma de los años que le aporte cada crimen cometido, que 
se obtienen de la siguiente forma:
        La cantidad de dinero robado dividido 10.000.
        7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
        2 años por cada droga que haya traficado.



6. capoDiTutiLiCapi/1: Se dice que un preso es el capo de todos los capos cuando nadie lo controla, pero todas las personas de la cárcel (guardias o prisioneros) son controlados 
por él, o por alguien a quien él controla (directa o indirectamente).

*/

% SOLUCION:


% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotráfico([metanfetaminas])).
prisionero(alex, narcotráfico([heroína])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotráfico[heroína, opio])).
prisionero(dayanara, narcotráfico([metanfetaminas])).


% 1. Dado el predicado controla/2:


        % controla(Controlador, Controlado)

        controla(piper, alex).
        controla(bennett, dayanara).
        controla(Guardia, Otro):- 
            prisionero(Otro,_), 
            not(controla(Otro, Guardia)).


% Indicar, justificando, si es inversible y, en caso de no serlo, dar ejemplos de las consultas que NO podrían hacerse y corregir la implementación para que se pueda.


% La variable guardia no es inversible ya que se usa por primera vez dentro de un not, y ese es un punto de dificiltad para la inversibilidad ya que el not no es capaz de ligarlo
% Para la variable Otro, podria ser inversible siempre y cuando prisionero tambien lo sea (y lo es).

%Por lo tanto, el predicado controla es inversible para su segundo parametro pero no para el primero.  
%Para que lo sea completamente:

    controla(piper, alex).
    controla(bennett, dayanara).
    controla(Guardia, Otro):- 
        guardia(Guardia), % ligo el predicado guardia con Guardia y con esto ya es inversible ya que se liga antes del not.
        prisionero(Otro,_), 
        not(controla(Otro, Guardia)).


% 2. conflictoDeIntereses/2: relaciona a dos personas distintas (ya sean guardias o prisioneros) si no se controlan mutuamente y existe algún tercero al cual ambos controlan.

    conflictoDeIntereses(Uno, Otro):-
        controla(Uno, Tercero), 
        controla(Otro, Tercero), % estas van aca arriba para que se haga inversible conflictoDeIntereses (ya que controla tambien lo es)
        not (controla(Uno, Otro)),
        not (controla(Otro, Uno)),
        Uno \= Otro.


% 3. peligroso/1: Se cumple para un preso que sólo cometió crímenes graves.
    %         Un robo nunca es grave. % no hace falta escribir nada por universo cerrado ya que no matchea con ninguna regla.
    %         Un homicidio siempre es grave.
    % Un delito de narcotráfico es grave cuando incluye al menos 5 drogas a la vez, o incluye metanfetaminas.


peligroso (Prisionero) :-
    prisionero(Prisionero, _), % para que sea inversible lo ligo a prisionero ya que sino llega al forall sin usarse antes y va sin el crimen ya que el universo cerrado me asegura que no hay otro tipo de crimen.
    forall (prisionero(Prisionero, Crimen), grave(Crimen)).


grave(homicidio(_)).

grave(narcotráfico(Drogas)):- 
    member(metanfetaminas, Drogas).
    length(Drogas, Cantidad), Cantidad >= 5.

% grave no es inversible ya que no hay forma de generar las victimas de un homicidio o las drogas de un narcotrafico. Pero no necesito que lo sea, ya que ademas al ser auxiliar no lo voy a consultar directamente..


% 4. ladronDeGuanteBlanco/1: Aplica a un prisionero si sólo cometió robos y todos fueron por más de $100.000.

/*
ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, _), % para que sea inversible lo ligo a prisionero ya que sino llega al forall sin usarse antes y va sin el crimen ya que el universo cerrado me asegura que no hay otro tipo de crimen.
    forall(prisionero(Prisionero, robo(Monto)), Monto > 100000).
*/
% el problema de esto es que me esta generando solamente el universo solamente de los crimenes que fueron robos, con lo cual este universo no me alcanza.

monto (robo(Monto), Monto).

ladronDeGuanteBlanco(Prisionero) :-
    prisionero(Prisionero, _), % para que sea inversible lo ligo a prisionero ya que sino llega al forall sin usarse antes y va sin el crimen ya que el universo cerrado me asegura que no hay otro tipo de crimen.
    forall(prisionero(Prisionero, Crimen), monto(Crimen, Monto), Monto > 100000).


% 5. condena/2: Relaciona a un prisionero con la cantidad de años de condena que debe cumplir. Esto se calcula como la suma de los años que le aporte cada crimen cometido, que
% se obtienen de la siguiente forma:
    %         La cantidad de dinero robado dividido 10.000.
    %         7 años por cada homicidio cometido, más 2 años extra si la víctima era un guardia.
    %         2 años por cada droga que haya traficado.

pena (robo(Monto), Pena) :-
    Pena is Monto / 10000.

pena (homicidio(Persona), 9) :-
    guardia(Persona).

pena (homicidio(Persona), 7).
    not(guardia(Persona)).

pena (narcotráfico(Drogas), Pena) :-
    length(Drogas, Cantidad),
    Pena is Cantidad * 2.

condena(Prisionero, Condena) :-
    prisionero(Prisionero, _), 
    findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), Penas),
    sumlist(Penas, Condena).


%6. capoDiTutiLiCapi/1: Se dice que un preso es el capo de todos los capos cuando nadie lo controla, pero todas las personas de la cárcel (guardias o prisioneros) son controlados
% por él, o por alguien a quien él controla (directa o indirectamente).

persona(Persona):-
    prisionero(Persona, _).

persona(Persona):-
    guardia(Persona).

controlaDirectaOIndirectamente(Uno, Otro) :-
    controla(Uno, Otro).

controlaDirectaOIndirectamente(Uno, Otro):-
    controla(Uno, Tercero),
    controlaDirectaOIndirectamente(Tercero, Otro).

capo(Capo):-
    prisionero(Capo, _),
    not(controla(_,Capo)),
    forall((persona(Persona), Capo \= Persona), controlaDirectaOIndirectamente(Capo, Persona)).

