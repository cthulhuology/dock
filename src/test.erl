-module(test).

-export([ test/0 ]).

test() ->
	inets:start(),
	dock:containers().
