-module(dummy_tests).
-include_lib("eunit/include/eunit.hrl").

unit_tests_() ->
    {setup,
    fun() ->
        ok
    end,
    fun(_) ->
        ok
    end,
    [
    ]
    }.