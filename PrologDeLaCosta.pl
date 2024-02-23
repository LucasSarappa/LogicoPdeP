/*

Enunciado: https://docs.google.com/document/d/1SLYz4txoLYAE4b2jM_vc-U_1L2FMYg-p1zdxjKtVTU0/edit

Prolog de la Costa
“Un parque donde reina la lógica y el entretenimiento”



El modelo de negocio de Prolog de la Costa es sencillo. Cada visitante debe pagar una entrada, cuyo precio varía entre adultos y chicos (siendo los chicos aquellos que aún no cumplieron 13). Una vez dentro del parque, todas las atracciones son gratuitas, y se contempla que los visitantes utilicen su dinero en los puestos de comida disponibles. La oferta gastronómica es amplia: hay hamburguesas por $2000, panchitos con papas por $1500, lomitos completos por $2500 y también un puesto de caramelos donde se pueden agarrar sin costo.

Sin embargo, el componente principal no es la comida, sino las atracciones, y Prolog de la Costa ofrece una gran variedad de entretenimiento. Por un lado están las atracciones para toda la familia, denominadas atracciones tranquilas, que pueden ser para chicos y adultos o exclusivas para chicos. Para chicos y adultos contamos con atracciones como los icónicos autitos chocadores, la casa embrujada o el laberinto, mientras que los chicos pueden divertirse lanzándose por el tobogán o subiéndose a la calesita.

Otro tipo de atracciones disponibles son las intensas, reservadas para quienes quieran una experiencia un poco más potente. Para cada atracción intensa se tiene registrado un coeficiente de lanzamiento, utilizado para calcular cuántos empleados de limpieza deben mantenerse cerca de los alrededores de la atracción. El barco pirata tiene el coeficiente más alto de todos, en 14, mientras que otras atracciones son menos brutales, como las tazas chinas en 6 y el simulador 3D en 2.

Pero el plato fuerte de Prolog de la Costa está en las clásicas montañas rusas, que le han dado prestigio internacional al parque. La información disponible acerca de estas atracciones es más técnica; por ejemplo, la emblemática Abismo Mortal Recargada tiene 3 giros invertidos y una duración de 2:14, mientras que Paseo por el Bosque presenta una experiencia menos vertiginosa, sin giros invertidos y una duración de tan solo 45 segundos. Estos son sólo dos ejemplos, pero el parque cuenta con una gran cantidad de montañas rusas.

Finalmente, de septiembre a marzo se habilitan las atracciones acuáticas, como El Torpedo Salpicón o Espero Que Hayas Traído Una Muda de Ropa.

Para poder administrar el parque de la forma más eficiente posible, en Prolog de la Costa se conoce al detalle la información de cada visitante. Algunos datos son más superficiales, como su nombre, dinero, edad o a qué grupo familiar pertenecen, mientras que otros son propios del sentimiento de la persona, como su hambre y aburrimiento. Por ejemplo, el grupo familiar Viejitos vino temprano hoy al parque y son dos personas: Eusebio tiene 80 años, $3000, 50 de hambre y 0 de aburrimiento. Su mujer Carmela tiene la misma edad, no trajo plata, y no tiene hambre pero sí 25 de aburrimiento. Hay más grupos, como los López, una familia que vino con sus dos hijas, o Promoción 23, un grupo de egresados que vino al parque, entre otros.

Diseñar la base de conocimiento. Incluir los puestos de comida, las atracciones y a los visitantes del grupo Viejitos.


Saber el estado de bienestar de un visitante.
Si su hambre y aburrimiento son 0, siente felicidad plena.
Si suman entre 1 y 50, podría estar mejor.
Si suman entre 51 y 99, necesita entretenerse.
Si suma 100 o más, se quiere ir a casa.

Hay una excepción para los visitantes que vienen solos al parque: nunca pueden sentir felicidad plena, sino que podrían estar mejor también cuando su hambre y aburrimiento suman 0.

Saber si un grupo familiar puede satisfacer su hambre con cierta comida. Para que esto ocurra, cada integrante del grupo debe tener dinero suficiente como para comprarse esa comida y esa comida, a la vez, debe poder quitarle el hambre a cada persona. La hamburguesa satisface a quienes tienen menos de 50 de hambre; el panchito con papas sólo le quita el hambre a los chicos; y el lomito completo llena siempre a todo el mundo. Los caramelos son un caso particular: sólo satisfacen a las personas que no tienen dinero suficiente para pagar ninguna otra comida.


Saber si puede producirse una lluvia de hamburguesas. Esto ocurre para un visitante que puede pagar una hamburguesa y elige una atracción que:
Es intensa con un coeficiente de lanzamiento mayor a 10, o
Es una montaña rusa peligrosa, o
Es el tobogán

La peligrosidad de las montañas rusas depende de la edad del visitante. Para los adultos sólo es peligrosa la montaña rusa con mayor cantidad de giros invertidos en todo el parque, a menos que el visitante necesite entretenerse, en cuyo caso nada le parece peligroso. El criterio cambia para los chicos, donde independientemente de la cantidad de giros invertidos, los recorridos de más de un minuto de duración alcanzan para considerarla peligrosa.


Saber, para cada mes, las opciones de entretenimiento para un visitante. Esto debe incluir todos los puestos de comida en los cuales tiene dinero para comprar, todas las atracciones tranquilas a las que puede acceder (dependiendo su franja etaria), todas las atracciones intensas, todas las montañas rusas que no le sean peligrosas, y por último todas las atracciones acuáticas, siempre y cuando el mes de visita coincida con los meses de apertura.
Finalmente, una atracción tranquila exclusiva para chicos también puede ser opción de entretenimiento para un visitante adulto en el caso en que en el grupo familiar haya un chico a quien acompañar.
*/
puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelos, 0).

atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica()).
atraccion(elTorpedoSalpicon, acuatica()).

visitante(eusebio, 80, 3000, viejitos).
sentimiento(eusebio, 50, 0).
visitante(carmela, 80, 0, viejitos).
sentimiento(carmela, 0, 25).


% Saber el estado de bienestar de un visitante.
% Si su hambre y aburrimiento son 0, siente felicidad plena.
% Si suman entre 1 y 50, podría estar mejor.
% Si suman entre 51 y 99, necesita entretenerse.
% Si suma 100 o más, se quiere ir a casa.
% Hay una excepción para los visitantes que vienen solos al parque:
% nunca pueden sentir felicidad plena, sino que podrían estar mejor también
% cuando su hambre y aburrimiento suman 0.

estadoDeBienestar(Visitante, Bienestar) :-
  sentimiento(Visitante, Hambre, Aburrimiento),
  Suma is Hambre + Aburrimiento,
  estadoDeBienestarSegun(Suma, Bienestar, Visitante). % me olvidé de agregar el Visitante en esta línea en el video

estadoDeBienestarSegun(0, felicidadPlena, Visitante) :-
  estaAcompaniado(Visitante).

estadoDeBienestarSegun(0, podriaEstarMejor, Visitante) :-
  not(estaAcompaniado(Visitante)).

estadoDeBienestarSegun(Suma, podriaEstarMejor, _) :-
  Suma >= 1,
  Suma =< 50.

estadoDeBienestarSegun(Suma, necesitaEntretenerse, _) :-
  between(Suma, 51, 99).

estadoDeBienestarSegun(Suma, seQuiereIrACasa, _) :-
  Suma >= 100.
  
estaAcompaniado(Visitante) :-
  integranteDeGrupo(Visitante, Grupo),
  integranteDeGrupo(OtroVisitante, Grupo),
  Visitante \= OtroVisitante.

integranteDeGrupo(Visitante, Grupo) :-
  visitante(Visitante, _, _, Grupo).


% Punto 3

puedeSatisfacer(Comida, Grupo) :-
  grupo(Grupo),
  puestoDeComida(Comida, _),
  forall(visitante(Integrante, _, _, Grupo), poderComprarYSatisfacerse(Comida, Integrante)).

grupo(Grupo) :-
  visitante(_, _, _, Grupo). % aquí había dejado la variable Visitante (sin ligar), no es necesaria.

puedoComprarYSatisfacerse(Comida, Visitante) :-
  puedeComprar(Comida, Visitante),
  leSacaElHambre(Comida, Visitante).

puedeComprar(Comida, Visitante) :-
  visitante(Visitante, _, Dinero, _),
  puestoDeComida(Comida, Precio),
  Dinero >= Precio.

leSacaElHambre(hamburguesa, Visitante) :-
  visitante(Visitante, Hambre, _, _),
  Hambre =< 50.

leSacaElHambre(panchitoConPapas, Visitante) :-
  chico(Visitante).

leSacaElHambre(lomitoCompleto, _).

leSacaElHambre(caramelos, Visitante) :-
  not(puedePagarComida(Visitante)).

puedePagarComida(Visitante) :-
  puedeComprar(Comida, Visitante),
  Comida \= caramelos.

chico(Visitante) :-
  visitante(Visitante, Edad, _, _),
  Edad =< 13.

% Punto 4

lluviaDeHamburguesas(Visitante, Atraccion) :-
  puedeComprar(hamburguesa, Visitante),
  atraccion(Atraccion, TipoDeAtraccion),
  nauseasPorAtraccion(Visitante, Atraccion, TipoDeAtraccion).

