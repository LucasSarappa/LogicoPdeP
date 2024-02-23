/*
Paradigmas de Programación - Parcial Lógico 02/09/2023 - Curso K2033
ÚLTIMO MOMENTO, los alumnos de paradigmas
de programación de los sábados a la tarde se
juegan la nota una vez más en el parcial de lógico.
Nos contactó Crónica TV para armar un programa
para administrar lo que sucede en el programa
“Hechos y Predicadistas” que conduce Anabela
Asquear.
Conocemos a los protagonistas y a sus talentos, que están dados de esta manera
(nos ahorraron trabajo):
protagonista(amigazo).
protagonista(zulemaLogato).
protagonista(hellMusic).
protagonista(ogiCuenco).
protagonista(elGigolo).
talento(amigazo, hablar(ceceoso)).
talento(amigazo, desmayarse).
talento(zulemaLogato, actuar).
talento(zulemaLogato, cantar(20, [teatro])).
talento(hellMusic, cantar(30, [deathMetal, rock])).
talento(hellMusic, hablar(ingles)).
talento(ogiCuenco, actuar).
1. Anabela puede entrevistar a sus protagonistas, una entrevista debe tener el
protagonista, el día de la semana y cuánta gente la vio. Modelar la siguiente
información:
○ Amigazo fue entrevistado el jueves y lo vieron 1.500, también el sábado y lo vieron
14.500.
○ Hell Music fue entrevistado el lunes y el martes, y lo vieron 200 y 70.000 personas
respectivamente.
○ Zulema Logato fue entrevistada únicamente el domingo, y la vieron 100.000
personas.
2. Saber qué protagonistas son talentos ocultos, esto ocurre cuando tienen
algún talento pero nunca fueron entrevistados.
3. También queremos saber si algún protagonista es multifacético. Esto pasa
cuando tiene dos o más talentos.
4. Hablemos de carisma, el carisma es una forma de medir el nivel de talento
de un protagonista, por cada talento se suma carisma, nos piden calcular el
carisma de un protagonista sabiendo que:
○ Cantar suma el nivel de canto si sabe un solo estilo, si sabe más de
uno, suma el doble.
○ Actuar suma siempre 35.
Paradigmas de Programación - Parcial Lógico 02/09/2023 - Curso K2033
○ Hablar suma 40 para cualquier talento de habla, y suma 25 extra si es
ceceoso (tener en cuenta que el valor base puede cambiar y ceceoso
siempre debe sumar 25 más que el base).
○ Desmayarse no suma nada.
5. El carisma no sirve de nada si no tenés fama, la fama es el valor que se
obtiene de ser entrevistado por Anabela. La fama es la suma de fama que de
cada entrevista:
○ Si fue entrevistado un día de semana la fama es: cantidad de personas
que lo vio * 0,1 * carisma del entrevistado.
○ Si fue entrevistado un día de fin de semana la fama es: cantidad de
personas que lo vio * 0,5 * carisma del entrevistado.
6. El canal decidió empezar un programa de talentos donde le enseñan un
nuevo talento a un protagonista y nos piden saber quién es el más apto para
aprender un nuevo talento. Dado un talento nuevo para aprender, queremos
saber quién tiene más carisma resultante, tener en cuenta que si la persona
ya sabe ese exacto talento, no suma carisma. Crear un predicado que nos
diga quién es el más apto. Requiere ser sólo inversible para el protagonista.
ej.: si el talento es cantar(20, [teatro]), zulemaLogato no suma carisma, pero
hellMusic sí, aunque ya sepa cantar.
7. Hay protagonistas que tienen bronca con otro, y hay protagonistas que se
perciben amigos de otros. Dados dos protagonistas, se pide saber si el
primero se la pudre al segundo. Esto se da cuando el primero tiene bronca
con el segundo, o cuando el primero tiene un amigo que se la pudre al
segundo.
ej.: martin se la pudre a amigazo, pero martin también se la pudre a mirtaLagrande
porque es amigo de ogiCuenco. También inia se la pudre a mirtaLagrande porque es
amigo de martin.
amigo(zulemaLogato, inia).
amigo(hellMusic, martin).
amigo(amigazo, cappe).
amigo(amigazo, edu).
amigo(inia, martin).
amigo(martin, ogiCuenco).
bronca(samid, viale).
bronca(martin, amigazo).
bronca(ogiCuenco, mirtaLagrande).
Notas:
● Todos los predicados principales deben ser completamente inversibles.
● No duplicar lógica.
● Ser expresivo.
● Si en algún punto la solución es “no hacer nada”, aclarar en un comentario por qué no hace
falta hacer nad
*/

protagonista(amigazo).
protagonista(zulemaLogato).
protagonista(hellMusic).
protagonista(ogiCuenco).
protagonista(elGigolo).

