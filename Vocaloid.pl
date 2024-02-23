
https://github.com/Chabelamas/Prolog/tree/main/4.Vocaliod
/*
VOCALOID:
Es un software de síntesis de voz en el que se animan a personajes, llamados vocaloids. Muy pronto habrán varios conciertos de esta temática a lo largo de varias 
ciudades del mundo, y para determinar información crítica de los cantantes nos pidieron una solución en Prolog para ayudar a los organizadores a elegir los vocaloids 
que participarán en cada concierto.

De cada vocaloid (o cantante) se conoce el nombre y además la canción que sabe cantar. De cada canción se conoce el nombre y la cantidad de minutos de duración.

Queremos reflejar entonces que:
    - megurineLuka sabe cantar la canción nightFever cuya duración es de 4 min y también canta la canción foreverYoung que dura 5 minutos.	
    - hatsuneMiku sabe cantar la canción tellYourWorld que dura 4 minutos.
    - gumi sabe cantar foreverYoung que dura 4 min y tellYourWorld que dura 5 min
    - seeU sabe cantar novemberRain con una duración de 6 min y nightFever con una duración de 5 min.
    - kaito no sabe cantar ninguna canción.

Tener en cuenta que puede haber canciones con el mismo nombre pero con diferentes duraciones.

	a) Generar la base de conocimientos inicial

Definir los siguientes predicados que sean totalmente inversibles, a menos que se indique lo contrario.

    1. Para comenzar el concierto, es preferible introducir primero a los cantantes más novedosos, por lo que necesitamos un predicado para saber si un vocaloid es novedoso 
    cuando saben al menos 2 canciones y el tiempo total que duran todas las canciones debería ser menor a 15.
        
    2. Hay algunos vocaloids que simplemente no quieren cantar canciones largas porque no les gusta, es por eso que se pide saber si un cantante es acelerado, condición que 
    se da cuando todas sus canciones duran 4 minutos o menos. Resolver sin usar forall/2.

Además de los vocaloids, conocemos información acerca de varios conciertos que se darán en un futuro no muy lejano. De cada concierto se sabe su nombre, el país donde se 
realizará, una cantidad de fama y el tipo de concierto.

Hay tres tipos de conciertos:
    - gigante del cual se sabe la cantidad mínima de canciones que el cantante tiene que saber y además la duración total de todas las canciones tiene que ser mayor a una cantidad dada.
    - mediano sólo pide que la duración total de las canciones del cantante sea menor a una 	cantidad determinada.
    - pequeño el único requisito es que alguna de las canciones dure más de una cantidad dada.




Queremos reflejar los siguientes conciertos:

    - Miku Expo, es un concierto gigante que se va a realizar en Estados Unidos, le brinda 2000 de fama al vocaloid que pueda participar en él y pide que el vocaloid sepa más de 2 canciones
     y el tiempo mínimo de 6 minutos.	
    - Magical Mirai, se realizará en Japón y también es gigante, pero da una fama de 3000 y pide saber más de 3 canciones por cantante con un tiempo total mínimo de 10 minutos. 
    - Vocalekt Visions, se realizará en Estados Unidos y es mediano brinda 1000 de fama y exige un tiempo máximo total de 9 minutos.	
    - Miku Fest, se hará en Argentina y es un concierto pequeño que solo da 100 de fama al vocaloid que participe en él, con la condición de que sepa una o más canciones de más de 4 minutos.


1) Modelar los conciertos y agregar en la base de conocimiento todo lo necesario.

2) Se requiere saber si un vocaloid puede participar en un concierto, esto se da cuando cumple los requisitos del tipo de concierto. También sabemos que Hatsune Miku puede participar 
en cualquier concierto.

3) Conocer el vocaloid más famoso, es decir con mayor nivel de fama. El nivel de fama de un vocaloid se calcula como la fama total que le dan los conciertos en los cuales puede participar 
multiplicado por la cantidad de canciones que sabe cantar.

4) Sabemos que:
    megurineLuka conoce a hatsuneMiku  y a gumi 
    gumi conoce a seeU
    seeU conoce a kaito

Queremos verificar si un vocaloid es el único que participa de un concierto, esto se cumple si ninguno de sus conocidos ya sea directo o indirectos (en cualquiera de los niveles) 
participa en el mismo concierto.

5) Supongamos que aparece un nuevo tipo de concierto y necesitamos tenerlo en cuenta en nuestra solución, explique los cambios que habría que realizar para que siga todo funcionando. 
¿Qué conceptos facilitaron dicha implementación?


*/


