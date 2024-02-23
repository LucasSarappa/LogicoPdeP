/*

Viscosos pero Sabrosos

En la jungla tan imponente el león rey duerme ya... Y Timón y Pumba salieron a lastrar bichos.

Tenemos tres tipos de bichos, representados por functores: 
    las vaquitas de San Antonio (de quienes nos interesa un peso)
    las cucarachas (de quienes nos interesa un tamaño y un peso)
    las hormigas, que pesan siempre lo mismo. De los personajes también se conoce el peso, mediante hechos.

La base de conocimiento es la que sigue:

    %comio(Personaje, Bicho)
    comio(pumba, vaquitaSanAntonio(gervasia,3)).
    comio(pumba, hormiga(federica)).
    comio(pumba, hormiga(tuNoEresLaReina)).
    comio(pumba, cucaracha(ginger,15,6)).
    comio(pumba, cucaracha(erikElRojo,25,70)).
    comio(timon, vaquitaSanAntonio(romualda,4)).
    comio(timon, cucaracha(gimeno,12,8)).
    comio(timon, cucaracha(cucurucha,12,5)).
    comio(simba, vaquitaSanAntonio(remeditos,4)).
    comio(simba, hormiga(schwartzenegger)).
    comio(simba, hormiga(niato)).
    comio(simba, hormiga(lula)).
    pesoHormiga(2).
    %peso(Personaje, Peso)
    peso(pumba, 100).
    peso(timon, 50).
    peso(simba, 200).

1) A falta de pochoclos... Definir los predicados que permitan saber:

    a) Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.

        ?- jugosita(cucaracha(gimeno,12,8)).
        Yes

    b) Si un personaje es hormigofílico... (Comió al menos dos hormigas).

        ?- hormigofilico(X).
        X = pumba;
        X = simba.

    c) Si un personaje es cucarachofóbico (no comió cucarachas).

        ?- cucarachofobico(X).
        X = simba

    d) Conocer al conjunto de los picarones. Un personaje es picarón si comió una cucaracha jugosita ó si se come a Remeditos la vaquita. Además, pumba es picarón de por sí.
        
        ?- picarones(L).
        L = [pumba, timon, simba]

2) Pero yo quiero carne... Aparece en escena el malvado Scar, que persigue a algunos de nuestros amigos. Y a su vez, las hienas Shenzi y Banzai también se divierten...

    persigue(scar, timon).
    persigue(scar, pumba).
    persigue(shenzi, simba).
    persigue(shenzi, scar).
    persigue(banzai, timon)

Por ejemplo, un día había una hiena distraida y con mucho hambre y amplio su dieta

    comio(shenzi,hormiga(conCaraDeSimba)).

Completando la base...

    peso(scar, 300).
    peso(shenzi, 400).
    peso(banzai, 500).

a) Se quiere saber cuánto engorda un personaje (sabiendo que engorda una cantidad igual a la suma de los pesos de todos los bichos en su menú). Los bichos no engordan.

    ?- cuantoEngorda(Personaje, Peso).
    Personaje= pumba
    Peso = 83;
    Personaje= timon
    Peso = 17;
    Personaje= simba
    Peso = 10

b) Pero como indica la ley de la selva, cuando un personaje persigue a otro, se lo termina comiendo, y por lo tanto también engorda. Realizar una nueva version del predicado cuantoEngorda.

    ?- cuantoEngorda(scar,Peso).
    Peso = 150
    (es la suma de lo que pesan pumba y timon)
    ?- cuantoEngorda(shenzi,Peso).
    Peso = 502
    (es la suma del peso de scar y simba, mas 2 que pesa la hormiga)


c) Ahora se complica el asunto, porque en realidad cada animal antes de comerse a sus víctimas espera a que estas se alimenten. De esta manera, lo que engorda un animal no es sólo 
el peso original de sus víctimas, sino también hay que tener en cuenta lo que éstas comieron y por lo tanto engordaron. Hacer una última version del predicado.

    ?- cuantoEngorda(scar,Peso).
    Peso = 250
    (150, que era la suma de lo que pesan pumba y timon, más 83 que se come pumba y 17 que come timon )
    ?- cuantoEngorda(shenzi,Peso).
    Peso = 762
    (502 era la suma del peso de scar y simba, mas 2 de la hormiga. A eso se le suman los 250 de todo lo que engorda scar y 10 que engorda simba)


3) Buscando el rey... Sabiendo que todo animal adora a todo lo que no se lo come o no lo persigue, encontrar al rey. El rey es el animal a quien sólo hay un animal
que lo persigue y todos adoran. Si se agrega el hecho:

    persigue(scar, mufasa).
    ?- rey(R).
    R = mufasa.
    (sólo lo persigue scar y todos los adoran)

4) Explicar en dónde se usaron y cómo fueron de utilidad los siguientes conceptos:

a. Polimorfismo
b. Recursividad
c. Inversibilidad

*/ 

% comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)). % vaquitaSanAntonio( nombre, peso)
comio(pumba, hormiga(federica)). % hormiga(nombre) -> pesan siempre lo mismo
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)). % cucaracha(nombre, tamaño, peso)
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
comio(shenzi,hormiga(conCaraDeSimba)). % hiena

pesoHormiga(2).

% peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).
peso(scar, 300).
peso(shenzi, 400). % hiena
peso(banzai, 500). % hiena


%%%%%%%%%%%%%%%%%%
%%% Ejercicio1 %%%
%%%%%%%%%%%%%%%%%%

% A
/*Qué cucaracha es jugosita: ó sea, hay otra con su mismo tamaño pero ella es más gordita.*/

% jugosita (cucaracha(Nombre,Tam,Peso))

jugosita(cucaracha(Nombre,Tam,Peso)):-
    comio(_,cucaracha(Nombre,Tam,Peso)),
    not((comio(_,cucaracha(Nombre,Tam,Peso2)), Peso2 > Peso)).

%% Para probar: jugosita(cucaracha(gimeno,12,8)). me devuelve True

% B

/* Si un personaje es hormigofílico... (Comió al menos dos hormigas). */

% hormigofilico(Personaje).
hormigofilico(Personaje) :-
    peso(Personaje,_),
    findall(NombreHormiga , comio(Personaje,hormiga(NombreHormiga)) , Hormigas),
    length(Hormigas,Tamanio),
    Tamanio >= 2.


%% Para probar: hormigofilico(X). me devuelve pumba y simba
%% Para probar: hormigofilico(pumba). me devuelve True

% C

/* Si un personaje es cucarachofóbico (no comió cucarachas). */

% cucarachofobico(X).
cucarachofobico(Personaje) :-
    peso(Personaje,_),
    not(comio(Personaje,cucaracha(_,_,_))).

%% Para probar: cucarachofobico(X). me devuelve simba
%% Para probar: cucarachofobico(simba). me devuelve True

% D

/* Conocer al conjunto de los picarones. Un personaje es picarón si comió una cucaracha jugosita ó si se come a Remeditos la vaquita. Además, pumba es picarón de por sí. */

% picarones(Personaje).
picarones(Personaje) :-
    peso(Personaje,_),
    findall( Personaje , esPicaron(Personaje) ,Picarones),
    member(Personaje,Picarones).

esPicaron(Personaje) :-
    comio(Personaje,cucaracha(Nombre,Tam,Peso)),
    jugosita(cucaracha(Nombre,Tam,Peso)).

esPicaron(Personaje) :-
    comio(Personaje,vaquitaSanAntonio(remeditos,_)).

esPicaron(pumba).