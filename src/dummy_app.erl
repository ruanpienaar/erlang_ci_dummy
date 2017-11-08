-module(dummy_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include("dummy.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    dummy_sup:start_link().

stop(_State) ->
    ok.
