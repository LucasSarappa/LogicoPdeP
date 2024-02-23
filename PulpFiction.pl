/*
RESOLUCION: https://github.com/pdep-mit/ejemplos-de-clase-prolog/commit/980e198482f44743f6f9238d166fbdb49cb6b960
ENUNCIADO: https://docs.google.com/document/d/15mo_2391atBqMjcYzLtKvGG6JiPzjbeyEGVlwZjv4B8/edit#

Pulp Fiction: 

Tarantino, un poco cansado después de largas horas de filmación de su clásico noventoso Pulp Fiction, decidió escribir un programa Prolog para entender mejor las relaciones 
entre sus personajes. 

Para ello nos entregó la siguiente base de conocimientos sobre sus personajes, parejas y actividades:

    personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
    personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
    personaje(vincent,    mafioso(maton)).
    personaje(jules,      mafioso(maton)).
    personaje(marsellus,  mafioso(capo)).
    personaje(winston,    mafioso(resuelveProblemas)).
    personaje(mia,        actriz([foxForceFive])).
    personaje(butch,      boxeador).

    pareja(marsellus, mia).
    pareja(pumkin,    honeyBunny).

    %trabajaPara(Empleador, Empleado)
    trabajaPara(marsellus, vincent).
    trabajaPara(marsellus, jules).
    trabajaPara(marsellus, winston).

    %etc

Sabiendo eso, resolver los siguientes predicados, los cuales deben ser completamente inversibles:
 
1. esPeligroso/1. Nos dice si un personaje es peligroso. Eso ocurre cuando:
    - realiza alguna actividad peligrosa: ser matón, o robar licorerías. 
    - tiene empleados peligrosos

2. duoTemible/2 que relaciona dos personajes cuando son peligrosos y además son pareja o amigos. Considerar que Tarantino también nos dió los siguientes hechos:

    amigo(vincent, jules).
    amigo(jules, jimmie).
    amigo(vincent, elVendedor).

3.  estaEnProblemas/1: un personaje está en problemas cuando 
        - el jefe es peligroso y le encarga que cuide a su pareja 
        - o bien, tiene que ir a buscar a un boxeador. 
    Además butch siempre está en problemas. 

    Ejemplo:

    ? estaEnProblemas(vincent)
    yes. %porque marsellus le pidió que cuide a mia, y porque tiene que ir a buscar a butch



La información de los encargos está codificada en la base de la siguiente forma: 

    %encargo(Solicitante, Encargado, Tarea). 
    %las tareas pueden ser cuidar(Protegido), ayudar(Ayudado), buscar(Buscado, Lugar)
    encargo(marsellus, vincent,   cuidar(mia)).
    encargo(vincent,  elVendedor, cuidar(mia)).
    encargo(marsellus, winston, ayudar(jules)).
    encargo(marsellus, winston, ayudar(vincent)).
    encargo(marsellus, vincent, buscar(butch, losAngeles)).

4.  sanCayetano/1:  es quien a todos los que tiene cerca les da trabajo (algún encargo). 
Alguien tiene cerca a otro personaje si es su amigo o empleado. 

5. masAtareado/1. Es el más atareado aquel que tenga más encargos que cualquier otro personaje.

6. personajesRespetables/1: genera la lista de todos los personajes respetables. Es respetable cuando su actividad tiene un nivel de respeto mayor a 9. Se sabe que:
    - Las actrices tienen un nivel de respeto de la décima parte de su cantidad de peliculas.
    - Los mafiosos que resuelven problemas tienen un nivel de 10 de respeto, los matones 1 y los capos 20.
    - Al resto no se les debe ningún nivel de respeto. 

7. hartoDe/2: un personaje está harto de otro, cuando todas las tareas asignadas al primero requieren interactuar con el segundo (cuidar, buscar o ayudar) o un amigo del segundo. Ejemplo:

    ? hartoDe(winston, vincent).
    true % winston tiene que ayudar a vincent, y a jules, que es amigo de vincent. 

8. Ah, algo más: nuestros personajes tienen características. Lo cual es bueno, porque nos ayuda a diferenciarlos cuando están de a dos. Por ejemplo:

    caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
    caracteristicas(jules,    [tieneCabeza, muchoPelo]).
    caracteristicas(marvin,   [negro]).

Desarrollar duoDiferenciable/2, que relaciona a un dúo (dos amigos o una pareja) en el que uno tiene al menos una característica que el otro no. 

*/

personaje(pumkin, ladron(licorerias)).
personaje(honeyBunny, ladron(estacionesDeServicio)). 
personaje(vincent, mafioso(maton)). 
personaje(jules, mafioso(maton)). 
personaje(marsellus, mafioso(capo)). 
personaje(winston, mafioso(resuelveProblemas)). 
personaje(mia, actriz(1, drama)).
personaje(marilyn, actriz(10, musical)). 
personaje(butch, boxeador). 

