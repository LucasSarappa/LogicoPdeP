/*
Las Casas de Hogwarts https://docs.google.com/document/d/e/2PACX-1vR9SBhz2J3lmqcMXOBs1BzSt7N1YWPoIuubAmQxPIOcnbn5Ow9REYt4NXQzOwXXiUaEQ4hfHNEt3_C7/pub
La solucion que esta aca es de este

(Otra version, cambian algunos puntos del final: https://docs.google.com/document/d/1Dc7crdtkBYyoxiRes3BYaAOnHgkfYV_cvDBXn_yR2ZI/edit#heading=h.vm54i14bhmgt)
La solucion que esta aca es de este: https://github.com/mfmarano/practica-logico/blob/main/parcial-las-casas-de-hogwarts/las-casas-de-hogwarts.pl

Otra solucion: https://github.com/mbeorlegui/PracticasLogico/tree/master/casas-de-hogwarts


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Las Casas de Hogwarts:

En Hogwarts, el colegio de magia y hechicería, hay 4 casas en las cuales los nuevos alumnos se distribuyen ni bien ingresan. Cada año estas casas compiten entre ellas 
para consagrarse la ganadora de la copa.

Parte 1 - Sombrero Seleccionador

    Para determinar en qué casa queda una persona cuando ingresa a Hogwarts, el Sombrero Seleccionador tiene en cuenta el carácter de la persona, lo que prefiere y en algunos 
    casos su status de sangre.

    Tenemos que registrar en nuestra base de conocimientos qué características tienen los distintos magos que ingresaron a Hogwarts, el status de sangre que tiene cada mago y 
    en qué casa odiaría quedar. Actualmente sabemos que:

        Harry es sangre mestiza, y se caracteriza por ser corajudo, amistoso, orgulloso e inteligente. Odiaría que el sombrero lo mande a Slytherin.
        Draco es sangre pura, y se caracteriza por ser inteligente y orgulloso, pero no es corajudo ni amistoso. Odiaría que el sombrero lo mande a Hufflepuff.
        Hermione es sangre impura, y se caracteriza por ser inteligente, orgullosa y responsable. No hay ninguna casa a la que odiaría ir.
        Además nos interesa saber cuáles son las características principales que el sombrero tiene en cuenta para elegir la casa más apropiada:

    Para Gryffindor, lo más importante es tener coraje.
    Para Slytherin, lo más importante es el orgullo y la inteligencia.
    Para Ravenclaw, lo más importante es la inteligencia y la responsabilidad.
    Para Hufflepuff, lo más importante es ser amistoso.

    Se pide:

    1. Saber si una casa permite entrar a un mago, lo cual se cumple para cualquier mago y cualquier casa excepto en el caso de Slytherin, que no permite entrar a magos 
    de sangre impura.

    2. Saber si un mago tiene el carácter apropiado para una casa, lo cual se cumple para cualquier mago si sus características incluyen todo lo que se busca para los integrantes 
    de esa casa, independientemente de si la casa le permite la entrada.

    3. Determinar en qué casa podría quedar seleccionado un mago sabiendo que tiene que tener el carácter adecuado para la casa, la casa permite su entrada y además el mago no 
    odiaría que lo manden a esa casa. Además Hermione puede quedar seleccionada en Gryffindor, porque al parecer encontró una forma de hackear al sombrero.

    4. Definir un predicado cadenaDeAmistades/1 que se cumple para una lista de magos si todos ellos se caracterizan por ser amistosos y cada uno podría estar en la misma 
    casa que el siguiente. No hace falta que sea inversible, se consultará de forma individual.

[ELIPSIS]

Parte 2 - La copa de las casas
    A lo largo del año los alumnos pueden ganar o perder puntos para su casa en base a las buenas y malas acciones realizadas, y cuando termina el año se anuncia el ganador 
    de la copa. 
    Sobre las acciones que impactan al puntaje actualmente tenemos la siguiente información:

        - Malas acciones: son andar de noche fuera de la cama (que resta 50 puntos) o ir a lugares prohibidos. La cantidad de puntos que se resta por ir a un lugar prohibido 
        se indicará para cada lugar. Ir a un lugar que no está prohibido no afecta al puntaje.
        - Buenas acciones: son reconocidas por los profesores y prefectos individualmente y el puntaje se indicará para cada acción premiada.
        Necesitamos registrar las distintas acciones que hicieron los alumnos de Hogwarts durante el año. 
    
    Sabemos que:

        Harry anduvo fuera de cama.
        Hermione fue al tercer piso y a la sección restringida de la biblioteca.
        Harry fue al bosque y al tercer piso.
        Draco fue a las mazmorras.
        A Ron le dieron 50 puntos por su buena acción de ganar una partida de ajedrez mágico.
        A Hermione le dieron 50 puntos por usar su intelecto para salvar a sus amigos de una muerte horrible.
        A Harry le dieron 60 puntos por ganarle a Voldemort.

    También sabemos que los siguientes lugares están prohibidos:

        El bosque, que resta 50 puntos.
        La sección restringida de la biblioteca, que resta 10 puntos.
        El tercer piso, que resta 75 puntos.

    También sabemos en qué casa quedó seleccionado efectivamente cada alumno mediante el predicado esDe/2 que relaciona a la persona con su casa, por ejemplo:

        esDe(hermione, gryffindor).
        esDe(ron, gryffindor).
        esDe(harry, gryffindor).
        esDe(draco, slytherin).
        esDe(luna, ravenclaw).

    Se pide incorporar a la base de conocimiento la información sobre las acciones realizadas y agregar la siguiente lógica a nuestro programa:

    1.
        a) Saber si un mago es buen alumno, que se cumple si hizo alguna acción y ninguna de las cosas que hizo se considera una mala acción 
        (que son aquellas que provocan un puntaje negativo).
        
        b)Saber si una acción es recurrente, que se cumple si más de un mago hizo esa misma acción.
    
    2. Saber cuál es el puntaje total de una casa, que es la suma de los puntos obtenidos por sus miembros.
    
    3. Saber cuál es la casa ganadora de la copa, que se verifica para aquella casa que haya obtenido una cantidad mayor de puntos que todas las otras.
    
    4. Queremos agregar la posibilidad de ganar puntos por responder preguntas en clase. La información que nos interesa de las respuestas en clase son: 
    cuál fue la pregunta, cuál es la dificultad de la pregunta y qué profesor la hizo.
    Por ejemplo, sabemos que Hermione respondió a la pregunta de dónde se encuentra un Bezoar, de dificultad 20, realizada por el profesor Snape, y cómo hacer 
    levitar una pluma, de dificultad 25, realizada por el profesor Flitwick.

    Modificar lo que sea necesario para que este agregado funcione con lo desarrollado hasta ahora, teniendo en cuenta que los puntos que se otorgan equivalen 
    a la dificultad de la pregunta, a menos que la haya hecho Snape, que da la mitad de puntos en relación a la dificultad de la pregunta.

*/


