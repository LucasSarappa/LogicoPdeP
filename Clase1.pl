%% INTRO A LOGICO

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Introducción
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

humano(socrates).

mortal(Alguien):-
	humano(Alguien).
mortal(lassie).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Programadores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% programaEn/2 relaciona una persona con un lenguaje

programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).

%% colegas/2 relaciona dos personas si programan en un mismo lenguaje

colegas(Persona, Colega):-
  programaEn(Persona, Lenguaje),
	programaEn(Colega, Lenguaje),
	Persona \= Colega.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% La familia
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hije/2 Se cumple si la segunda persona es padre/madre de la primera
hije(herbert, abraham).
hije(homero, abraham).
hije(homero, mona).
hije(marge, clancy).
hije(marge, jacqueline).
hije(patty, clancy).
hije(patty, jacqueline).
hije(selma, clancy).
hije(selma, jacqueline).
hije(bart, homero).
hije(bart, marge).
hije(lisa, homero).
hije(lisa, marge).
hije(maggie, homero).
hije(maggie, marge).
hije(ling, selma).


% Para probar esto:
% hije(homero, Alguien) . esto me tiene que dar Alguien = homero (toco espacio) Alguien = marge.

% hermanes/2 se cumple si ambas personas son hijas de una persona en común.
hermanes(Persona1, Persona2):- % recibe 2 personas
	hije(Persona1, Padre), % Persona1 es hije de Padre
	hije(Persona2, Padre), % Persona2 es hije de Padre
	Persona2 \= Persona1. % Persona2 es distinto de Persona1, antireflexivo que seria que no se repita la misma persona

% Para probar esto:
% hermanes(bart, lisa) . esto me tiene que dar true
% hermanes(bart, bart) . esto me tiene que dar false por anti-reflexivo
% hermanes(bart, abraham) . esto me tiene que dar false
% hermanes (bart, Persona1) . esto me tiene que dar Persona1 = lisa y Persona1 = maggie (seguro se repite una pero no hay drama)

% descendiente/2 se cumple si la primera persona es descendiente de la segunda

descendiente(Descendiente, Persona):-
	hije(Descendiente, Persona).

descendiente(Descendiente, Persona):-
	hije(Descendiente, Alguien),
	descendiente(Alguien, Persona).


% Para probar el predicado descendiente/2
% descendiente(bart, abraham) . esto me tiene que dar true
% descendiente(bart, mona) . esto me tiene que dar true
