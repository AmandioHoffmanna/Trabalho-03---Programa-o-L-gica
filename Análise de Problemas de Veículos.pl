motor_nao_liga.
luzes_fracas.
barulho_ao_frear.
pedal_freio_macio.
vazamento_oleo.
cheiro_gasolina.

problema(bateria_fraca) :-
    member(motor_nao_liga, Sintomas),
    member(luzes_fracas, Sintomas).

problema(freio_desgastado) :-
    member(barulho_ao_frear, Sintomas),
    member(pedal_freio_macio, Sintomas).

problema(vazamento_oleo) :-
    member(vazamento_oleo, Sintomas).

problema(vazamento_combustivel) :-
    member(cheiro_gasolina, Sintomas).

diagnostico(bateria_fraca, 'Verifique a bateria e considere recarregar ou substituí-la.').
diagnostico(freio_desgastado, 'Inspecione os discos e pastilhas de freio. Leve a um mecânico se necessário.').
diagnostico(vazamento_oleo, 'Verifique o nível de óleo e procure a origem do vazamento. Leve a um mecânico.').
diagnostico(vazamento_combustivel, 'Verifique as conexões do sistema de combustível e conserte o mais rápido possível.').

conselho_seguranca('Leve o carro a um mecânico para evitar riscos de segurança.').

iniciar :-
    write('Selecione o número correspondente aos sintomas que o veículo apresenta:'), nl,
    write('1. Motor não liga'), nl,
    write('2. Luzes fracas'), nl,
    write('3. Barulho ao frear'), nl,
    write('4. Pedal de freio macio'), nl,
    write('5. Vazamento de óleo'), nl,
    write('6. Cheiro de gasolina'), nl,
    write('Digite os números separados por vírgulas (ex: "1,2"): '), nl,
    read_line_to_string(user_input, SintomasSelecionados),
    map_sintomas(SintomasSelecionados, SintomasList),
    encontrar_problema(SintomasList, Problema),
    (   Problema \= desconhecido
    ->  diagnostico(Problema, Solucao),
        write('Diagnóstico: '), write(Solucao), nl,
        conselho_seguranca(Conselho),
        write('Conselho: '), write(Conselho), nl
    ;   write('Não foi possível identificar o problema. Consulte um mecânico.'), nl
    ).

map_sintomas(SintomasSelecionados, SintomasList) :-
    split_string(SintomasSelecionados, ",", "", SintomasNumList),
    maplist(map_num_to_symptom, SintomasNumList, SintomasList).

map_num_to_symptom("1", motor_nao_liga).
map_num_to_symptom("2", luzes_fracas).
map_num_to_symptom("3", barulho_ao_frear).
map_num_to_symptom("4", pedal_freio_macio).
map_num_to_symptom("5", vazamento_oleo).
map_num_to_symptom("6", cheiro_gasolina).

encontrar_problema(Sintomas, Problema) :-
    (   member(motor_nao_liga, Sintomas),
        member(luzes_fracas, Sintomas)
    ->  Problema = bateria_fraca
    ;   member(barulho_ao_frear, Sintomas),
        member(pedal_freio_macio, Sintomas)
    ->  Problema = freio_desgastado
    ;   member(vazamento_oleo, Sintomas)
    ->  Problema = vazamento_oleo
    ;   member(cheiro_gasolina, Sintomas)
    ->  Problema = vazamento_combustivel
    ;   Problema = desconhecido
    ).
