/*
¡Voy a ser el Rey de los Piratas!
"¿Mis riquezas y tesoros?, si lo desean se los daré ¡Encuéntrenlo!¡Lo escondí todo en ese lugar!"
Esas fueron las últimas palabras de Gol D. Roger, las cuales gritó con una sonrisa durante su ejecución pública a manos de la Marina. 
Fueron las palabras que iniciaron la "Gran Era de los Piratas".

El sueño de Luffy es convertirse en el Rey de los Piratas al encontrar el tesoro de Gol D. Roger conocido como One Piece. 
Para ello formó una tripulación, los Sombrero de Paja, con la cual comenzaron sus aventuras mar adentro. No pasó mucho tiempo antes de que la Marina pusiera precio sobre sus cabezas. 

De vez en cuando, la recompensa de un pirata puede aumentar a partir de ciertos eventos que la Marina y el Gobierno Mundial consideran importantes, por eso registramos cuál fue el
 impacto de distintos eventos sobre su recompensa, siendo la suma de todos esos montos la recompensa actual por su captura. También sabemos a qué tripulación pertenece cada pirata.

%BASE DE CONOCIMIENTOS
% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).

tripulante(law, heart).
tripulante(bepo, heart).

tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy, 
    arlongPark, 30000000).
impactoEnRecompensa(luffy,
    baroqueWorks, 70000000).
impactoEnRecompensa(luffy,
    eniesLobby, 200000000).
impactoEnRecompensa(luffy, 
    marineford, 100000000).
impactoEnRecompensa(luffy, 
    dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).

impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).

impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).

impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).

impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).

impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo,
     240000000).
impactoEnRecompensa(law, dressrosa, 60000000).

impactoEnRecompensa(bepo,sabaody,500).

impactoEnRecompensa(arlong, llegadaAEastBlue, 20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).


Consideraciones generales:
    Todos los predicados principales deben ser inversibles.
    Es importante no repetir lógica, desarrollar soluciones declarativas y con buenas abstracciones.

Desarrollar los predicados necesarios para resolver los siguientes requerimientos:

    1. Relacionar a dos tripulaciones y un evento si ambas participaron del mismo, lo cual sucede si dicho evento impactó en la recompensa de al menos un pirata de cada tripulación. Por ejemplo:

        - Debería cumplirse para las tripulaciones heart y sombreroDePaja siendo dressrosa el evento del cual participaron ambas tripulaciones.
        - No deberían haber dos tripulaciones que participen de llegadaAEastBlue, sólo los piratasDeArlong participaron de ese evento.

    2. Saber quién fue el pirata que más se destacó en un evento, en base al impacto que haya tenido su recompensa.
    En el caso del evento de dressrosa sería Zoro, porque su recompensa subió en $200.000.000.

    3. Saber si un pirata pasó desapercibido en un evento, que se cumple si su recompensa no se vio impactada por dicho evento a pesar de que su tripulación participó del mismo.
    Por ejemplo esto sería cierto para Bepo para el evento dressrosa, pero no para el evento sabaody por el cual su recompensa aumentó, ni para eniesLobby porque su tripulación no participó.

    4. Saber cuál es la recompensa total de una tripulación, que es la suma de las recompensas actuales de sus miembros.

    5. Saber si una tripulación es temible. Lo es si todos sus integrantes son peligrosos o si la recompensa total de la tripulación supera los $500.000.000. 
    Consideramos peligrosos a piratas cuya recompensa actual supere los $100.000.000.


Necesitamos agregar a nuestro programa un elemento fundamental: las frutas del diablo. 
Son unas valiosas frutas místicas que se encuentran dispersas en el mundo y pueden otorgar al consumidor interesantes habilidades en función de la fruta que se coma. 
La desventaja que dan todas las frutas a quienes las consuman es que no podrán nadar nunca más, lo cual es bastante problemático si pasás tu vida luchando arriba de un barco.

Las frutas del diablo se categorizan en tres tipos: paramecia, zoan y logia. Cada fruta a su vez tiene un nombre asociado, como se muestra en los datos que necesitamos representar 
más adelante, pero más allá de eso son muy distintas entre ellas. A continuación se detallan sus particularidades:

    Paramecia: da al consumidor un poder único que puede afectar tanto a su cuerpo, como a la manipulación del entorno. Como las habilidades que podrían otorgar a quienes coman 
    estas frutas son demasiado variadas, se debe indicar para cada fruta paramecia si es peligrosa o no.

    Zoan: permite al consumidor transformarse en una especie de animal que varía de una fruta a otra.
    Una fruta de tipo zoan se considera peligrosa si la especie en cuestión es feroz.
    Al día de hoy sabemos que las especies feroces que se pueden conseguir comiendo la fruta zoan adecuada son: lobo, leopardo y anaconda.
    Aclaración: Pueden haber varias frutas de este tipo con el mismo nombre, ya que se usa el mismo nombre para toda una familia de especies, no para una especie concreta, 
    con lo cual podría ser que una fruta zoan se considere peligrosa y otra no, a pesar de que se las llame de la misma forma.

    Logia: da a su consumidor la capacidad de transformarse en un elemento natural. Una de las ventajas de este poder es que el consumidor se vuelve prácticamente inmune a 
    ataques físicos, por eso todas las frutas de este tipo son peligrosas.

Sabemos que:

    Luffy comió la fruta gomugomu de tipo paramecia, que no se considera peligrosa.
    Buggy comió la fruta barabara de tipo paramecia, que no se considera peligrosa.
    Law comió la fruta opeope de tipo paramecia, que se considera peligrosa.
    Chopper comió una fruta hitohito de tipo zoan que lo convierte en humano.
    Nami, Zoro, Ussop, Sanji, Bepo, Arlong y Hatchan no comieron frutas del diablo.
    Lucci comió una fruta nekoneko de tipo zoan que lo convierte en leopardo.
    Smoker comió la fruta mokumoku de tipo logia que le permite transformarse en humo.




    6. 
        a. Necesitamos modificar la funcionalidad anterior, porque ahora hay otra forma en la cual una persona puede considerarse peligrosa: alguien que comió una fruta 
        peligrosa se considera peligroso, independientemente de cuál sea el precio sobre su cabeza.
    
        b. Justificar las decisiones de modelado tomadas para cumplir con lo pedido, tanto desde el punto de vista de la definición como del uso de los nuevos predicados.


    7. Saber si una tripulación es de piratas de asfalto, que se cumple si ninguno de sus miembros puede nadar.
*/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Práctica Integradora - One Piece
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Relaciona Pirata con Tripulacion
tripulante(luffy, sombreroDePaja).
tripulante(zoro, sombreroDePaja).
tripulante(nami, sombreroDePaja).
tripulante(ussop, sombreroDePaja).
tripulante(sanji, sombreroDePaja).
tripulante(chopper, sombreroDePaja).
tripulante(law, heart).
tripulante(bepo, heart).
tripulante(arlong, piratasDeArlong).
tripulante(hatchan, piratasDeArlong).

