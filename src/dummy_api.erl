-module(dummy_api).

%% API
-export([
    create/1,
    read/1,
    update/2,
    delete/1
]).

create(Obj) ->
    dummy:create(Obj).

read(Id) ->
    dummy:read(Id).

update(Obj, NewObj) ->
    dummy:update(Obj, NewObj).

delete(Id) ->
    dummy:delete(Id).