% Sombrero Seleccionador:

% Tenemos que registrar en nuestra base de conocimiento
% que caracteristicas tienen los distintos magos:

ingresante(harry, sangreImpura, [amistoso, orgulloso, coraje, inteligente]).
ingresante(draco, sangrePura, [inteligente, orgulloso]).
ingresante(hermione, sangreImpura, [inteligente, orgulloso, responsable]).

odia(harry, slytherin).
odia(draco, hufflepuf).

% Nos interesa saber cuales son las caracteristicas principales
% que el sombrero tiene para elegir la casa más apropiada:

% Para Gryffindor, lo más importante es tener coraje:
caracteristicaImportante(gryffindor, [coraje]).

% Para Slytherin, lo más importante es el orgulloso y inteligencia:
caracteristicaImportante(slytherin, [orgulloso, inteligencia]).

% Para Hufflepuff, lo más importante es ser amistoso:
caracteristicaImportante(hufflepuf, [amistoso]).

% Punto 1: 

puedeEntrar(Mago, CasaMagica) :-
    ingresante(Mago, TipoDeSangre, _),
    enBaseAlTipoDeSangreVa(CasaMagica, TipoDeSangre).

enBaseAlTipoDeSangreVa(slytherin, TipoDeSangre) :-
    TipoDeSangre \= sangreImpura.

enBaseAlTipoDeSangreVa(gryffindor, _).
enBaseAlTipoDeSangreVa(hufflepuf, _).
enBaseAlTipoDeSangreVa(ravenclaw, _).

% Punto 2: 

