/*
Potencial rebelde: https://docs.google.com/document/d/1ATHhGMtOSj5tFqF2dtGtuXwCqvXptLKCgukbphVPw44/edit
Otra solucion: https://github.com/mbeorlegui/PracticasLogico/tree/master/potencial-rebelde
Resolucion: 

Es el año 2220 en un lugar muy lejano al planeta Tierra. El líder supremo, de nombre impronunciable e imposible de escribir, gobierna su planeta a puño de hierro. Su población es mayormente mano de obra esclava que utiliza para fabricar gran cantidad de naves con las que planea dominar toda la galaxia. 

Para poder mantenerse en el poder destina una parte importante de sus recursos a monitorear a sus habitantes y detectar tanto crímenes como posibles focos de disidencia. Para esto cuenta con un programa hecho en Prolog que tiene información sobre todos y cada uno de los habitantes. Si bien parece contener millones y millones de líneas de código, nuestro objetivo va a ser reimplementar ciertas partes centrales del sistema para entender cómo funcionan y, en un futuro, lanzar una ofensiva para rescatar a toda la población.

Para un mayor control de los ciudadanos, los nombres en el planeta fueron reemplazados por un hash md5 de su nombre anterior. Hicimos un ataque de intermediario y logramos conseguir algunas fichas de los ciudadanos, que asumimos se utilizaron para generar la base de conocimientos del sistema:
 


Nombre: 912ec803b2ce49e4a541068d495ab570
Trabaja de ingeniera mecánica en la Universidad Tecnológica Intergaláctica. Le gusta el fuego y la destrucción. Es buena armando bombas y vive en la misma casa con 1f5364c58947e14f9afa445bdf1ba4d9 y 2e416649e6ca0a1cbf9a1210cf4ce234. A esa casa le suelen decir “La Severino”. No tiene historial criminal.



Nombre: 2e416649e6ca0a1cbf9a1210cf4ce234
Trabaja en la aviación militar. No parece tener gustos, pero se sabe que es bueno conduciendo autos. Su historial criminal es extenso: robo de aeronaves, fraude, tenencia de cafeína. 

Nombre: f55840c38474c1909ce742172a77a013
Trabaja en inteligencia militar. Vive en la Comisaría 48 y es el único que vive allí. Es muy bueno en tiro al blanco; ama los juegos de azar, el ajedrez y tambien el tiro al blanco. En su historial criminal se encuentra la falsificación de vacunas y fraude.

Nombre 42fc1cd45335ad42d603657e5d0f2682
(inventale su info)

¡Agregate vos!


La actividad política se encuentra fuertemente restringida, con lo que las agrupación que pretenden modificar el orden reinante debieron volverse clandestinas y son buscadas intensamente. Para llevar a cabo sus actividades utilizan pasadizos y túneles ocultos en las viviendas, utilizando nanotecnología para esconderse.
Por lo que vimos en su base de datos, de cada vivienda se conoce cómo es. A modo de de ejemplo:

Vivienda
La Severino
Descripción
Por lo que se investigó, tiene un cuarto secreto de 4 x 8, un pasadizo y 3 túneles secretos: uno de 8 metros de largo, uno de 5 metros de largo y uno de 1 metro de largo que parecía estar aún en construcción. 


Uno de nuestros objetivos es encontrar viviendas que sean utilizadas como guaridas de potenciales rebeliones, antes que lo hagan las fuerzas del régimen. Por nuestras estimaciones, se consideran viviendas con potencial rebelde si vive en ella algún posible disidente y su superficie destinada a actividad clandestinas supera 50 metros cuadrados, lo que se calcula sumando los metros de cada cuarto, calculados de la siguiente forma:
Para los cuartos secretos, que siempre se consideran rectangulares, la superficie cubierta
Para los túneles, el doble de su longitud, excepto cuando están en construcción, que no se consideran.
Los pasadizos siempre tienen un metro cuadrado de superficie

Se pide:
Modelar la base de conocimiento para incluir estos datos, agregar alguna persona y vivienda más.
Poder saber quiénes son posibles disidentes. Una persona se considera posible disidente si cumple todos estos requisitos:
Tener una habilidad en algo considerado terrorista sin tener un trabajo de índole militar.
No tener gustos registrados en sistema, tener más de 3, o que le guste aquello en lo que es bueno.
Tiene más de un registro en su historial criminal o vive junto con alguien que sí lo tiene.
Detectar si en una vivienda: 
No vive nadie 
Todos los que viven tienen al menos un gusto en común.
Encontrar todas las viviendas que tengan potencial rebelde. 
Mostrar ejemplos de consulta y respuesta.
Analizar la inversibilidad de los predicados, de manera de encontrar alguno de los realizados que sea totalmente inversible y otro que no. Justificar. 
Si en algún momento se agregara algún tipo nuevo de ambiente en las viviendas, por ejemplo bunkers donde se esconden secretos o entradas a cuevas donde se puede viajar en el tiempo 
¿Qué pasaría con la actual solución? 
¿Qué se podría hacerse si se quisiera contemplar su superficie para determinar la superficie total de la casa? Implementar una solución con una lógica simple
Justificar

*/


