% Base de dados de treinos
treino('Treino de Hipertrofia', 
       [supino_reto-3-12, agachamento_livre-4-10, desenvolvimento_militar-3-10, remada_curvada-3-12], 
       'Focado no ganho de massa muscular com exercícios compostos intensos.').
treino('Treino para Perda de Peso',
       [circuito-3-15, corrida-30-min, burpees-3-12, bicicleta-20-min],
       'Mistura de exercícios aeróbicos e de resistência para alta queima calórica.').
treino('Treino para Condicionamento',
       [flexoes-3-15, barra_fixa-3-8, abdominal-3-20, corrida-15-min],
       'Treino balanceado para melhorar força, resistência e condicionamento.').
treino('Treino para Iniciantes',
       [supino_maquina-3-15, leg_press-3-15, polia_lat-3-12, caminhada-15-min],
       'Plano de treino básico para iniciantes, com foco em adaptação muscular.').

% Predicados principais para iniciar o sistema
recomendar :-
    write('Bem-vindo ao sistema de recomendações de treino de academia!'), nl,
    write('Qual é o seu principal objetivo?'), nl,
    write('1. Ganhar massa muscular'), nl,
    write('2. Perder peso'), nl,
    write('3. Melhorar condicionamento físico'), nl,
    read_line_to_string(user_input, ObjetivoStr),
    map_objetivo(ObjetivoStr, Objetivo),
    write('Qual é o seu nível de experiência na academia?'), nl,
    write('1. Iniciante'), nl,
    write('2. Intermediário'), nl,
    write('3. Avançado'), nl,
    read_line_to_string(user_input, ExperienciaStr),
    map_experiencia(ExperienciaStr, Experiencia),
    write('Quanto tempo você tem disponível para treinar (em minutos, ex: 30): '), nl,
    read_line_to_string(user_input, TempoStr),
    atom_number(TempoStr, Tempo),
    encontrar_treino(Objetivo, Experiencia, Tempo, Treino, Detalhes),
    exibir_recomendacao(Treino, Detalhes).

% Mapeamento de objetivos
map_objetivo("1", ganhar_massa).
map_objetivo("2", perder_peso).
map_objetivo("3", condicionamento).

% Mapeamento de experiência
map_experiencia("1", iniciante).
map_experiencia("2", intermediario).
map_experiencia("3", avancado).

% Encontrar treino com base nos critérios
encontrar_treino(ganhar_massa, intermediario, _, 'Treino de Hipertrofia', Detalhes) :-
    treino('Treino de Hipertrofia', Detalhes, _).

encontrar_treino(perder_peso, _, Tempo, 'Treino para Perda de Peso', Detalhes) :-
    Tempo >= 20,
    treino('Treino para Perda de Peso', Detalhes, _).

encontrar_treino(condicionamento, _, _, 'Treino para Condicionamento', Detalhes) :-
    treino('Treino para Condicionamento', Detalhes, _).

encontrar_treino(_, iniciante, _, 'Treino para Iniciantes', Detalhes) :-
    treino('Treino para Iniciantes', Detalhes, _).

encontrar_treino(_, _, _, 'Nenhum treino encontrado', []).

% Exibir recomendação de treino
exibir_recomendacao('Nenhum treino encontrado', _) :-
    write('Desculpe, não encontramos um treino que atenda às suas preferências. Tente novamente.'), nl.

exibir_recomendacao(Treino, Detalhes) :-
    write('Recomendação de Treino: '), write(Treino), nl,
    write('Detalhes:'), nl,
    listar_exercicios(Detalhes).

% Listar exercícios detalhados
listar_exercicios([]).
listar_exercicios([Exercicio-Series-Reps | Resto]) :-
    write('- '), write(Exercicio), write(': '), write(Series), write(' séries de '), write(Reps), write(' repetições.'), nl,
    listar_exercicios(Resto).

% Caso especial para exercícios de tempo em minutos
listar_exercicios([Exercicio-Tempo | Resto]) :-
    number(Tempo),
    write('- '), write(Exercicio), write(': '), write(Tempo), write(' minutos.'), nl,
    listar_exercicios(Resto).