tieneElCaracterApropiado(Mago, CasaQueLoDejaEntrar) :-
    ingresante(Mago, _, CaracteristicasDelMago),
    caracteristicaImportante(CasaQueLoDejaEntrar, CaracteristicasDeLaCasa),
    forall(member(CaracteristicaDeLaCasa, CaracteristicasDeLaCasa), member(CaracteristicaDeLaCasa, CaracteristicasDelMago)).

% Punto 3:

enQueCasaQueda(hermione, gryffindor).

enQueCasaQueda(Mago, CasaQueLoDejaEntrar) :-
    ingresante(Mago, TipoDeSangre, CaracteristicasDelMago),
    puedeEntrar(TipoDeSangre, CasaQueLoDejaEntrar),
    tieneElCaracterApropiado(CaracteristicasDelMago, CasaQueLoDejaEntrar),
    not(odia(Mago, CasaQueLoDejaEntrar)).

% Punto 4:

sacarCaracteristicas(ingresante(_, _, ListaDeCaracteristicas), ListaDeCaracteristicas).

cadenaDeAmistades(Magos) :-
    forall((member(Mago, Magos),sacarCaracteristicas(Mago, ListaDeCaracteristicas)), member(amistoso, ListaDeCaracteristicas)),
    compararMagos(Magos).

compararMagos([_]).
compararMagos([MagoPrimero, MagoSegundo | Magos]) :-
    enQueCasaQueda(MagoPrimero, CasaQueLoDejaEntrar),
    enQueCasaQueda(MagoSegundo, CasaQueLoDejaEntrar),
    compararMagos([MagoSegundo | Magos]).

% La copa de las cosas:

% A lo largo del año los alumnos pueden ganar o perder puntos
% para su casa en base a buenas y malas acciones

% Malas acciones: Son andar de noche fuera de la cama
% o ir a lugares prohibidos

% Andar fuera de la cama resta 50 puntos
malaAccion(andarFueraDeLaCama, -50).

% Ir al "el bosque' resta 50 puntos
malaAccion(elBosque, -50).

% Ir a la seccion restringida resta 10 puntos
malaAccion(seccionRestringida, -10).

% Ir a la tercer piso resta 75 puntos
malaAccion(tercerPiso, -75).

% Buenas acciones: Son reconocidas por los profesores y prefectos
% el puntaje se indicará para cada acción premiada

% Ganar una partida de ajedrez magico suma 50 puntos
buenaAccion(ajedrezMagico, 50).

% Usar el intelecto para salvar a sus amigos de una muerte suma 50 puntos
buenaAccion(intelecto, 50).

% Ganarle a Voldemort suma 60 puntos
buenaAccion(voldemort, 60).

% Acciones que realizaron los alumnos:

% Harry anduvo fuera de cama
accion(harry, andarFueraDeLaCama).

% Hermione fue al tercer piso 
% y a la sección restringida de la biblioteca
accion(hermione, tercerPiso).
accion(hermione, seccionRestringida).

% Draco fue a las mazmorras
accion(draco, mazmorras).

% Ron gano una partida de ajedrez magico
accion(ron, ajedrezMagico).

% Hermione uso intelecto para salvar a sus amigos de la muerte
accion(hermione, intelecto).

% Harry le gano a Voldemort
accion(harry, voldemort).

% También sabemos en qué casa quedó seleccionado efectivamente 
% cada alumno mediante el predicado esDe/2 
% que relaciona a la persona con su casa

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% Punto 1A: 

buenAlumno(Mago) :- 
    accion(Mago, _),
    forall((accion(Mago, Accion), sacarPuntos(Accion, Puntos)), Puntos >= 0).

sacarPuntos(Accion, 0) :-
    not(buenaAccion(Accion, _)),
    not(malaAccion(Accion, _)).

sacarPuntos(Accion, Puntos) :-
    buenaAccion(Accion, Puntos).

sacarPuntos(Accion, Puntos) :-
    malaAccion(Accion, Puntos).

% Punto 1B:

esRecurrente(Accion) :-
    accion(Mago, Accion),
    accion(OtroMago, Accion),
    Mago \= OtroMago.

% Punto 2: 

puntajeTotal(Casa, PuntajeTotal) :-
    esDe(_, Casa),
    setof(Estudiante, esDe(Estudiante, Casa), Estudiantes),
    findall(Punto, (member(Estudiante, Estudiantes), accion(Estudiante, Accion), sacarPuntos(Accion, Puntos)), Puntos),
    sum_list(Puntos, PuntajeTotal).