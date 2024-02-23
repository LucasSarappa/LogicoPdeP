https://github.com/mgerezqa/paradigmaLogico/tree/main/parcialLogicoPokemonMG

%% BASE DE CONOCIMIENTO %%
%% Principio de Universo Cerrado %%

pokemon(squirtle, agua).
pokemon(wartortle, agua).
pokemon(blastoise, agua).
pokemon(charmander, fuego).
pokemon(charmeleon, fuego).
pokemon(charizard, fuego).
pokemon(charizard, volador).
pokemon(bulbasaur, planta).
pokemon(bulbasaur, veneno).
pokemon(ivysaur, planta).
pokemon(ivysaur, veneno).
pokemon(venusaur, planta).
pokemon(venusaur, veneno).
pokemon(moltres, fuego).
pokemon(mew, psiquico).
pokemon(mewtwo, psiquico).
pokemon(pikachu, electrico).

legendario(mew).
legendario(mewtwo).

superEfectivo(agua, fuego).
superEfectivo(fuego, planta).
superEfectivo(planta, agua).

ganaEnUnaBatalla(PokemonGanador, PokemonPerdedor) :-
  pokemon(PokemonGanador, TipoGanador),
  pokemon(PokemonPerdedor, TipoPerdedor),
  superEfectivo(TipoGanador, TipoPerdedor).

ganaEnUnaBatalla(PokemonLegendario, PokemonPerdedor) :-
  legendario(PokemonLegendario),
  pokemon(PokemonPerdedor, _).

%% evolucion(Pokemon, EnQuéNivel, EnQuéEvoluciona).
evolucion(bulbasaur, 16, ivysaur).
evolucion(ivysaur, 36, venusaur).
evolucion(charmander, 16, charmeleon).
evolucion(charmeleon, 36, charizard).
evolucion(squirtle, 16, wartortle).
evolucion(wartortle, 36, blastoise).

%% Un pokemon evoluciona rápido si evoluciona antes del nivel 20.
evolucionaRapido(Pokemon):-
  evolucion(Pokemon, Nivel, _),
  Nivel < 20.

equipo(ash, squirtle).
equipo(ash, bulbasaur).
equipo(ash, mew).

%% puedeCapturar/2 para saber si alguien puede capturar a un pokemon.
%% pikachu no se deja capturar.
puedeCapturar(Entrenador, PokemonAAtrapar) :-
  equipo(Entrenador, PokemonDelDuenio),
  ganaEnUnaBatalla(PokemonDelDuenio, PokemonAAtrapar),
  PokemonAAtrapar \= pikachu.