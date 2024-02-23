/*
RECUPERATORIO LOGICO 2021 VIDEOJUEGOS

ENUNCIADO: https://github.com/francoparente/PdP/blob/main/parciales_2021_parente/L%C3%B3gico/Recuperatorio%20L%C3%B3gico%20-%20Videojuegos.docx
RESOLUCION: https://github.com/francoparente/PdP/blob/main/parciales_2021_parente/L%C3%B3gico/Recu_Logico_Parente.pl

Nos adentramos en el maravilloso mundo de los videojuegos para cumplir los requerimientos (lógicos) de la industria, en su afán por recuperar el terreno perdido a manos de las redes sociales y sus atrapantes entretenimientos. Para lograrlo, nuestra base de conocimientos cuenta con los siguientes predicados, para los cuales disponemos información de ejemplo:
•	juego/2: que relaciona un juego con una plataforma en la cual puede jugarse.
•	usuarios/3: que relaciona un juego y una plataforma con la cantidad de usuarios que juegan ese juego en la plataforma indicada.
% juego(juego, plataforma soportada)
juego(minecraft, pc([windows,linux,mac])).
juego(minecraft, playstation(2)).
juego(minecraft, playstation(3)).
juego(superMario, xbox).
juego(superMario, xcube).
juego(saga(finalFantasy, 1), gameboy).
juego(saga(finalFantasy, 2), gameboy).
juego(saga(finalFantasy, 3), gameboy).
juego(saga(finalFantasy, 3), gameboyColor).
juego(saga(finalFantasy, 3), xbox).
juego(saga(sonic,1), genesis).
juego(saga(sonic,2), genesis).
juego(saga(sonic,3), genesis).	% usuarios(juego, plataforma, cantidad).
usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).
usuarios(saga(sonic, 1), genesis, 500).
usuarios(saga(sonic, 2), genesis, 800).
usuarios(saga(sonic, 3), genesis, 1400).
Las distintas plataformas a considerar para los juegos son las PCs para las cuales se indica también todos los sistemas operativos sobre los cuales puede correr ese juego, y diversas consolas de videojuegos como ser la xbox y los distintos modelos de playstation.
Sobre los juegos, algunos forman parte de una saga, por lo cual se registra no sólo su título, sino también un número secuencial que los identifica.
Se pide:
1.	Agregar la siguiente información a la base de conocimientos para poder utilizarla más adelante:
•	La psp es una plataforma portátil, y el gameboy y el gameboyColor también.
•	La empresa nintendo vende gameboy, xcube y xbox.
•	La empresa apple vende pc con sistema operativo mac, microsoft vende pc con sistema operativo windows y lenovo vende pc con windows y linux.
•	La empresa sony vende cualquier playstation.
Desarrollar los siguientes predicados, los cuales deben ser completamente inversibles:
2.	tienePlataformaQueSoporta/2: Relaciona a una empresa con un juego y se cumple si:
•	La empresa vende una consola (una plataforma que no es pc) sobre la cual puede correr ese juego.
•	La empresa vende pc con algún sistema operativo sobre el cual el juego puede correr.
Por ejemplo, para los datos que disponemos:
?- tienePlataformaQueSoporta(Empresa, minecraft).
Empresa = lenovo;
Empresa = microsoft;
Empresa = apple;
Empresa = sony
3.	propietario/2: Relaciona a una empresa con un juego si la misma es la  única que vende plataformas que lo soportan. En base a nuestro ejemplo, el Super Mario es propio de Nintendo, ya que sólo se puede jugar con Xbox y Xcube que son plataformas de Nintendo; mientras que el juego Minecraft corre en Playstation (de Sony) y PC con distintos sistemas operativos vendidos por otras empresas, por lo tanto, no se considera propietario.
4.	prefierenPortatiles/1: Se cumple cuando todos los usuarios de un determinado juego que está disponible para una plataforma no portátil, utilizan plataformas portátiles. Con nuestra base de conocimientos, el Final Fantasy 3 sería una respuesta posible, porque a pesar de estar disponible para Xbox (que no es portátil), sólo tiene usuarios para Gameboy y Gameboy color que sí son plataformas portátiles.
5.	nivelFanatismo/2: Relaciona un juego con su nivel de fanatismo, el cual se calcula como el total de usuarios de ese juego entre todas las plataformas dividido por 10000.
6.	esPirateable/1: Un juego es pirateable si tiene más de 5000 usuarios totales y corre sobre una plataforma hackeable. Sabemos que son hackeables la pc, la psp y las playstation anteriores a la playstation 3.
7.	
•	ultimoDeLaSaga/2: Relaciona el título de una saga, como ser finalFantasy, con el último juego de la misma, que en ese caso sería el juego: saga(finalFantasy, 3)
•	buenaSaga/1: se cumple para una saga de juegos si entre un juego y el siguiente se mantuvieron al menos la mitad de los usuarios totales entre todas las plataformas.
Por ejemplo, la saga finalFantasy fue buena porque el primer juego tuvo 400 usuarios, el segundo tuvo 220 (que es más de 200) y el tercero 170 (que es más de 110). Debe funcionar para sagas de cualquier cantidad de juegos.
*/