%%%%% HECHOS - HABITANTES %%%%%

% Una persona se considera posible disidente si cumple todos estos requisitos:
%   Tener una habilidad en algo considerado terrorista sin tener un trabajo de índole militar.
%   No tener gustos registrados en sistema, tener más de 3, o que le guste aquello en lo que es bueno.
%   Tiene más de un registro en su historial criminal o vive junto con alguien que sí lo tiene.

persona(ab570).
persona(ba429).
persona(ce234).
persona(a013).
persona(f2682).
persona(nadie). % Se llama 'nadie' y no tiene crímenes, trabajo, casa, gustos, o habilidades.
persona(yo).
persona(aaa666).
persona(marcos).

crimen(ce234, roboAeronaves).
crimen(ce234, fraude).
crimen(ce234, tenenciaCafeina).
crimen(a013, falsificacionVacunas).
crimen(a013, fraude).
crimen(f2682, fraude).
crimen(yo, tenenciaCafeina).
crimen(aaa666, tirarGasPimienta).
crimen(aaa666, tirarGasDeNuevo).

trabajo(ab570, uti).
trabajo(ce234, aviacionMilitar).
trabajo(a013, inteligenciaMilitar).
trabajo(f2682, unPastel).
trabajo(aaa666, unPastel).

viveEn(ab570, laSeverino).
viveEn(ba429, laSeverino).
viveEn(ce234, laSeverino).
viveEn(a013, comisaria48).
viveEn(f2682, cueva).
viveEn(yo, utnLugano).
viveEn(aaa666, cueva).
viveEn(marcos, cueva).

habilidad(ab570, armarBombas).
habilidad(ce234, conducirAutos).
habilidad(a013, tiroAlBlanco).
habilidad(f2682, conducirAutos).
habilidad(yo, usarAcensores).
habilidad(aaa666, tirarGasPimienta).
habilidad(marcos, explosionEnMercadoCentral).

gustos(ab570, [fuego, destruccion, armarBombas]).
gustos(a013, [juegosAzar, ajedrez, tiroAlBlanco]).
gustos(f2682, [comerPanqueques]).
gustos(yo, [dibujo]).
gustos(aaa666, [tirarGasPimienta]).
gustos(marcos, [caramelos,chocolate,dulceDeLeche,tornillos,bujias]).

%%%%% HECHOS - VIVIENDAS %%%%%

% vivienda(nombre, [zonas])
vivienda(laSeverino, [cuarto(4,8), pasadizo, tunel(8,f), tunel(5,f), tunel(1,c)]).
vivienda(comisaria48, [cuarto(7,7), tunel(14,f), tunel(27,f)]).
vivienda(cueva, [pasadizo, pasadizo, pasadizo, cuarto(2,2)]).
vivienda(utnMedrano, [pasadizo, pasadizo, pasadizo, cuarto(10,10)]).

%%%%% PREDICADOS %%%%%

% Por nuestras estimaciones, se consideran viviendas con potencial rebelde si vive en ella algún disidente y
% su superficie destinada a actividad clandestinas supera 50 metros cuadrados.

