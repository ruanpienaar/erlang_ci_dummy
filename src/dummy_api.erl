-module(dummy_api).

%% API
-export([
    create/2,
    read/1,
    update/2,
    delete/1
]).

create(Key, Value) ->
    dummy:create(Key, Value).

read(Id) ->
    dummy:read(Id).

update(Obj, NewObj) ->
    dummy:update(Obj, NewObj).

delete(Id) ->
    dummy:delete(Id).