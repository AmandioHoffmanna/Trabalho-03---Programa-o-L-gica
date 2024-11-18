% Base de dados de livros
livro('1984', ficcao, [politica, distopia], 'Um romance distópico que explora os perigos do totalitarismo.').
livro('Sapiens', historia, [ciencia, evolucao], 'Um relato fascinante sobre a evolução da humanidade.').
livro('O Pequeno Príncipe', ficcao, [infantil, filosofia], 'Uma história cativante sobre amizade, amor e a essência da vida.').
livro('Mindset', autoajuda, [psicologia, sucesso], 'Um livro que ensina a importância de ter uma mentalidade de crescimento.').
livro('O Código Da Vinci', ficcao, [misterio, religiao], 'Um thriller emocionante que mistura religião, arte e história.').

% Predicado principal para iniciar o sistema
iniciar :-
    write('Bem-vindo ao sistema de recomendações de livros!'), nl,
    write('Escolha os gêneros que você gosta (digite os números separados por vírgulas):'), nl,
    write('1. Ficção'), nl,
    write('2. História'), nl,
    write('3. Autoajuda'), nl,
    read_line_to_string(user_input, GenerosSelecionadosStr),
    map_generos(GenerosSelecionadosStr, GenerosSelecionados),
    write('Escolha os tópicos de interesse (digite os números separados por vírgulas):'), nl,
    write('1. Política'), nl,
    write('2. Ciência'), nl,
    write('3. Filosofia'), nl,
    write('4. Psicologia'), nl,
    write('5. Mistério'), nl,
    read_line_to_string(user_input, InteressesSelecionadosStr),
    map_interesses(InteressesSelecionadosStr, InteressesSelecionados),
    encontrar_livros(GenerosSelecionados, InteressesSelecionados, Livros),
    exibir_recomendacoes(Livros).

% Mapeamento de gêneros
map_generos(Str, Generos) :-
    split_string(Str, ",", "", ListaStr),
    maplist(map_genero, ListaStr, Generos).

map_genero("1", ficcao).
map_genero("2", historia).
map_genero("3", autoajuda).

% Mapeamento de interesses
map_interesses(Str, Interesses) :-
    split_string(Str, ",", "", ListaStr),
    maplist(map_interesse, ListaStr, Interesses).

map_interesse("1", politica).
map_interesse("2", ciencia).
map_interesse("3", filosofia).
map_interesse("4", psicologia).
map_interesse("5", misterio).

% Encontrar livros com base nos gêneros e interesses
encontrar_livros(Generos, Interesses, Livros) :-
    findall(
        Titulo-Sinopse,
        (livro(Titulo, Genero, Topicos, Sinopse),
         member(Genero, Generos),
         member(Interesse, Interesses),
         member(Interesse, Topicos)),
        Livros).

% Exibir as recomendações
exibir_recomendacoes([]) :-
    write('Nenhum livro encontrado com as preferências selecionadas. Tente novamente.'), nl.

exibir_recomendacoes(Livros) :-
    write('Aqui estão as recomendações com base nas suas preferências:'), nl,
    listar_livros(Livros).

listar_livros([]).
listar_livros([Titulo-Sinopse | Resto]) :-
    write('- '), write(Titulo), nl,
    write('  Sinopse: '), write(Sinopse), nl, nl,
    listar_livros(Resto).