viviendaRebelde(Vivienda):-
    vivienda(Vivienda, _),
    superficie(Vivienda, S),
    S > 50,
    viveEn(Persona, Vivienda),
    disidente(Persona).

%% SUPERFICIE %% (suponemos que toda la superficie está destinada a actividades clandestinas 👀👀)
% Se calcula de la siguiente forma:
%   Para los cuartos secretos, que siempre se consideran rectangulares, la superficie cubierta
%   Para los túneles, el doble de su longitud, excepto cuando están en construcción, que no se consideran.
%   Los pasadizos siempre tienen un metro cuadrado de superficie
superficie(Vivienda, Superficie):-
    vivienda(Vivienda, Espacios),
    maplist(area, Espacios, AreasTotales),
    sumlist(AreasTotales, Superficie).
area(cuarto(X,Y),A):-
    A is X*Y.
area(tunel(X,f),A):- % finalizados
    A is X*2.
area(tunel(_,c),0). % en construcción
area(pasadizo,1).

%%% DISIDENTES %%%
% Poder saber quiénes son posibles disidentes. Una persona se considera posible disidente si cumple todos estos requisitos:
%   Tener una habilidad en algo considerado terrorista sin tener un trabajo de índole militar.
%   No tener gustos registrados en sistema, tener más de 3, o que le guste aquello en lo que es bueno.
%   Tiene más de un registro en su historial criminal o vive junto con alguien que sí lo tiene.

habilidadTerrorista(H):-
    member(H, [armarBombas, tirarGasPimienta, explosionEnMercadoCentral]).
trabajoMilitar(T):-
    member(T, [aviacionMilitar, inteligenciaMilitar]).

disidente(Persona):-
    persona(Persona),
    habilidad(Persona, H), habilidadTerrorista(H),
    not((
        trabajo(Persona, T),
        trabajoMilitar(T)
    )),
    condicionGustos(Persona),
    condicionCrimenes(Persona).

condicionGustos(Persona):-
    not(gustos(Persona,_)).
condicionGustos(Persona):-
    gustos(Persona, Gustos),
    length(Gustos, L), L>3.
condicionGustos(Persona):-
    gustos(Persona, Gustos),
    habilidad(Persona, Habilidad),
    member(Habilidad, Gustos).

criminal(Persona):- % más de 1 crimen
    crimen(Persona, A), crimen(Persona, B),
    A \= B.
condicionCrimenes(Persona):-
    viveEn(Persona, Casa),
    viveEn(Otro, Casa),
    criminal(Otro). % Otro puede ser Persona, o puede ser otro distinto. En ambos casos está bien.

%%%%% VIVIENDAS %%%%%
% Detectar si en una vivienda: 
% No vive nadie 
% Todos los que viven tienen al menos un gusto en común.

viviendaAbandonada(Vivienda):-
    vivienda(Vivienda, _),
    not(viveEn(_,Vivienda)).
viviendaConGustosEnComun(Vivienda):-
    vivienda(Vivienda,_),
    viveEn(Alguien, Vivienda),
    gustos(Alguien, Gustos),
    member(UnGusto, Gustos), % existe un gusto de alguien que vive en Vivienda
    forall(
        viveEn(Persona,Vivienda),
        (
            gustos(Persona, SusGustos),
            member(UnGusto, SusGustos) % que todos tienen
        )    
    ).
viviendaConGustosEnComun(Vivienda):-
    viviendaAbandonada(Vivienda). % técnicamente las viviendas abandonadas tienen que cumplir la condición de gustosEnComun

%%%%% PREGUNTAS FINALES %%%%%

%%%%%%%%%%%%%%%%%%%%
% Encontrar todas las viviendas que tengan potencial rebelde.

% ?- viviendaRebelde(X).
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% X = laSeverino ;
% false.

%%%%%%%%%%%%%%%%%%%%
% Mostrar ejemplos de consulta y respuesta.

% ?- superficie(Viv, Sup).
% Viv = laSeverino,
% Sup = 59 ;
% Viv = comisaria48,
% Sup = 131 ;
% Viv = cueva,
% Sup = 7 ;
% Viv = utnMedrano,
% Sup = 103.

