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

some_test_function(test) ->
    ok;
some_test_function(no_test) ->
    no_test.