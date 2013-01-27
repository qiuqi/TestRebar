
-module(test_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
	TestServer = general_specs(s_test),
	Strategy = {one_for_one, 5, 100},
	Processes = [TestServer],
    {ok, { Strategy, lists:flatten(Processes)} }.

general_specs(Mod)->
	{Mod,
		{Mod, start_link, []},
		permanent, 25000, worker, dynamic}.