% ?- superficie(X, 59).
% X = laSeverino ;
% false.

% ?- superficie(cueva, X).
% X = 7.

% ?- disidente(X).
% X = ab570 ; -> habilidad: armarBombas, gusto: armarBombas (coincide), vive en laSeverino con ce234 que tiene 3 crímenes.
% X = ab570 ;       trabaja en ingeniería mecánica que en este planeta no se considera militar
% X = ab570 ;
% X = ab570 ;
% X = ab570 ;
% X = ab570 ;
% X = aaa666 ; -> gusto: tirarGasPimienta, habilidad: tirarGasPimienta (coincide), tiene más de 1 registro criminal.
% X = aaa666 ;      trabaja en la universidad de pastelería que no es militar
% X = marcos ; -> habilidad: explosionEnMercadoCentral, tiene 5 gustos, vive en cueva con aaa666 que tiene 2 registros criminales.
% X = marcos ;      no tiene trabajo
% false.

% ?- disidente(a013).
% false.

% ?- trabajoMilitar(aviacionMilitar). 
% true .

% ?- viveEn(P, V).
% P = ab570,
% V = laSeverino ;
% P = ce234,
% V = laSeverino ;
% P = a013,
% V = comisaria48 ;
% P = f2682,
% V = cueva ;
% P = yo,
% V = utnLugano ;
% P = aaa666,
% V = cueva ;
% P = marcos,
% V = cueva.

% ?- viveEn(nadie, X).
% false. -> sin domicilio registado (universo cerrado)

% ?- viveEn(X,cueva).
% X = f2682 ;
% X = aaa666 ;
% X = marcos.

% ?- viviendaAbandonada(X).
% X = utnMedrano.

% ?- viviendaConGustosEnComun(X).
% X = comisaria48 ; -> vive uno solo (con 3 gustos, por eso aparece 3 veces)
% X = comisaria48 ;
% X = comisaria48 ;
% X = utnMedrano. -> no vive nadie

% ?- habilidadTerrorista(X).
% X = armarBombas ;
% X = tirarGasPimienta ;
% X = explosionEnMercadoCentral.

%%%%%%%%%%%%%%%%%%%%
% Analizar la inversibilidad de los predicados, de manera de encontrar alguno de los realizados que
% sea totalmente inversible y otro que no. Justificar. 

% Los mencionados en el punto anterior son todos totalmente inversibles.
% Un ejemplo de no inversible es "area", no es inversible porque no se instancian las variables que se pasan,
% o en algunos casos no lo es porque tiene un "is", que no es totalmente inversible.

%%%%%%%%%%%%%%%%%%%%
% Si en algún momento se agregara algún tipo nuevo de ambiente en las viviendas,
% por ejemplo bunkers donde se esconden secretos o entradas a cuevas donde se puede viajar en el tiempo...
% ¿Qué pasaría con la actual solución? 
% ¿Qué se podría hacer si se quisiera contemplar su superficie para determinar la
% superficie total de la casa? Implementar una solución con una lógica simple
% Justificar

% No sería ningún problema. Claramente la solución actual no funcionaría correctamente porque no contemplaría
% la existencia de bunkers o entradas a cuevas para viajar en el tiempo.
% De agregarse functores desconocidos a las definiciones de las viviendas, 'maplist' no podría aplicar 'area' a estos,
% lo que causaría un valor de 'falso' para el área de estas viviendas.

% Arreglar esto es muy simple: solo habría que (tras agregar los nuevos espacios a los hechos de las viviendas)
% agregar una entrada más del predicado 'area' que indique cómo calcular el área de estos nuevos espacios,
% y el problema estaría resuelto.
% Ejemplo: (esto debería ir junto con la definición de los otros hechos, pero lo pongo acá por comodidad)

% vivienda(cosaRara, [pasadizo, tunel(73,c), bunker(15,15), cuevaTemporal(11)]).
% area(bunker(LadoA, LadoB), S):-
%   S is LadoA * LadoB.
% area(cuevaTemporal(X),S):-
%   S is X*X.