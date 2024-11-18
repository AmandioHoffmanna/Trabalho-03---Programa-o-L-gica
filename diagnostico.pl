sintoma(febre).
sintoma(tosse).
sintoma(dor_de_garganta).
sintoma(dor_de_cabeca).
sintoma(dor_muscular).
sintoma(cansaco).

doenca(gripe, [febre, tosse, cansaco]).
doenca(infeccao_viral, [febre, dor_de_garganta, dor_muscular]).
doenca(enxaqueca, [dor_de_cabeca]).

diagnostico_indefinido :-
    write('Os sintomas não correspondem a uma condição conhecida. Consulte um médico para mais detalhes.').

perguntar([], []).
perguntar([Sintoma|Resto], [Sintoma|Respostas]) :-
    format('Você tem ~w? (s/n): ', [Sintoma]),
    read(Resposta),
    Resposta = s,
    perguntar(Resto, Respostas).
perguntar([_|Resto], Respostas) :-
    perguntar(Resto, Respostas).

diagnosticar(Sintomas) :-
    doenca(Doenca, Requisitos),
    subset(Requisitos, Sintomas),
    format('Você pode estar com ~w. Consulte um médico para confirmar.', [Doenca]),
    !.
diagnosticar(_) :-
    diagnostico_indefinido.

iniciar :-
    write('Bem-vindo ao sistema especialista de diagnóstico médico!'), nl,
    write('Por favor, responda às perguntas para que possamos ajudar você.'), nl,
    findall(S, sintoma(S), TodosSintomas),
    perguntar(TodosSintomas, SintomasRelatados),
    diagnosticar(SintomasRelatados).