nauseasPorAtraccion(_, _, intensa(Coeficiente)) :-
  Coeficiente >= 10.

nauseasPorAtraccion(_, tobogan, _).

nauseasPorAtraccion(Visitante, _, MontaniaRusa) :-
  esPeligrosaPara(Visitante, MontaniaRusa).

esPeligrosaPara(Visitante, montaniaRusa(MaximosGirosInvertidos, _)) :-
  adulto(Visitante),
  not(estadoDeBienestar(Visitante, necesitaEntretenerse)),
  forall(atraccion(_, montaniaRusa(GirosInvertidos, _)), GirosInvertidos =< MaximosGirosInvertidos).

esPeligrosaPara(Visitante, montaniaRusa(_, Duracion)) :- % aquí me olvidé de sacar el _ cuando rehice esta parte
  chico(Visitante),
  Duracion >= 60. % puse menor a 60 en el video :-(

adulto(Visitante) :-
  not(chico(Visitante)).


% Punto 5
opcionesDeEntretenimiento(Visitante, Opcion, _) :-
  puedeComprar(Opcion, Visitante).
  
opcionesDeEntretenimiento(Visitante, Opcion, _) :-
  atraccion(Opcion, AtraccionTranquila),
  atraccionTranquilaPara(Visitante, AtraccionTranquila).

atraccionTranquilaPara(Visitante, tranquila(_)) :-
  chico(Visitante).

atraccionTranquilaPara(_, tranquila(chicosYAdultos)). % en el video le puse atraccionTranquilaParaSuFranjaEtaria/2, no me di cuenta.

atraccionTranquilaPara(Visitante, tranquila(chicos)) :- % aquí igual.
  tieneChicoEnSuGrupoFamiliar(Visitante).

tieneChicoEnSuGrupoFamiliar(Visitante) :-  % no lo mencioné, pero puedo evitar fijarme que Visitante \= Chico
  integranteDeGrupo(Visitante, Grupo),     % porque si Visitante es adulto, entonces de todos modos da false chico(Chico);
  integranteDeGrupo(Chico, Grupo),         % y si Visitante es chico, de todos modos ya podía acceder a las atracciones de chicos
  chico(Chico).                            % por la cláusula de la línea 142, con lo que no cambia los resultados

opcionesDeEntretenimiento(_, Opcion, _) :-
  atraccion(Opcion, intensa(_)).

opcionesDeEntretenimiento(Visitante, Opcion, _) :-
  atraccion(Opcion, montaniaRusa(GirosInvertidos, Duracion)),
  not(esPeligrosaPara(Visitante, montaniaRusa(GirosInvertidos, Duracion))).

opcionesDeEntretenimiento(_, Opcion, Mes) :-
  atraccion(Opcion, acuatica()),
  mesDeApertura(Mes).

mesDeApertura(septiembre).
mesDeApertura(octubre).
mesDeApertura(noviembre).
mesDeApertura(diciembre).
mesDeApertura(enero).
mesDeApertura(febrero).
mesDeApertura(marzo).

% Comentario sobre el punto 5: al concentrarme solamente en los meses de apertura
% para las atracciones acuáticas, omití que el resto de las atracciones tienen que
% ser opciones válidas para *todos* los meses; y en la solución que dejé, ni siquiera
% *están* todos los meses! Por lo tanto, el predicado no es inversible para la variable Mes.
% (Ni siquiera genera los meses que sí están, porque sólo las acuáticas usan mesDeApertura/1).

% La forma de solucionar esto es que opcionesDeEntretenimiento/3 sea una única cláusula
% (o dos, quizá; una para los puestos de comida y otra para las atracciones) que genere
% todos los meses, probablemente aprovechando una lista meses/1 + member/2 como mostré en el video;
% y luego la lógica para cada atracción individual se delega a un nuevo predicado que sí sabe tratar
% a cada atracción según su tipo. Es decir, algo muy similar a como lluviaDeHamburguesas/2 es una
% única cláusula pero que delega en varias cláusulas de nauseasPorAtraccion/3.

% De hecho, más allá de lo del mes, sería buena idea delegar en predicados que traten a cada atracción
% por su tipo, porque hay un poco de repetición en las líneas 139, 156, 159 y 163; estoy haciendo
% atraccion(Opcion, ...) todas las veces para cada uno de los tipos de atracción.

% En todos los casos, la metodología es siempre la misma, como tambien mencioné en el video: extraigo lo
% que es general a todos los casos y delego lo que varía para evitar repetir lógica.
@LucasSarappa
Comment
