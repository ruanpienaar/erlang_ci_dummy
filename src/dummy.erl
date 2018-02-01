-module(dummy).

-export([
    start_link/0,
    create/2,
    read/1,
    update/2,
    delete/1
]).

-export([
    init/1
]).

start_link() ->
    proc_lib:start_link(?MODULE, init, []).

init([]) ->
    ets:new(?MODULE, [named_table, ordered_set]),
    proc_lib:init_ack(ok).

create(Key, Value) ->
    ets:insert(?MODULE, {Key, Value}).

read(Key) ->
    ets:lookup(?MODULE, Key).

update(Key, NewValue) ->
    case read(Key) of
        [] ->
            [];
        [_Obj] ->
            % true = delete(Key),
            create(Key, NewValue)
    end.


delete(Key) ->
    ets:delete(?MODULE, Key).