% CANTANTES

    %1)

    % Se modelan a las canciones como functores ya que de esta se conoce tanto el nombre como su duración, por lo tanto necesitamos representarlas usando un individuo 
    % compuesto que en este caso es un functor.

    %canta(nombreCancion, cancion)%
    canta(megurineLuka, cancion(nightFever, 4)).
    canta(megurineLuka, cancion(foreverYoung, 5)).
    canta(hatsuneMiku, cancion(tellYourWorld, 4)).
    canta(gumi, cancion(foreverYoung, 4)).
    canta(gumi, cancion(tellYourWorld, 5)).
    canta(seeU, cancion(novemberRain, 6)).
    canta(seeU, cancion(nightFever, 5)).


    % No se agrega a kaito a la base de conocimiento inicial ya que no sabe cantar ninguna canción por lo tanto no podemos relacionarlo con una canción.


    novedoso(Cantante) :- 
        sabeAlMenosDosCanciones(Cantante),
        tiempoTotalCanciones(Cantante, Tiempo),
        Tiempo < 15.
        
    sabeAlMenosDosCanciones(Cantante) :-
        canta(Cantante, UnaCancion),
        canta(Cantante, OtraCancion),
        UnaCancion \= OtraCancion.
        
    tiempoTotalCanciones(Cantante, TiempoTotal) :-
        findall(TiempoCancion, 
        tiempoDeCancion(Cantante, TiempoCancion), Tiempos), 
        sumlist(Tiempos,TiempoTotal).
        
    tiempoDeCancion(Cantante,TiempoCancion):-  
        canta(Cantante,Cancion),
        tiempo(Cancion,TiempoCancion).
        
    tiempo(cancion(_, Tiempo), Tiempo).
    


    % 2)

    acelerado(Cantante) :- 
        vocaloid(Cantante), 
        not((tiempoDeCancion(Cantante,Tiempo),Tiempo > 4)).
        
    vocaloid(Cantante):-
        canta(Cantante, _).
    
    % Si nos permitieran usar el forall/2 acá nos quedaría en vez del not/1:
    % forall(tiempoDeCancion(Cantante,Tiempo), Tiempo <= 4).
        
    % ”No canta una canción que dure más de 4 minutos” (not/1) es lo mismo que “Todas sus canciones duran 4 o menos minutos” (forall/2).

% CONCIERTOS

    % 1)

    % Se modelan los conciertos como functores. Hay 3 tipos distintos de conciertos que son: gigante/2, mediano/1 y diminuto/1.
    % Se agrega la base de conocimiento lo siguiente:

    %concierto(nombre, pais, fama, tipoConcierto)%
    concierto(mikuExpo, eeuu, 2000, gigante(2,6)).
    concierto(magicalMirai, japon, 3000, gigante(3,10)).
    concierto(vocalektVisions, eeuu, 1000, mediano(9)).
    concierto(mikuFest, argentina, 100, diminuto(4)).


% 2)


    puedeParticipar(hatsuneMiku,Concierto):-
        concierto(Concierto, _, _, _).

    puedeParticipar(Cantante, Concierto):-
        vocaloid(Cantante),
        Cantante \= hatsuneMiku,
        concierto(Concierto, _, _, Requisitos),
        cumpleRequisitos(Cantante, Requisitos).

    cumpleRequisitos(Cantante, gigante(CantCanciones, TiempoMinimo)):-
        cantidadCanciones(Cantante, Cantidad),
        Cantidad >= CantCanciones,
        tiempoTotalCanciones(Cantante, Total),
        Total > TiempoMinimo.

    cumpleRequisitos(Cantante, mediano(TiempoMaximo)):-
        tiempoTotalCanciones(Cantante, Total),
        Total < TiempoMaximo.

    cumpleRequisitos(Cantante, diminuto(TiempoMinimo)):-
        canta(Cantante, Cancion),
        tiempo(Cancion, Tiempo),
        Tiempo > TiempoMinimo.

    cantidadCanciones(Cantante, Cantidad) :- 
    findall(Cancion, canta(Cantante, Cancion), Canciones),
    length(Canciones, Cantidad).


% 3)
    masFamoso(Cantante) :-
        nivelFamoso(Cantante, NivelMasFamoso),
        forall(nivelFamoso(_, Nivel), NivelMasFamoso >= Nivel).

    nivelFamoso(Cantante, Nivel):- 
        famaTotal(Cantante, FamaTotal), 	
        cantidadCanciones(Cantante, Cantidad), 
        Nivel is FamaTotal * Cantidad.

    famaTotal(Cantante, FamaTotal):- 
        vocaloid(Cantante),
        findall(Fama, famaConcierto(Cantante, Fama),  
        CantidadesFama), 	
        sumlist(CantidadesFama, FamaTotal).

    famaConcierto(Cantante, Fama):-
        puedeParticipar(Cantante,Concierto),
        fama(Concierto, Fama).

    fama(Concierto,Fama):- 
        concierto(Concierto,_,Fama,_).


% 4)
    conoce(megurineLuka, hatsuneMiku).
    conoce(megurineLuka, gumi).
    conoce(gumi, seeU).
    conoce(seeU, kaito).

    unicoParticipanteEntreConocidos(Cantante,Concierto):- 
        puedeParticipar(Cantante, Concierto),
        not((conocido(Cantante, OtroCantante), 
        puedeParticipar(OtroCantante, Concierto))).

    %Conocido directo
    conocido(Cantante, OtroCantante) :- 
        conoce(Cantante, OtroCantante).

    %Conocido indirecto
    conocido(Cantante, OtroCantante) :- 
        conoce(Cantante, UnCantante), 
        conocido(UnCantante, OtroCantante).


% 5)

/*

En la solución planteada habría que agregar una claúsula en el predicado cumpleRequisitos/2  que tenga en cuenta el nuevo functor con sus respectivos requisitos 
El concepto que facilita los cambios para el nuevo requerimiento es el polimorfismo, que nos permite dar un tratamiento en particular a cada uno de los conciertos 
en la cabeza de la cláusula.

*/