% Relaciona Pirata, Evento y Monto
impactoEnRecompensa(luffy, arlongPark, 30000000).
impactoEnRecompensa(luffy, baroqueWorks, 70000000).
impactoEnRecompensa(luffy, eniesLobby, 200000000).
impactoEnRecompensa(luffy, marineford, 100000000).
impactoEnRecompensa(luffy, dressrosa, 100000000).
impactoEnRecompensa(zoro, baroqueWorks, 60000000).
impactoEnRecompensa(zoro, eniesLobby, 60000000).
impactoEnRecompensa(zoro, dressrosa, 200000000).
impactoEnRecompensa(nami, eniesLobby, 16000000).
impactoEnRecompensa(nami, dressrosa, 50000000).
impactoEnRecompensa(ussop, eniesLobby, 30000000).
impactoEnRecompensa(ussop, dressrosa, 170000000).
impactoEnRecompensa(sanji, eniesLobby, 77000000).
impactoEnRecompensa(sanji, dressrosa, 100000000).
impactoEnRecompensa(chopper, eniesLobby, 50).
impactoEnRecompensa(chopper, dressrosa, 100).
impactoEnRecompensa(law, sabaody, 200000000).
impactoEnRecompensa(law, descorazonamientoMasivo, 240000000).
impactoEnRecompensa(law, dressrosa, 60000000).
impactoEnRecompensa(bepo, sabaody, 500).
impactoEnRecompensa(arlong, llegadaAEastBlue,20000000).
impactoEnRecompensa(hatchan, llegadaAEastBlue, 3000).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*
Consideraciones generales:
    Todos los predicados principales deben ser inversibles.
    Es importante no repetir lógica, desarrollar soluciones declarativas y con buenas abstracciones.

Desarrollar los predicados necesarios para resolver los siguientes requerimientos:
*/

%%%%%%%%%%%% PUNTO 1:%%%%%%%%%%%%%%%%

/*
    1. Relacionar a dos tripulaciones y un evento si ambas participaron del mismo, lo cual sucede si dicho evento impactó en la recompensa de al menos un pirata de cada tripulación. Por ejemplo:

        - Debería cumplirse para las tripulaciones heart y sombreroDePaja siendo dressrosa el evento del cual participaron ambas tripulaciones.
        - No deberían haber dos tripulaciones que participen de llegadaAEastBlue, sólo los piratasDeArlong participaron de ese evento.
*/


seCruzaronEn(Tripulacion1, Tripulacion2, Evento):-
    participoEnEvento(Tripulacion1, Evento),
    participoEnEvento(Tripulacion2, Evento),
    Tripulacion1 \= Tripulacion2.
  
participoEnEvento(Tripulacion, Evento):-
    tripulante(Pirata, Tripulacion),
    impactoEnRecompensa(Pirata, Evento, _).