% PRIMER RECUPERATORIO LÓGICO - PARENTE

% juego(juego, plataforma soportada)

juego(minecraft, pc([windows,linux,mac])).
juego(minecraft, playstation(2)).
juego(minecraft, playstation(3)).
juego(superMario, xbox).
juego(superMario, xcube).
juego(saga(finalFantasy, 1), gameboy).
juego(saga(finalFantasy, 2), gameboy).
juego(saga(finalFantasy, 3), gameboy).
juego(saga(finalFantasy, 3), gameboyColor).
juego(saga(finalFantasy, 3), xbox).
juego(saga(sonic,1), genesis).
juego(saga(sonic,2), genesis).
juego(saga(sonic,3), genesis).

% usuarios(juego, plataforma, cantidad).

usuarios(minecraft,playstation(2), 40000).
usuarios(minecraft, playstation(3), 36700).
usuarios(saga(finalFantasy, 1), gameboy, 400).
usuarios(saga(finalFantasy, 2), gameboy, 220).
usuarios(superMario, xbox, 980).
usuarios(saga(finalFantasy, 3), gameboy, 70).
usuarios(saga(finalFantasy, 3), gameboyColor, 100).
usuarios(saga(sonic, 1), genesis, 500).
usuarios(saga(sonic, 2), genesis, 800).
usuarios(saga(sonic, 3), genesis, 1400).

% PUNTO 1

portatil(psp).
portatil(gameboy).
portatil(gameboyColor).

vende(nintendo, gameboy).
vende(nintendo, xcube).
vende(nintendo, xbox).

vende(apple, pc([mac])).
vende(microsoft, pc([windows])).
vende(lenovo, pc([windows,linux])).

vende(sony, playstation(_)).

hackeable(pc(_)).
hackeable(psp).
hackeable(playstation(X)) :-
    X < 3.

% PUNTO 2

incluido(A, B) :-
    forall(member(X, A), member(X, B)).

tienePlataformaQueSoporta(Empresa,Juego) :-
    vende(Empresa,Consola),
    juego(Juego,Consola).

tienePlataformaQueSoporta(Empresa,Juego) :-
    vende(Empresa,pc(SO1)),
    juego(Juego,pc(SO2)),
    incluido(SO1,SO2).

% PUNTO 3

propietario(Empresa,Juego) :-
    juego(Juego,Plataforma),
    vende(Empresa,Plataforma),
    not((vende(Empresa2,Plataforma), Empresa2 \= Empresa)).

% PUNTO 4

prefierenPortatiles(Juego) :-
    juego(Juego,Plataforma),
    not(portatil(Plataforma)),
    forall(usuarios(Juego,PlataformaPortatil,_), portatil(PlataformaPortatil)).

% PUNTO 5

nivelFanatismo(Juego,Nivel) :-
    findall(Cantidad ,usuarios(Juego,_,Cantidad), Cantidades),
    sumlist(Cantidades, NivelTotal),
    Nivel is NivelTotal / 1000.

% PUNTO 6

esPirateable(Juego) :-
    findall(Cantidad ,usuarios(Juego,_,Cantidad), Cantidades),
    sumlist(Cantidades, Total),
    Total > 5000,
    juego(Juego,Consola),
    hackeable(Consola).

% PUNTO 7

ultimoDeLaSaga(Titulo, saga(Titulo, Edicion)) :-
    juego(saga(Titulo, Edicion), _),
    forall(juego(saga(Titulo, OtraEdicion), _), OtraEdicion =< Edicion).    

% anterior(EdicionAnterior,EdicionSiguiente) :-
%     juego(saga(Titulo, EdicionAnterior),_),
%     juego(saga(Titulo, EdicionSiguiente),_),
%     EdicionAnterior \= EdicionSiguiente,
%     EdicionSiguiente > EdicionAnterior.

% Esto no sirve porque necesito el inmediatamente anterior.

% buenaSaga(saga(Titulo,Edicion)) :-
    
% Tengo que usar recursividad.