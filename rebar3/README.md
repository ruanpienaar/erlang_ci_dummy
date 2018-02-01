steps i took to make this repo:

mkdir -p ~/.config/rebar3/templates
cd ~/code && git clone https://github.com/ruanpienaar/rebar_templates
cd rebar_templates/ && cp rebar3/*  ~/.config/rebar3/templates
cd ~/code/erlang_ci_dummy
mkdir rebar3/ && cd rebar3/
rebar3 new -f library appid=dummy

Test running it:
make
./start-dev.sh
application:ensure_all_started(dummy).
^C^C

Tests:
./rebar3 eunit ct_run