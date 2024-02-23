/*
Consigna: "Metaparcial": https://github.com/MateoMichini1/PdeP_ParcialLogico
Los parciales son difíciles de crear, todos los años hay que tener temas nuevos y frescos. 
Este año usaremos las mentes de nuestros estudiantes para que hagan un programa que nos pueda crear parciales para futuros años.

Market

Los parciales tienen que tener un Tema Copado, que despierte el interés de estudiantes y les familiarice un poco al modelo. Los parciales tienen una lista de puntos que se deberán resolver, que suelen ser entre 7 y 10 puntos. Cada uno de esos puntos evalúa algún tema... y si o si tienen que ser evaluados todos los temas, como por ejemplo primer orden.

Nota. Tener en cuenta que todos los predicados deben ser totalmente inversibles, salvo que se aclare lo contrario.

% parcial(Tema, [Puntos]).
temaCopado(chocobos).
temaCopado(inversiones).
temaCopado(harryPotter).
temaCopado(carpinchos).
temaCopado(bidones).
temaCopado(piratas).
temaCopado(tierraMedia).
temaCopado(kraken).

punto(primerOrden).
punto(ordenSuperior).
punto(polimorfismo).
punto(listas).
punto(relleno).
punto(modelado).
punto(diagramado).
Se pide:

Hacer parcialEvalua/2 que relaciona un parcial con un punto que evalúa. No requiere ser inversible para el parcial.

Hacer esParcialListo/1 que resulta verdadero para un parcial que cumple todas las reglas de los parciales (tiene entre 7 y 10 puntos, tiene un tema copado y evalúa todos los puntos al menos una vez). No requiere ser inversible para el parcial.

Hacer puntosInventados/1, que genera una lista de puntos de cantidad válida.

Hacer nuevoParcial/1, que debe generar un parcial nuevo que esté listo.

Ya que nos están haciendo los parciales, vamos a tratar de predecir quienes van a aprobar. Agregar a la base de conocimiento un predicado que relacione el nombre de un estudiante y un punto que sabe, con ejemplos.

Hacer aprueba/2, que relaciona a un estudiante con un parcial, siempre y cuando sepa todos los temas que este último abarca. No requiere ser inversible para el parcial.

Hacer una consulta que unifique la variable Aprobados con una lista de todos los estudiantes que aprueban este parcial:

parcial(chocobos, [primerOrden, primerOrden, ordenSuperior, polimorfismo, listas, relleno, modelado, diagramado]). 
Nota: No definir un nuevo predicado.

Saber si un parcial es sólo para elegidos, que es cuando sólo un alumno puede aprobarlo. No requiere ser inversible para el parcial.

*/

/*
Nombre:Mateo Michini
Dni: 43243584
Legajo: 175816-0
*/
% ------------------------------------------------------- Base de conocimiento inicial---------------------------------------------

temaCopado(chocobos).
temaCopado(inversiones).
temaCopado(harryPotter).
temaCopado(carpinchos).
temaCopado(bidones).
temaCopado(piratas).
temaCopado(tierraMedia).
temaCopado(kraken).

punto(primerOrden).
punto(ordenSuperior).
punto(polimorfismo).
punto(listas).
punto(relleno).
punto(modelado).
punto(diagramado).

/*
Es un Functor :
parcial(Tema, [Puntos]).
*/

% ------------------------------------------------------- Punto 1 ------------------------------------------------------------

parcialEvalua(parcial(_, Puntos),Punto):-
member(Punto,Puntos),
punto(Punto).

%El parcial no es inversible como se aclara en el enunciado
% ------------------------------------------------------- Punto 2 ------------------------------------------------------------

esParcialListo( parcial(Tema, Puntos) ):-
temaCopado(Tema),
restricionCantidadDePuntos(Puntos),
forall( punto(Punto), member(Punto,Puntos)).

restricionCantidadDePuntos(Puntos):-
length(Puntos,CantidadPuntos),
between(7,10,CantidadPuntos).

