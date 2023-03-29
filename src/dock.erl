%% dock
%%
%% MIT No Attribution  
%% Copyright 2023 David J Goehrig <dave@dloh.org>
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy 
%% of this software and associated documentation files (the "Software"), to 
%% deal in the Software without restriction, including without limitation the 
%% rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
%% sell copies of the Software, and to permit persons to whom the Software is 
%% furnished to do so.  
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
%% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
%% IN THE SOFTWARE.

-module(dock).
-author({ "David J. Goehrig", "dave@dloh.org" }).
-copyright(<<"© 2023 David J. Goehrig"/utf8>>).
-export([ images/0, containers/0, running/0, run/1, start/1, stop/1, commit/1, 
	tag/2, push/1, push/2, pull/1, pull/2, remove_image/1, remove_container/1 ]).


%% Get the list of current images
images() ->
	docker_get("/images/json").	


%% Get the list of containers
containers() ->
	docker_get("/containers/json?all=true").


%% Get the list of running containers
running() ->
	docker_get("/containers/json").

%% Run a new container from an image and config
run(Config) ->
	docker_post("/containers/create",Config).

%% Start a stopped container
start(Container) ->
	docker_post("/containers/" ++ Container ++ "/start").


%% Stop a running contianer
stop(Container) ->
	docker_post("/containers/" ++ Container ++ "/stop").

%% Commit a snapshot of a container
commit(_Container) ->
	[].

%% Tag an image of a container
tag(_Image,_Tag) ->
	[].

%% Push a tag to a repository
push(_Tag,_Repo) ->
	[].

push(_Tag )->
	[].

%% Pull an image from a repository
pull(Image,Tag) ->
	docker_post("/images/create?fromImage=" ++ Image ++ "&tag=" ++ Tag).

pull(Image) ->
	docker_post("/images/create?fromImage=" ++ Image ++ "&tag=latest").

%% Remove an image
remove_image(Image) ->
	docker_delete("/images/" ++ Image).	

%% Remove a container
remove_container(Container) ->
	docker_delete("/containers/" ++ Container).	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Privates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

docker_get(Path) ->
	{ ok, { _Status, _Headers,Body }} = httpc:request(get,{ "http://localhost:2375" ++ Path,[] }, [],[{body_format,binary}]),
	json:decode(Body).

docker_delete(Path) ->
	{ ok, { _Status, _Headers,Body }} = httpc:request(delete,{ "http://localhost:2375" ++ Path,[] }, [],[{body_format,binary}]),
	json:decode(Body).

docker_post(Path) ->
	{ ok, { _Status, _Headers,Body }} = httpc:request(post,{ "http://localhost:2375" ++ Path,[], "", ""}, [],[{body_format,binary}]),
	json:decode(Body).

docker_post(Path,Payload) -> 
	{ ok, { _Status, _Headers,Body }} = httpc:request(post,{ "http://localhost:2375" ++ Path,[], "application/json", Payload}, [],[{body_format,binary}]),
	json:decode(Body).