pareja(marsellus, mia). 
pareja(pumkin, honeyBunny). 

%trabajaPara(Empleador, Empleado) 
trabajaPara(marsellus, vincent). 
trabajaPara(marsellus, jules). 
trabajaPara(marsellus, winston). 


amigo(vincent, jules). 
amigo(jules, jimmie). 
amigo(vincent, elVendedor). 

%encargo(Solicitante, Encargado, Tarea).  
%las tareas pueden ser cuidar(Protegido), 
%ayudar(Ayudado), buscar(Buscado, Lugar) 

encargo(marsellus, vincent,   cuidar(mia)). 
encargo(marsellus, vincent,   buscar(mia, discoteca)). 
encargo(vincent,  elVendedor, cuidar(mia)). 
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)). 
encargo(marsellus, vincent, buscar(butch, losAngeles)). 
encargo(marsellus, jules, ayudar(vincent)).

esPeligroso(Personaje):-
	realizaActividadPeligrosa(Personaje).

esPeligroso(Personaje):-
	tieneEmpleadosPeligrosos(Personaje).


realizaActividadPeligrosa(Personaje):-
	personaje(Personaje, mafioso(maton)).

realizaActividadPeligrosa(Personaje):-
	personaje(Personaje, ladron(licorerias)).

tieneEmpleadosPeligrosos(Personaje):-
	trabajaPara(Personaje, Empleado),
	esPeligroso(Empleado).

duoTemible(Personaje1, Personaje2):-
	esPeligroso(Personaje1),
	esPeligroso(Personaje2),
	duo(Personaje1, Personaje2).

sonAmigos(Personaje1, Personaje2):-
	amigo(Personaje1, Personaje2).

sonAmigos(Personaje1, Personaje2):-
	amigo(Personaje2, Personaje1).

sonPareja(Personaje1, Personaje2):-
	pareja(Personaje2, Personaje1).

sonPareja(Personaje1, Personaje2):-
	pareja(Personaje1, Personaje2).

duo(Personaje1, Personaje2):-
	sonAmigos(Personaje1, Personaje2).

duo(Personaje1, Personaje2):-
	sonPareja(Personaje1, Personaje2).

estaEnProblemas(Personaje):-
	trabajaPara(Empleador, Personaje),
	esPeligroso(Empleador),
	encargo(Empleador, Personaje, cuidar(Pareja)),
	sonPareja(Empleador, Pareja).

estaEnProblemas(butch).

estaEnProblemas(Personaje):-
	encargo(_, Personaje, buscar(Alguien,_)),
	personaje(Alguien, boxeador).


tieneCerca(Personaje1, Personaje2):-
	sonAmigos(Personaje1, Personaje2).

tieneCerca(Personaje1, Personaje2):-
	trabajaPara(Personaje1, Personaje2).

sanCayetano(Personaje):-
	tieneCerca(Personaje, _),
	forall(tieneCerca(Personaje, Alguien), 
		encargo(Personaje, Alguien, _)).

%versión polimorfica

hartoDe(Personaje1, Personaje2):-
	personaje(Personaje1, _),
	personaje(Personaje2, _),
	forall(encargo(_, Personaje1, Encargo), 
		requiereInteractuarCon(Personaje2, Encargo)).


requiereInteractuarCon(Personaje, cuidar(Personaje)).
%Esto es equivalente a hacer:
%requiereInteractuarCon(Alguien, cuidar(Personaje)):- Alguien = Personaje.


requiereInteractuarCon(Personaje, buscar(Personaje, _)).

requiereInteractuarCon(Personaje, ayudar(Personaje)).

%versión horrible

hartode2(Personaje1, Personaje2):-
	forall(encargo(_, Personaje1, cuidar(OtroPersonaje)), 
		OtroPersonaje = Personaje2),
	forall(encargo(_, Personaje1, ayudar(OtroPersonaje)), 
		OtroPersonaje = Personaje2),
	forall(encargo(_, Personaje1, buscar(OtroPersonaje, _)), 
		OtroPersonaje = Personaje2).


esRespetable(Personaje):-
	personaje(Personaje, Actividad),
	nivelDeRespeto(Actividad, Nivel),
	Nivel > 9.

nivelDeRespeto(mafioso(maton), 1).

nivelDeRespeto(mafioso(resuelveProblemas), 10).

nivelDeRespeto(mafioso(capo), 20).

nivelDeRespeto(actriz(Cantidad, Genero), Nivel):-
	indiceDeRespeto(Genero, Indice),
	Nivel is (Cantidad/ 10)*Indice.

indiceDeRespeto(drama, 5).
indiceDeRespeto(musical, 2).
