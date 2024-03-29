/*Parcial Lógico - SIGAPDEP - Paradigmas de programación 2do Cuatrimestre 2012

https://drive.google.com/file/d/1Y9Ag2Zc621wQ-YQ9XgAtjA1BFKaZ5RR7/view

La secretaría de gestión académica nos pidió un sistema lógico para manejar las inscripciones.
La base de conocimientos que nos proveen contiene información de la siguiente forma:


%Días de cursadas (toda materia que se dicte ofrece al menos una opción horaria)

    opcionHoraria(paradigmas, lunes).
    opcionHoraria(paradigmas, martes).
    opcionHoraria(paradigmas, sabados).
    opcionHoraria(algebra, lunes).
    (...)
    %Correlatividades
    correlativa(paradigmas, algoritmos).
    correlativa(paradigmas, algebra).
    correlativa(analisis2, analisis1).
    (...)
    %cursada(persona,materia,evaluaciones)
    cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
    cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
    cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
    cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelent
    e),tp(funcional,excelente)]).
    cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).
    (...)


El sistema debe resolver los siguientes problemas:

    1.notaFinal/2 relaciona una lista de evaluaciones con la nota final. Las evaluaciones pueden ser o parciales o tps. La nota final se obtiene promediando las notas. 
    Para eso sabemos que un tp excelente equivale a un 10, un tp bien a un 7 y un tp mal a un 2. 
        
        Por ejemplo:
        ?- notaFinal([parcial(8),tp(dragonBall,excelente)],N).
        N = 9.


    2. aprobo/2 relaciona una persona y una materia, sólo si la persona aprobó esa materia (la nota final es 4 ó más y no se saco menos de 4 en ninguna de sus evaluaciones). 
    Este predicado debe ser inversible. 
    
        Por Ejemplo:
        ?- aprobo(Alumno,M).
        Alumno = maria,
        M = algebra ;
        Alumno = wilfredo,
        M = paradigmas
        ?- aprobo(maria,analisis1).
        false. (porque maria se saco mal en el tp de limite, y la nota de un tp en mal es 2 que es menor que
    
    3. puedeCursar/2. Relaciona un alumno con una materia que pueda cursar. Una materia se puede cursar cuando todavia no fue aprobada y todas las correlativas fueron aprobadas 
    (No hay excepciones de correlativas, así que si una materia esta aprobada todas sus correlativas también). Tengan en cuenta que una materia sin correlativas siempre puede ser 
    cursada (si no se aprobo antes,claro).

        Por ejemplo:
        ?- puedeCursar(maria,paradigmas).
        true. %porque maria aprobo algoritmos y algebra que son las correlativas de paradigmas
        ?- puedeCursar(maria,algebra).
        false.%no la puede cursar porque ya la tiene aprobada
        ?- puedeCursar(maria,analisis1).
        true . %la puede cursar porque en la cursada que tiene no fue aprobada
        ?- puedeCursar(maria,ingenieriaYSociedad).
        true . %porque es una materia sin correlativas

    4. opcionesDeCursada/2 Que relaciona un alumno con todas sus opciones posibles de cursadas para el próximo cuatrimestre. Las opciones de cursadas representan una materia que 
    el alumno puede cursar en una opción horaria dada para dicha materia. Una opción se representa con el functor opcion/2 que representa una materia con un día en el que se dicta. 
    Este predicado debe de ser inversible.

        Por ejemplo:
        ?- cuatrimestrePosible(A,Os).
        A = maria,
        Os=[opcion(paradigmas, lunes), opcion(paradigmas, martes), opcion(paradigmas, sabados)] ;


    5.

        a. sinSuperposiciones/2 Que relaciona a una lista de opciones con las opciones que podrían conformar una cursada. Una cursada se conforma cuando todas las opciones de la lista 
        son compatibles entre sí (cada materia está a lo sumo una vez y no se repiten los días de cursada).

        b. Hacer que este predicado sea inversible para el segundo argumento.

                Ayuditas:
                Se cuenta definido el predicado subconjunto que relaciona un conjunto con una lista si el primero es subconjunto
                del segundo.
                subconjunto([],_).
                subconjunto([X|Xs],L):-
                sinElemento(X,L,L2),
                subconjunto(Xs,L2).
                sinElemento(E,[E|Xs],Xs).
                sinElemento(E,[X|Xs],[X|XsSinE]):-
                sinElemento(E,Xs,XsSinE).
                ?- subconjunto(S,[1,2,3]).
                S = [] ;
                S = [1] ;
                S = [1, 2] ;
                S = [1, 2, 3] ;
                S = [1, 3] ;
                ...
                Ejemplos de consultas:
                ?-sinSuperposiciones([opcionHoraria(paradigmas,lunes),opcionHoraria(paradigmas,martes)],L).
                L = [] ;
                L = [opcionHoraria(paradigmas, lunes)] ;
                L = [opcionHoraria(paradigmas, martes)] ;
                ?-
                sinSuperposiciones([opcionHoraria(paradigmas,lunes),opcionHoraria(paradigmas,martes),opcionHoraria(dis
                enio,miercoles)],L).
                L = [] ;
                L = [opcionHoraria(paradigmas, lunes)] ;
                L = [opcionHoraria(paradigmas, martes)] ;
                L = [opcionHoraria(paradigmas, martes), opcionHoraria(disenio, miercoles)] ;
                L = [opcionHoraria(paradigmas, lunes), opcionHoraria(disenio, miercoles)] ;
                L = [opcionHoraria(disenio, miercoles), opcionHoraria(paradigmas, martes)] ;
*/