%%%%%%%%%%%% PUNTO 2:%%%%%%%%%%%%%%%%

/*
    2. Saber quién fue el pirata que más se destacó en un evento, en base al impacto que haya tenido su recompensa.
    En el caso del evento de dressrosa sería Zoro, porque su recompensa subió en $200.000.000.
*/

/*
pirataQueMasSeDestaco(PirataDestacado, Evento):-
  impactoEnRecompensa(PirataDestacado, Evento, MontoMayor),
  not((impactoEnRecompensa(Pirata, Evento, Monto),
       Pirata \= PirataDestacado, Monto > MontoMayor)).
*/

% Otra forma usando forall:

pirataQueMasSeDestaco(PirataDestacado, Evento):-
    impactoEnRecompensa(PirataDestacado, Evento, MontoMayor),
    forall(
      (impactoEnRecompensa(Pirata, Evento, Monto), Pirata \= PirataDestacado), Monto =< MontoMayor).

%%%%%%%%%%%% PUNTO 3:%%%%%%%%%%%%%%%%

/*
    3. Saber si un pirata pasó desapercibido en un evento, que se cumple si su recompensa no se vio impactada por dicho evento a pesar de que su tripulación participó del mismo.
    Por ejemplo esto sería cierto para Bepo para el evento dressrosa, pero no para el evento sabaody por el cual su recompensa aumentó, ni para eniesLobby porque su tripulación no participó.
*/

pasoDesapercibido(Pirata, Evento):-
    tripulante(Pirata, Tripulacion),
    participoEnEvento(Tripulacion, Evento),
    not(impactoEnRecompensa(Pirata, Evento, _)).

/*%%%%%%%%%%%% PUNTO 4:%%%%%%%%%%%%%%%%

    4. Saber cuál es la recompensa total de una tripulación, que es la suma de las recompensas actuales de sus miembros.
*/

recompensaTotal(Tripulacion, RecompensaTotal):-
    tripulante(_, Tripulacion),
    findall(RecompensaPirata,
      (tripulante(Pirata, Tripulacion), recompensaActual(Pirata, RecompensaPirata)),
      Recompensas),
    sum_list(Recompensas, RecompensaTotal).
  
  recompensaActual(Pirata, RecompensaPirata):-
    tripulante(Pirata, _),
    findall(Recompensa, impactoEnRecompensa(Pirata, _, Recompensa), Recompensas),
    sum_list(Recompensas, RecompensaPirata).

/*%%%%%%%%%%%% PUNTO 5:%%%%%%%%%%%%%%%%

    5. Saber si una tripulación es temible. Lo es si todos sus integrantes son peligrosos o si la recompensa total de la tripulación supera los $500.000.000. 
    Consideramos peligrosos a piratas cuya recompensa actual supere los $100.000.000.
*/

esPeligroso(Pirata):-
    recompensaActual(Pirata, Recompensa),
    Recompensa > 100000000.

esTemible(Tripulacion):-
    tripulante(_, Tripulacion),
    forall(tripulante(Pirata, Tripulacion), esPeligroso(Pirata)).

esTemible(Tripulacion):-
    recompensaTotal(Tripulacion, RecompensaTotal),
    RecompensaTotal > 500000000.

%%%%%%%%%%%% PUNTO 6:%%%%%%%%%%%%%%%%
/*

6. 
        a. Necesitamos modificar la funcionalidad anterior, porque ahora hay otra forma en la cual una persona puede considerarse peligrosa: alguien que comió una fruta 
        peligrosa se considera peligroso, independientemente de cuál sea el precio sobre su cabeza.
    
        b. Justificar las decisiones de modelado tomadas para cumplir con lo pedido, tanto desde el punto de vista de la definición como del uso de los nuevos predicados.


*/
peligroso(Pirata):-
    comio(Pirata, Fruta),
    frutaPeligrosa(Fruta).

comio(luffy, paramecia(gomugomu)).
comio(buggy, paramecia(barabara)).
comio(law, paramecia(opeope)).
comio(chopper, zoan(hitohito, humano)).
comio(lucci, zoan(nekoneko, leopardo)).
comio(smoker, logia(mokumoku, humo)).

frutaPeligrosa(paramecia(opeope)).

frutaPeligrosa(zoan(_, Especie)):-
    especieFeroz(Espcie).

especieFeroz(lobo).
especieFeroz(leopardo).
especieFeroz(anaconda).

frutaPeligrosa(logia(_, _)).



/*
7. Saber si una tripulación es de piratas de asfalto, que se cumple si ninguno de sus miembros puede nadar.
*/

piratasDeAsfalto(Tripulacion):-
    tripulante(_, Tripulacion),
    not((tripulante(Pirata, Tripulacion), puedeNadar(Pirata))).
  
  puedeNadar(Persona):-
    tripulante(Persona, _),
    not(comioFruta(Persona, _)).