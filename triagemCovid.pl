:- dynamic formulario/3.

formulario :- carrega('./formulario.bd'),
    format('~n*** Formulario de Triagem ***~n~n'),
    repeat,
    nome(Paciente),
    temperatura(Paciente),
    frequenciaCardiaca(Paciente),
    frequenciaRespiratoria(Paciente),
    pressaoArterial(Paciente),
    saturacao(Paciente),
    dispineia(Paciente),
    idade(Paciente),
    comorbidade(Paciente),
    responde(Paciente),
    salva(formulario,'./formulario.bd').

carrega(Arquivo) :-
    exists_file(Arquivo),
    consulta(Arquivo)
    ;
    true.

%===== Perguntas ======= %
nome(Paciente) :-
    format('~nQual o nome do paciente? '),
    gets(Paciente).

temperatura(Paciente) :-
    format('~nQual a temperatura? '),
    gets(Temp),
    asserta(formulario(Paciente,temperatura,Temp)).

frequenciaCardiaca(Paciente) :-
    format('nQual a frequência cardíaca? '),
    gets(FreCard),
    asserta(formulario(Paciente,frequenciaCardiaca,FreCard)).

frequenciaRespiratoria(Paciente) :-
    format('~nQual a frequência respiratória? '),
    gets(FreResp),
    asserta(formulario(Paciente,frequenciaRespiratoria,FreResp)).

pressaoArterial(Paciente) :-
    format('~nQual o pressao arterial sistólica? '),
    gets(PreSis),
    asserta(formulario(Paciente,pressaoArterial,PreSis)).

saturacao(Paciente) :-
    format('~nnQual a saturação do oxigênio? (Sa02) : '),
    gets(SaO2),
    asserta(formulario(Paciente,saturacao,SaO2)).

dispineia(Paciente) :-
    format('~nTem dispnéia? (sim ou não) : '),
    gets(Dispn),
    asserta(formulario(Paciente,dispineia,Dispn)).

idade(Paciente) :-
    format('~nQual a Idade? '),
    gets(Idade),
    asserta(formulario(Paciente,idade,Idade)).

comorbidade(Paciente) :-
    format('~nPossui comorbidades? '),
    format('~nSe sim digite a quantidade, se não digite 0 : '),
    gets(Como),
    asserta(formulario(Paciente,comorbidade,Como)).

salva(P,A) :-
    tell(A),
    listing(P),
    told.

gets(String) :-
    read_line_to_codes(user_input,Char),
    name(String,Char).

responde(Paciente) :-
    condicao(Paciente, Char),
    !,
    format('A condição de ~w é ~w.~n',[Paciente,Char]).


%----------- Condicoes -----------

%======Gravissimo======
condicao(Pct, gravissimo) :-
    formulario(Pct,frequenciaRespiratoria,Valor), Valor > 30;
    formulario(Pct,pressaoArterial,Valor), Valor < 90;
    formulario(Pct,saturacao,Valor), Valor < 95;
    formulario(Pct,dispineia,Valor), Valor = "sim".

%========Grave========
condicao(Pct, grave) :-
    formulario(Pct,temperatura,Valor), Valor > 39;
    formulario(Pct,pressaoArterial,Valor), Valor >= 90, Valor =< 100;
    formulario(Pct,idade,Valor), Valor >= 80;
    formulario(Pct,comorbidade,Valor), Valor >= 2.

%=====Medio======
condicao(Pct, medio) :-
    formulario(Pct,temperatura,Valor), (Valor < 35; (Valor > 37, Valor =< 39));
    formulario(Pct,frequenciaCardiaca,Valor), Valor >= 100;
    formulario(Pct,frequenciaRespiratoria,Valor), Valor >= 19, Valor =< 30;
    formulario(Pct,idade,Valor), Valor >= 60, Valor =< 79;
    formulario(Pct,comorbidade,Valor), Valor = 1.


%=======Leve========
condicao(Pct, leve) :-
    formulario(Pct,temperatura,Valor), Valor >= 35, Valor =< 37;
    formulario(Pct,frequenciaCardiaca,Valor), Valor < 100;
    formulario(Pct,frequenciaRespiratoria,Valor), Valor =< 18;
    formulario(Pct,pressaoArterial,Valor), Valor > 100;
    formulario(Pct,saturacao,Valor), Valor >= 95;
    formulario(Pct,dispineia,Valor), Valor = "n�o";
    formulario(Pct,idade,Valor), Valor < 60;
    formulario(Pct,comorbidade,Valor), Valor = 0.
