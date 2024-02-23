/*
Enunciado: https://github.com/Chabelamas/Prolog/blob/main/10.Aerolineas%20Prolog/Consigna.pdf

Aerolíneas Prolog

Los humanos han recorrido tierra y agua durante cientos de miles de años, pero hace apenas más de 100 que dominan los aires. Durante casi toda su existencia, la humanidad creyó
firmemente que no era lógico que los humanos pudieran volar. Sin embargo, aquí estamos: les presentamos Aerolíneas Prolog.

Como requisito para poder volar se requieren lugares desde donde despegar y aterrizar. Cada aeropuerto tiene un código de tres letras por el cual se lo identifica; por ejemplo, los
aeropuertos AEP y EZE están en Buenos Aires, Argentina; el aeropuerto GRU se encuentra en la ciudad de Sao Paulo, Brasil; y SCL es el aeropuerto de Santiago de Chile.

Cada ciudad, a su vez, se caracteriza por ser de uno de tres tipos: puede ser paradisíaca, de negocios, o de importancia cultural, en cuyo caso se conocen los lugares emblemáticos a
visitar. Palawan, de Filipinas, es una ciudad paradisíaca; Chicago, en Estados Unidos, es de negocios y París, Francia de importancia cultural, cuyos lugares emblemáticos son la torre
Eiffel, el Arco del Triunfo, el museo Louvre, y la catedral de Notre-Dame. Buenos Aires también es de importancia cultural y cuenta con el Obelisco, el Congreso y el Cabildo.

Naturalmente, para poder explotar la actividad comercial, se requieren aerolíneas. Hay mucha información sobre ellas, pero por el momento nos interesa qué rutas recorren con sus vuelos y
cuál es el costo de cada uno. Por ejemplo, Aerolíneas Prolog viaja de AEP a GRU por 75000 pesos y de GRU a SCL por 65000. Hay más aerolíneas, por supuesto, y muchas comparten
incluso las mismas rutas. Dependiendo los aeropuertos desde y hacia los que viaje, algunas aerolíneas son de cabotaje. Es el caso para las aerolíneas cuyos vuelos son siempre dentro
del mismo país. Por otra parte, algunas de las ciudades destino sólo tienen viaje de ida, porque ninguna aerolínea ofrece vuelos de regreso desde allí.

Como a nadie le gusta esperar mucho en el aeropuerto, estamos interesados en saber cuáles rutas son relativamente directas. Esto puede darse ya sea si el vuelo es directo o si se puede
llegar a él a través de una única escala, siempre a través de la misma aerolínea. Por ejemplo, Aerolineas Prolog ofrece una ruta relativamente directa de AEP a SCL, ya que se puede llegar
con una sola escala; también se consideran relativamente directas las rutas AEP-GRU y GRU-SCL.

Finalmente, se necesita gente interesada en ir de un lugar a otro. Las personas cuentan con dinero en pesos, con el que pueden comprar pasajes, y también con Millas Prolog, que pueden
canjear en cualquier aerolínea por vuelos gratis. Para saber si una persona puede viajar de una ciudad a otra, pueden pasar dos cosas: que tenga el dinero necesario para pagar un vuelo
entre aeropuertos de esas ciudades o que tenga suficientes Millas Prolog para realizar el viaje. Los vuelos entre aeropuertos del mismo país cuestan 500 millas, mientras que los vuelos
internacionales cuestan tantas millas como el 20% del costo del vuelo. Por ejemplo, mediante Aerolíneas Prolog, se puede volar de AEP a GRU canjeando 15000 millas.

Por otro lado, la persona puede o no querer viajar a una ciudad. Para querer viajar, la persona tiene que tener más de 5000 pesos y más de 100 millas y la ciudad debe ser paradisíaca o
tener al menos cuatro lugares emblemáticos si es de importancia cultural. Las tendencias actuales indican que hay una excepción, sin embargo: en este momento, todas las personas
quieren viajar a las ciudades de Qatar que son de negocios. Seguiremos investigando el motivo.

Finalmente, puede ocurrir que la persona tenga que ahorrar un poquito más. Esto se cumple únicamente para una ciudad por persona: una a la que quiere viajar y a la que aún no puede
pagar un vuelo desde su ciudad actual, pero que es la que más cerca está económicamente. Si la persona puede pagar todos los vuelos desde donde se encuentra, entonces no necesita
ahorrar un poquito más.

Por ahora, la única persona conocida es Eduardo, que tiene 750 millas, 50000 pesos y actualmente se encuentra en Buenos Aires.

    1. Diseñar la base de conocimiento y proveer ejemplos.
    2. Cumplir, mediante predicados completamente inversibles, con todos los requerimientos
    enunciados


*/




%% Resolucion:

%% BASE DE DATOS
% aeropuerto(Aeropuerto, Ciudad).
aeropuerto(aep, buenosAires).
aeropuerto(eze, buenosAires).
aeropuerto(gru, saoPablo).
aeropuerto(scl, santiagoDeChile).

% ciudad(Ciudad, Pais).
ciudad(buenosAires, argentina).
ciudad(saoPablo, brasil).
ciudad(santiagoDeChile, chile).
ciudad(palawan, filipinas).
ciudad(chicago, estadosUnidos).
ciudad(paris, francia).
ciudad(doha, qatar).

% paisAeropuerto(Aeropuerto, Pais).
paisAeropuerto(Aeropuerto, Pais):-    
    aeropuerto(Aeropuerto, Ciudad),
    ciudad(Ciudad, Pais).

% seCaracteriza(Ciudad, Tipo).
seCaracteriza(palawan, paradisiaca).
seCaracteriza(chicago, negocios).
seCaracteriza(paris,  importanciaCultural).
seCaracteriza(buenosAires, importanciaCultural).
seCaracteriza(Ciudad, negocios):-
    ciudad(Ciudad, qatar).

