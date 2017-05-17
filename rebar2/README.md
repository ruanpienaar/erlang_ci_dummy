steps i took to make this repo:

mkdir -p ~/.rebar
cd ~/code && git clone https://github.com/ruanpienaar/rebar_templates
cd rebar_templates && cp rebar2/* ~/.rebar
cd ~/code/erlang_ci_dummy
mkdir rebar2/ && cd rebar2/
rebar create template=library appid=dummy

Test running it:
make
./start-dev.sh
application:ensure_all_started(dummy).
^C^C

Tests:
./rebar eunit ct_run