talento(amigazo, hablar(ceceoso)).
talento(amigazo, desmayarse).
talento(zulemaLogato, actuar).
talento(zulemaLogato, cantar(20, [teatro])).
talento(hellMusic, cantar(30, [deathMetal, rock])).
talento(hellMusic, hablar(ingles)).
talento(ogiCuenco, actuar).


% 1)

entrevista(amigazo, jueves, 1500).
entrevista(amigazo, sabado, 14500).
entrevista(hellMusic, lunes, 200).
entrevista(hellMusic, martes, 70000).
entrevista(zulemaLogato, domingo, 100000).

% 2)

talentoOculto(Protagonista):-
    talento(Protagonista, _),
    not(entrevista(Protagonista, _, _)).

% 3)

multifacetico(Protagonista):-
    talento(Protagonista, Talento),
    talento(Protagonista, OtroTalento),
    Talento \= OtroTalento.

% 4)

carisma(Protagonista, Carisma):-
    protagonista(Protagonista),
    findall(
        CarismaTalento,
        carismaPorTalento(Protagonista, CarismaTalento),
        CarismaTalentos
    ),
    sumlist(CarismaTalentos, Carisma).

carismaPorTalento(Protagonista, CarismaTalento):-
    talento(Protagonista, Talento),
    carismaTalento(Talento, CarismaTalento).

carismaTalento(hablar(Habla), CarismaBase):- 
    Habla \= ceceoso,
    carismaBaseParaHablar(CarismaBase).

carismaTalento(hablar(ceceoso), Carisma):- 
    carismaBaseParaHablar(CarismaBase),
    Carisma is 25 + CarismaBase.

carismaBaseParaHablar(40).

% Esta solución tiene el problema de que en el punto 6 si el talento a aprender
% es hablar(ceceoso) va a tener dos resultados posibles (40 y 25)
% carismaTalento(hablar(_), 40).
% carismaTalento(hablar(ceceoso), 25).

carismaTalento(actuar, 35).

% Se define ya que en el punto 6 se usa carismaTalento para determinar quien es el más apto
% y si el talento no tiene carisma, entonces es falso siempre. 
carismaTalento(desmayarse, 0).

carismaTalento(cantar(Nivel, Estilos), Carisma):-
    indicePorEstilos(Estilos, Indice),
    Carisma is Nivel * Indice.

indicePorEstilos(Estilos, 2):-
    length(Estilos, CantidadEstilos),
    CantidadEstilos > 1.

indicePorEstilos([_], 1).

% 5)

fama(Protagonista, Fama):-
    protagonista(Protagonista),
    findall(
        FamaEntrevista,
        famaEntrevista(Protagonista, FamaEntrevista),
        FamaEntrevistas
    ),
    sumlist(FamaEntrevistas, Fama).

famaEntrevista(Protagonista, FamaEntrevista):-
    entrevista(Protagonista, Dia, Viewers),
    coeficientePorDia(Dia, Coeficiente),
    carisma(Protagonista, Carisma),
    FamaEntrevista is Viewers * Carisma * Coeficiente.

coeficientePorDia(Dia, 0.5):-
    finde(Dia).

coeficientePorDia(Dia, 0.1):-
    diaDeSemana(Dia).

finde(sabado).
finde(domingo).
diaDeSemana(Dia):- dia(Dia), not(finde(Dia)).
dia(Dia):- member(Dia, [lunes, martes, miercoles, jueves, viernes, sabado, domingo]).

% 6)

elMasApto(Talento, Protagonista):-
    carismaAprendiendo(Protagonista, Talento, Carisma),
    forall(
        carismaAprendiendo(OtroProtagonista, Talento, OtroCarisma),
        Carisma >= OtroCarisma
    ).

carismaAprendiendo(Protagonista, Talento, Carisma):-
    carisma(Protagonista, Carisma),
    carismaPorAprender(Protagonista, Talento, CarismaExtra),
    Carisma is CarismaProtagonista + CarismaExtra.

carismaPorAprender(Protagonista, Talento, 0):-
    talento(Protagonista, Talento).

carismaPorAprender(Protagonista, Talento, CarismaTalento):-
    not(talento(Protagonista, Talento)),
    carismaTalento(Talento, CarismaTalento).

% 7)

amigo(zulemaLobato, inia).
amigo(hellMusic, martin).
amigo(amigazo, cappe).
amigo(amigazo, edu).
amigo(inia, martin).
amigo(martin, ogiCuenco).

bronca(samid, viale).
bronca(martin, amigazo).
bronca(ogiCuenco, mirtaLagrande).
bronca(inia, martin).

seLaPudre(Pudridor, Pudrido):-
    bronca(Pudridor, Pudrido).

seLaPudre(Pudridor, Pudrido):-
    amigo(Pudridor, Amigo),
    seLaPudre(Amigo, Pudrido).