%Base de conocimiento
opcionHoraria(paradigmas, lunes).
opcionHoraria(paradigmas, martes).
opcionHoraria(paradigmas, sabados).
opcionHoraria(algebra, lunes).

%Correlatividades
correlativa(paradigmas, algoritmos).
correlativa(paradigmas, algebra).
correlativa(analisis2, analisis1).


%cursada(persona,materia,evaluaciones).
cursada(maria,algoritmos,[parcial(5),parcial(7),tp(mundial,bien)]).
cursada(maria,algebra,[parcial(5),parcial(8),tp(geometria,excelente)]).
cursada(maria,analisis1,[parcial(9),parcial(4),tp(gauss,bien), tp(limite,mal)]).
cursada(wilfredo,paradigmas,[parcial(7),parcial(7),parcial(7),tp(objetos,excelente),tp(logico,excelente),tp(funcional,excelente)]).
cursada(wilfredo,analisis2,[parcial(8),parcial(10)]).

%Punto 1:
notaFinal(Evaluaciones, NotaFinal):-
    findall(Nota, notaEvaluacion(Evaluaciones, Nota), Notas),
    sum_list(Notas, NotaFinalTotal),
    length(Evaluaciones, CantidadNotas),
    NotaFinal is NotaFinalTotal/CantidadNotas.

notaEvaluacion(Evaluaciones, Nota):-
    member(Evaluacion, Evaluaciones),
    notaDeEvaluacion(Evaluacion, Nota).

notaDeEvaluacion(parcial(Nota), Nota).
notaDeEvaluacion(tp(_,NotaTp), Nota):-
    notaTp(NotaTp, Nota).

notaTp(excelente, 10).
notaTp(bien, 7).
notaTp(mal,2).

%Punto 2:
aprobo(Persona, Materia):-
    cursada(Persona,Materia, Evaluaciones),
    aproboCursada(Evaluaciones),
    not(reproboEvaluacion(Evaluaciones)).

aproboCursada(Evaluaciones):-
    notaFinal(Evaluaciones, NotaFinal),
    NotaFinal >= 4.

reproboEvaluacion(Evaluaciones):-
    notaEvaluacion(Evaluaciones, Nota),
    Nota < 4.

%Punto 3:
puedeCursar(Persona, MateriaCursable):-
    cursada(_,MateriaCursable,_),
    aproboTodasLasCorrelativas(Persona, MateriaCursable),
    not(aproboMateriaOCorrelativaSuperior(Persona, MateriaCursable)).
    

aproboTodasLasCorrelativas(Persona, Materia):-
    cursada(Persona,_,_),
    forall(correlativa(Materia,Correlativa), aprobo(Persona, Correlativa)).


aproboMateriaOCorrelativaSuperior(Persona, MateriaCursable):-
    materiaOCorrelativaSuperior(MateriaCursable, OtraMateria),
    aprobo(Persona, OtraMateria).

materiaOCorrelativaSuperior(Materia, Materia).
materiaOCorrelativaSuperior(Materia, CorrelativaSuperior):-
    correlativa(CorrelativaSuperior, Materia).
