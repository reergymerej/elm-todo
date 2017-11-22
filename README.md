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

ref:git:6e1614a

At this stage, the app works through `elm-reactor`.

Can I build it as an html file?

`elm-make Main.elm --output=main.html`

That indeed built an html file with embedded JS that does the same thing.  I can
see now the infamous enormous JS.  :)  It's not minified or uglified, though.

Technically, this is a fully functioning useless Elm app.  Let's celebrate and
publish it!

I just realized, I need a server.  Is that something Elm should do?  I saw a
mention of it in the elm-make docs.

[This dude's](https://dennisreimann.de/articles/elm-setup-first-project.html)
article is pretty useful for a noob.

I must have drunk too much Koolaide.  Elm _may_ be used on the server, as it
compiles to JS, but it's not a panacea.  It's client language.

Let's just make a quick Express server.

ref:git:c63f670

So now we've got an Express server running, which is standard, and the
elm-reactor server running, to help us preview code before it's compiled
properly.  Eek.  This doesn't sound right.

Either way, let's change our elm-make command to spit out this hotness into the
static dir.

`elm-make Main.elm --output=public/index.html`

That works, but I don't want to keep typing that and we should probably keep our
Elm stuff in its own dir before it gets out of hand.

ref:git:d83468a

There we go.  Now we can just `yarn build` and get a new `public/index.html`.
