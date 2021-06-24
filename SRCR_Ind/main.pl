:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- dynamic goal/1.

:- set_prolog_flag(toplevel_print_options,
    [quoted(true), portrayed(true), max_depth(0)]).
:- consult('circuitos.pl').


:- multifile (-)/1.


%--------------QUERY1---------------

geraCircuitos(Origem,Destino,Circuito):-
            profundidade(Origem,Destino,[Origem],Circuito).

profundidade(Destino, Destino, H, C):- inverso(H,C).

profundidade(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,Rua1,_,_,_,_,_,_),localrecolha(_,_,Proximo,_,Rua2,_,_,_,_,_,_)),
            \+ member(Proximo, His),
            profundidade(Proximo,Destino,[Proximo|His],C).

%--------------QUERY2---------------

%---lixos---

recolhaLixo(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Lixos',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Lixos',
            profundidade_lixos(Origem,Destino,[Origem],Circuito).

profundidade_lixos(Destino, Destino, H, C):- inverso(H,C).

profundidade_lixos(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Lixos',
            \+ member(Prox, His),
            profundidade_lixos(Prox,Destino,[Prox|His],C)

%---papalcartao---

recolhaPapelCartao(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Papel e Cartão',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Papel e Cartão',
            profundidade_papelcartao(Origem,Destino,[Origem],Circuito).

profundidade_papelcartao(Destino, Destino, H, C):- inverso(H,C).

profundidade_papelcartao(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Papel e Cartão',
            \+ member(Prox, His),
            profundidade_papelcartao(Prox,Destino,[Prox|His],C)

%---embalagens---

recolhaEmbalagens(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Embalagens',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Embalagens',
            profundidade_embalagens(Origem,Destino,[Origem],Circuito).

profundidade_embalagens(Destino, Destino, H, C):- inverso(H,C).

profundidade_embalagens(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Embalagens',
            \+ member(Prox, His),
            profundidade_embalagens(Prox,Destino,[Prox|His],C)

%---organico---

recolhaOrganico(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Organicos',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Organicos',
            profundidade_organico(Origem,Destino,[Origem],Circuito).

profundidade_organico(Destino, Destino, H, C):- inverso(H,C).

profundidade_organico(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Organicos',
            \+ member(Prox, His),
            profundidade_organico(Prox,Destino,[Prox|His],C)

%---vidro---

recolhaVidro(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Vidro',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Vidro',
            profundidade_vidro(Origem,Destino,[Origem],Circuito).

profundidade_vidro(Destino, Destino, H, C):- inverso(H,C).

profundidade_vidro(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Vidro',
            \+ member(Prox, His),
            profundidade_vidro(Prox,Destino,[Prox|His],C)

%--------------QUERY3---------------

maximoPontosRecolha(Origem, Destino,Circuito/Custo) :-
            assert(goal(Destino)),
            maximos_pontos([[Origem]/0], Destino, InvCircuito/Custo),
            retract(goal(Destino)),
            inverso(InvCircuito, Circuito).

maximos_pontos(Circuitos, Destino, Circuito) :-
            obtem_maximos_pontos(Ciruitos, Circuito),
            Circuito = [Nodo|_]/_,goal(Nodo).

maximos_pontos(Circuitos, Destino, SolucaoCircuito) :-
            obtem_maximos_pontos(Circuitos, MelhorCircuito),
            seleciona(MelhorCircuito, Circuitos, OutrosCircuitos),
            expande_informado_recolha(MelhorCircuito, Destino, ExpCircuitos),
            append(OutrosCircuitos, ExpCircuitos, NovoCircuitos),
            maximos_pontos(NovoCircuitos, Destino, SolucaoCircuito).

obtem_maximos_pontos([Circuito], Circuito) :- !.

obtem_maximos_pontos([Circuito1/Custo1,_/Custo2|Circuitos], MelhorCircuito) :-
            Custo1 >= Custo2, !,
            obtem_maximos_pontos([Circuito1/Custo1|Circuitos], MelhorCircuito).

obtem_maximos_pontos([_|Circuitos], MelhorCircuito) :-
            obtem_maximos_pontos(Circuitos, MelhorCircuito).

expande_informado_recolha(Circuito, Destino, ExpCircuitos) :-
            findall(NovoCircuito, proximaRecolha(Circuito, Destino, NovoCircuito), ExpCircuitos).

proximaRecolha([Nodo|Circuito]/Custo, Destino, [ProxNodo,Nodo|Circuito]/NovoCusto) :-
            adjacente(localrecolha(_,_,Nodo,_,_,_,_,_,_,_,_,_),localrecolha(_,_,ProxNodo,_,_,_,_,_,_,_,_,_)),
            localrecolha(_,_,Destino,_,_,_,_,_,_,_,_,_),
            \+ member(ProxNodo, Circuito),
            NovoCusto is Custo + 1.

%--------------QUERY4---------------

CircuitoMaisRapido(Origem, Destino,Circuito/Custo) :-
            assert(goal(Destino)),
            localrecolha(LatO,LonO,Origem,_,_,_,_,_,_,_,_),
            localrecolha(LatD,LonD,Destino,_,_,_,_,_,_,_,_),
            dist(LatO,LonO,LatD,LonD, Dist),
            mais_rapido([[Origem]/0/Dist], Destino, InvCircuito/Custo/_),
            retract(goal(Destino)),
            inverso(InvCircuito, Circuito).

mais_rapido(Circuitos, Destino, Circuito) :-
            obtem_mais_rapido(Circuitos, Circuito),
            Circuito = [Nodo|_]/_/_,goal(Nodo).

mais_rapido(Circuitos, Destino, SolucaoCircuito) :-
            obtem_mais_rapido(Circuitos, MelhorCircuito),
            seleciona(MelhorCircuito, Circuitos, OutrosCircuitos),
            expande_mais_rapido(MelhorCircuito, Destino, ExpCircuitos),
            append(OutrosCircuitos, ExpCircuitos, NovoCircuitos),
            mais_rapido(NovoCircuitos, Destino, SolucaoCircuito).

obtem_mais_rapido([Circuito], Circuito) :- !.

obtem_mais_rapido([Circuito1/Custo1/Dist1,_/Custo2/Dist2|Circuitos], MelhorCircuito) :-
            Dist1 =< Dist2, !,
            obtem_mais_rapido([Circuito1/Custo1/Dist1|Circuitos], MelhorCircuito).

obtem_mais_rapido([_|Circuitos], MelhorCircuito) :-
            obtem_mais_rapido(Circuitos, MelhorCircuito).

expande_mais_rapido(Circuito, Destino, ExpCircuitos) :-
            findall(NovoCircuito, proximoDist(Circuito, Destino, NovoCircuito), ExpCircuitos).

proximoDist([Nodo|Circuito]/Custo/_, Destino, [ProxNodo,Nodo|Circuito]/NovoCusto/Dist) :-
            adjacente(localrecolha(LatO,LonO,Nodo,_,_,_,_,_,_,_,_),localrecolha(Lat,Lon,ProxNodo,_,_,_,_,_,_,_,_)),
            localrecolha(LatF,LonF,Destino,_,_,_,_,_,_,_,_),
            \+ member(ProxNodo, Circuito),
            dist(LatO,LonO,Lat,Lon,D),
            NovoCusto is Custo + D,
            dist(Lat,Lon,LatF,LonF,Dist).

dist(LatO,LonO,LatD,LonD,Dist):-
            Sqrt is (LatD-LatO)^2 + (LonD-LonO)^2,
            Dist is sqrt(Sqrt).

%--------------QUERY5---------------

circuitoOrganico(Origem,Destino,Circuito):-
            localrecolha(_,_,Origem,_,_,_,Residuo1,_,_,_,_),
            Residuo1 = 'Organicos',
            localrecolha(_,_,Destino,_,_,_,Residuo2,_,_,_,_),
            Residuo2 = 'Organicos',
            profundidade_organico(Origem,Destino,[Origem],Circuito).

profundidade_organico(Destino, Destino, H, C):- inverso(H,C).

profundidade_organico(Origem, Destino, His, C):-
            adjacente(localrecolha(_,_,Origem,_,_,_,R1,_,_,_,_),localrecolha(_,_,Prox,_,_,_,R2,_,_,_,_)),
            R2 = 'Organicos',
            \+ member(Prox, His),
            profundidade_organico(Prox,Destino,[Prox|His],C)

%--------------PREDICADOS_AUXILIARES---------------

inverso(Xs, Ys):-
    inverso(Xs, [], Ys).

inverso([], Xs, Xs).
inverso([X|Xs],Ys, Zs):-
    inverso(Xs, [X|Ys], Zs).

seleciona(E, [E|Xs], Xs).
seleciona(E, [X|Xs], [X|Ys]) :- seleciona(E, Xs, Ys).