%Esta relacion se aclara que NO es inversible
% ------------------------------------------------------- Punto 3 ------------------------------------------------------------
puntosInventados([]).

puntosInventados([Punto|Puntos]):-
punto(Punto),
restricionCantidadDePuntos([Punto|Puntos]),
puntosInventados( Puntos).

puntosInventados([Punto|Puntos]):-
length(Puntos,CantidadPuntos),
CantidadPuntos<7,
punto(Punto),
puntosInventados( Puntos).

%Utilizacion de recursividad
/*
El enunciado dice " lista de puntos de cantidad válida", por lo cual se evalua UNICAMENTE la condicion de que tenga entre 
7 y 10 puntos
*/
%------------------------------------------------------- Punto 4 ------------------------------------------------------------

nuevoParcial( Parcial):-
armadoDeParcial(Parcial),
esParcialListo(Parcial).

armadoDeParcial(parcial(Tema,Puntos)):-
temaCopado(Tema),
puntosInventados(Puntos).

/*
Se arma el parcial en un predicado auxiliar(armadoDeParcial) mediante la utilizacion de patter matching.
El armado del parcial se realiza mediante la extraccion de temas de temaCopado(Tema) que es nuestra unica fuente de temas y los puntos que se 
extraen del predicado del punto 3(puntosInventados).
Ademas, se verifica que cumpla los requisitos pedidos en el primer punto.
*/

% ------------------------------------------------------- Punto 5 ------------------------------------------------------------


/* 

Este predicado tenia que "relacionar el nombre de un estudiante y un punto que sabe".
Se interpreto que hay que modelar un predicado con el nombre de un estudiante con su punto mediante un predicado.

damian SABE listas

*/

%Caso de prueba:
sabe(damian, listas).
sabe(damian,relleno).
sabe(damian,ordenSuperior).
sabe(damian,primerOrden).
sabe(damian,primerOrden).
sabe(damian,polimorfismo).
sabe(damian,modelado).
sabe(damian,diagramado).

sabe(mateoMichini, listas).
sabe(mateoMichini,relleno).
sabe(mateoMichini,ordenSuperior).
sabe(mateoMichini,primerOrden).
sabe(mateoMichini,primerOrden).
sabe(mateoMichini,polimorfismo).
sabe(mateoMichini,modelado).
sabe(mateoMichini,diagramado).
 
sabe(nicolas, listas).
sabe(nicolas,relleno).
sabe(nicolas,ordenSuperior).
sabe(nicolas,primerOrden).

 


% ------------------------------------------------------- Punto 6 ------------------------------------------------------------

aprueba(Estudiante,Parcial):-
sabe(Estudiante,_) ,
forall( parcialEvalua(Parcial,Punto)   , sabe(Estudiante,Punto)  ).

 
 
% ------------------------------------------------------- Punto 7 ------------------------------------------------------------

/*
La consulta fue:

15 ?- aprueba(Aprobados,parcial(chocobos, [primerOrden, primerOrden, ordenSuperior, polimorfismo, listas, relleno, modelado, diagramado])). 
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = damian ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;
Aprobados = mateoMichini ;


En este caso, ser realizo una consulta existencial donde se probo la inversiblidad  para el nombre del  estudiante,pero no para el parcial(No se tenia que hacer).
Ademas, se unifico la variable Aprobados , proceso en el cual se liga la variable a valores.

Finalmente, se conluye que la relacion funciona ya que los dos estudiantes(mateo y damian) que saben todos los puntos, aprueban.
Pero un estudiante(nicolas) no sabe todos los temas y no aprueba, sabemos esto   debido al principio de universo cerrado.



Aclaracion:se podrian eliminar los repetidos con distinct/2 , que elimina los resultados repetidos.
*/

% ------------------------------------------------------- Punto 8  ------------------------------------------------------------

soloParaElegidos(Parcial):-
aprueba(NombreEstudiante,Parcial),
not( ( aprueba(OtroNombreEstudiante,Parcial),OtroNombreEstudiante \= NombreEstudiante)).

%El enunciado aclara   que NO debe ser inversible