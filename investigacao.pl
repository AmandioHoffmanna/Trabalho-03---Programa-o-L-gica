% Base de dados de evidências, suspeitos e testemunhos
evidencia(impressao_digital, 'Encontrada no local do crime').
evidencia(motivo, 'Financeiro').
evidencia(arma_crime, 'Faca encontrada com as digitais do suspeito').

testemunho('Testemunha ocular', 'Viu José no local do crime').
testemunho('Relato de discussão', 'José foi visto discutindo com a vítima antes do crime').

suspeito('José', [impressao_digital, motivo], 'Suspeito principal devido a digitais no local do crime e motivo financeiro.').
suspeito('Ana', [motivo, testemunha], 'Suspeita devido a um possível envolvimento emocional com a vítima.').

% Predicados principais para iniciar a análise
iniciar :-
    write('Bem-vindo ao sistema de análise criminal!'), nl,
    write('Forneça informações sobre o caso para análise.'), nl,
    write('Selecione as evidências disponíveis (digite os números separados por vírgulas):'), nl,
    listar_evidencias,
    read_line_to_string(user_input, EvidenciasStr),
    map_evidencias(EvidenciasStr, EvidenciasSelecionadas),
    write('Selecione os testemunhos disponíveis (digite os números separados por vírgulas):'), nl,
    listar_testemunhos,
    read_line_to_string(user_input, TestemunhosStr),
    map_testemunhos(TestemunhosStr, TestemunhosSelecionados),
    analisar_caso(EvidenciasSelecionadas, TestemunhosSelecionados).

% Listar as evidências disponíveis
listar_evidencias :-
    findall(Indice-Evidencia, (evidencia(Indice, Evidencia), format('~w. ~w~n', [Indice, Evidencia])), _).

% Listar as testemunhas disponíveis
listar_testemunhos :-
    findall(Indice-Testemunho, (testemunho(Indice, Testemunho), format('~w. ~w~n', [Indice, Testemunho])), _).

% Mapeamento de evidências fornecidas pelo usuário
map_evidencias(EvidenciasStr, EvidenciasSelecionadas) :-
    split_string(EvidenciasStr, ",", " ", EvidenciasList),
    maplist(atom_string, EvidenciasAtom, EvidenciasList),
    findall(Evidencia, (member(EvidenciaAtom, EvidenciasAtom), evidencia(Evidencia, _)), EvidenciasSelecionadas).

% Mapeamento de testemunhos fornecidos pelo usuário
map_testemunhos(TestemunhosStr, TestemunhosSelecionados) :-
    split_string(TestemunhosStr, ",", " ", TestemunhosList),
    maplist(atom_string, TestemunhosAtom, TestemunhosList),
    findall(Testemunho, (member(TestemunhoAtom, TestemunhosAtom), testemunho(Testemunho, _)), TestemunhosSelecionados).

% Análise do caso com base nas evidências e testemunhos fornecidos
analisar_caso(EvidenciasSelecionadas, TestemunhosSelecionados) :-
    encontrar_suspeitos(EvidenciasSelecionadas, Suspeitos),
    apresentar_suspeitos(Suspeitos),
    sugerir_teorias(TestemunhosSelecionados).

% Encontrar suspeitos com base nas evidências
encontrar_suspeitos(Evidencias, Suspeitos) :-
    findall(Suspeito, (suspeito(Suspeito, Evidencias, _)), Suspeitos).

% Apresentar os suspeitos encontrados
apresentar_suspeitos([]) :-
    write('Nenhum suspeito encontrado com base nas evidências fornecidas.'), nl.
apresentar_suspeitos([Suspeito|Resto]) :-
    write('Suspeito encontrado: '), write(Suspeito), nl,
    apresentar_suspeitos(Resto).

% Sugerir teorias com base nos testemunhos fornecidos
sugerir_teorias([]).
sugerir_teorias([Testemunho|Resto]) :-
    teoria(Testemunho),
    write('Teoria sugerida: '), write(Testemunho), nl,
    sugerir_teorias(Resto).

% Exemplo de regras para identificar teorias de crime
teoria(crime_passional) :- 
    testemunho('Relato de discussão', _), 
    write('Possível teoria: Crime passional').

teoria(roubo) :- 
    testemunho('Faca encontrada com as digitais do suspeito', _), 
    write('Possível teoria: Roubo').

