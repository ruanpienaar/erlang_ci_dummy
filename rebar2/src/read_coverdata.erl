-module(read_coverdata).
-compile(export_all).

d() ->
    dec_cov_data("_build/test/cover/eunit.coverdata").

dec_cov_data(Filename) ->
    {ok,FPID} = file:open(Filename, [read, raw, binary]),
    loop(FPID, read_first_byte_length(FPID)).

loop(_FPID, eof) ->
    eof;
loop(_FPID, {error, R}) ->
    {error, R};
loop(FPID, {ok, {'$size', X}}) ->
    loop(FPID, file:read(FPID, X));
loop(FPID, {ok, Data}) ->
    io:format("~p~n", [binary_to_term(Data)]),
    loop(FPID, read_first_byte_length(FPID)).

read_first_byte_length(FPID) ->
     case first_byte_size_int(FPID) of
         FirstByteSize when is_integer(FirstByteSize) ->
             file:read(FPID, FirstByteSize);
         R ->
             R
     end.

first_byte_size_int(FPID) ->
    case file:read(FPID, 1) of
        {ok, FirstByteBinString} ->
            [Int] = io_lib:format("~w", binary_to_list(FirstByteBinString)),
            list_to_integer(Int);
        R ->
            R
    end.


% 18> {ok,FPID} = file:open("_build/test/cover/eunit.coverdata", [read, raw, binary]).
% {ok,{file_descriptor,prim_file,{#Port<0.2222>,21}}}
% 19> file:read(FPID, 1).
% {ok,<<"e">>}
% 20> file:read(FPID, 101).
% {ok,<<131,80,0,0,0,106,120,156,61,204,49,10,128,48,12,70,
%       225,130,46,94,198,31,244,38,14,174,165,...>>}
% 21> {ok,V} = v(-1).
% {ok,<<131,80,0,0,0,106,120,156,61,204,49,10,128,48,12,70,
%       225,130,46,94,198,31,244,38,14,174,165,...>>}
% 22> binary_to_term(V).
% {file,dummy_app,
%       "/Volumes/hd2/code/erlang_ci_dummy/rebar3/_build/test/lib/dummy/ebin/dummy_app.beam"}
% 23> file:read(FPID, 1).
% {ok,<<"?">>}
% 24> $?.
% 63
% 25> file:read(FPID, 63).
% {ok,<<131,80,0,0,0,75,120,156,203,96,74,97,224,76,41,205,
%       205,173,140,79,44,40,200,97,96,96,96,...>>}
% 26> {ok,V2} = v(-1).
% {ok,<<131,80,0,0,0,75,120,156,203,96,74,97,224,76,41,205,
%       205,173,140,79,44,40,200,97,96,96,96,...>>}
% 27> binary_to_term(V2).
% {dummy_app,[{dummy_app,start,2,1,1},{dummy_app,stop,1,1,1}]}
% 28> file:read(FPID, 1).
% {ok,<<"(">>}
% 29> $(.
% 40
% 30> file:read(FPID, 40).
% {ok,<<131,104,2,104,6,100,0,4,98,117,109,112,100,0,9,100,
%       117,109,109,121,95,97,112,112,100,0,5,...>>}
% 31> {ok,V3} = v(-1).
% {ok,<<131,104,2,104,6,100,0,4,98,117,109,112,100,0,9,100,
%       117,109,109,121,95,97,112,112,100,0,5,...>>}
% 32> binary_to_term(V3).
% {{bump,dummy_app,start,2,1,15},0}
% 33>