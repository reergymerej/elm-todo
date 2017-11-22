# elm-todo

I want to learn Elm, so here we go.  Hello, world is lame.  Nowadays we make
todo apps.

## Notes

How does one start an Elm app?

[elm-reactor](https://guide.elm-lang.org/install.html#elm-reactor) seems to
start a server that allows you to compile stuff on the fly.  That's not quite
what we want.  My guess is we can use that for dev, but eventually we'll need to
build it to a JS file.

[elm-make](https://github.com/elm-lang/elm-make) is the real build tool.


Do we not need a basic html file to bootstrap/mount into?  :o  It looks like we
can just make the app with .elm and elm-make will spit out what we need.

Let's try this.  It looks like the convention is `Main.elm`.  Let's make that
and see if it can generate some HTML for us.