% lugaresEmblematicos(Ciudad, ListaLugares).
lugaresEmblematicos(paris, [torreEiffel, arcoDelTriunfo, museoLouvre, catedralDeNotreDame]).
lugaresEmblematicos(buenosAires, [obelisco, congreso, cabildo]).

% vuelo(aerolinea(Nombre, Partida, Llegada), Costo).
vuelo(aerolinea(aerolineasProlog, aep, gru), 75000).
vuelo(aerolinea(aerolineasProlog, gru, scl), 65000).

% persona(Cliente, Plata, Millas, CiudadInicio).
persona(eduardo, 5000, 750, buenosAires).


%% SABER SI UN VUELO ES DE CABOTAJE
% esDeCabotaje(aerolinea(Nombre, Partida, Llegada)).
esDeCabotaje(aerolinea(Nombre, Partida, Llegada)):-
    vuelo(aerolinea(Nombre, _, _), _),
    forall(vuelo(aerolinea(Nombre, Partida, Llegada), _), vueloEnElMismoPais(Partida, Llegada)).

% vueloEnElMismoPais(Partida, Llegada).
vueloEnElMismoPais(Partida, Llegada):-
    paisAeropuerto(Partida, Pais),
    paisAeropuerto(Llegada, Pais).

%% SABER SI UN VUELO ES SOLO DE IDA
% vueloSoloDeIda(Ciudad).
vueloSoloDeIda(Ciudad):-
    aeropuerto(Aeropuerto, Ciudad),
    vuelo(aerolinea(_, _, Aeropuerto), _),
    not(vuelo(aerolinea(_, Aeropuerto, _), _)).


%% SABER SI UN VUELO ES RELATIVAMENTE DIRECTO
% vueloRelativamenteDirecto(Inicio, Destino).
vueloRelativamenteDirecto(Inicio, Destino):-
    vuelo(aerolinea(_, Inicio, Destino), _).

vueloRelativamenteDirecto(Inicio, Destino):-
    vuelo(aerolinea(Nombre, Inicio, Escala), _),
    vuelo(aerolinea(Nombre, Escala, Destino),_).


%% SABER SI UN CLIENTE PUEDE VIAJAR
% puedeViajar(Cliente, CiudadDestino).
puedeViajar(Cliente, CiudadDestino):-
    persona(Cliente, _, _, CiudadInicio),
    viajeEntreCiudades(CiudadInicio, CiudadDestino, Vuelo),
    puedePagar(Cliente, Vuelo).

% viajeEntreCiudades(CiudadInicio, CiudadDestino, Vuelo).
viajeEntreCiudades(CiudadInicio, CiudadDestino, aerolinea(Nombre, AeropuertoInicio, AeropuertoDestino)):-
    aeropuerto(AeropuertoInicio, CiudadInicio),
    aeropuerto(AeropuertoDestino, CiudadDestino),
    vuelo(aerolinea(Nombre, AeropuertoInicio, AeropuertoDestino), _).

% puedePagar(Cliente, Vuelo).
puedePagar(Cliente, Vuelo):-
    vuelo(Vuelo, Costo),
    persona(Cliente, Plata, _, _),
    Plata >= Costo.

puedePagar(Cliente, Vuelo):-
    vuelo(Vuelo, Costo),
    persona(Cliente, _, Millas, _),
    valorViajeMillas(Vuelo, ValorMillas, Costo),
    ValorMillas =< Millas.

% valorViajeMillas(Vuelo, ValorMillas, Costo).
valorViajeMillas(aerolinea(_, Partida, Llegada), 500, _):-
    vueloEnElMismoPais(Partida, Llegada).

valorViajeMillas(aerolinea(_, Partida, Llegada), ValorMillas, Costo):-
    not(vueloEnElMismoPais(Partida, Llegada)),
    ValorMillas is (Costo * 0.2). 


%% SABER SI UN CLIENTE QUIERE VIAJAR A UN DESTINO
% quiereViajar(Cliente, CiudadDestino).
quiereViajar(Cliente, CiudadDestino):-
    persona(Cliente, Plata, Millas, _),
    Plata > 5000,
    Millas > 100,
    cumpleRequisitoCiudad(CiudadDestino). 

% cumpleRequisitoCiudad(CiudadDestino).
cumpleRequisitoCiudad(CiudadDestino):-
    seCaracteriza(CiudadDestino, paradisiaca).

cumpleRequisitoCiudad(Ciudad):-
    seCaracteriza(Ciudad, importanciaCultural),
    lugaresEmblematicos(Ciudad, LugaresEmblematicos),
    length(LugaresEmblematicos, Cantidad),
    Cantidad > 3.

cumpleRequisitoCiudad(Ciudad):-
    ciudad(Ciudad, qatar).


%% SABER SI UNA PERSONA TIENE QUE AHORRAR PARA VIAJAR AL DESTINO
% tieneQueAhorrar(Cliente, CiudadDestino).
tieneQueAhorrar(Cliente, CiudadDestino):-
    persona(Cliente, _, _, CiudadInicio),
    vueloMasBarato(CiudadInicio, CiudadDestino, Vuelo),
    puedePagar(Cliente, Vuelo).

% vueloMasBarato(CiudadInicio, CiudadDestino, Vuelo).
vueloMasBarato(CiudadInicio, CiudadDestino, Vuelo):-
    viajeEntreCiudades(CiudadInicio, CiudadDestino, Vuelo),
    vuelo(Vuelo, Costo),
    not((viajeEntreCiudades(CiudadInicio, CiudadDestino, OtroVuelo), 
        vuelo(OtroVuelo, OtroCosto), OtroCosto < Costo)).