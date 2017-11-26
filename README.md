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


### Now that we've got a server and something to see...

Let's make a button that responds to our clicks.

ref:git:70089e4

Now we've got a button that causes the model to change.  That's good, but
pointless.  Let's work toward something useful.  Instead of top-down, maybe we
can go bottom up.  At the lowest level, we'll have a todo item that will have
text and a done state we want to toggle.  Let's make that.

I don't know how to import from other files yet, but we'll cross that bridge
later.

...On second thought, let's not complicate things yet.  We'll just keep
everything in Main.elm.

ref:git:76e8d1c

We've made the model a record and added a boolean to it so we can toggle when
the button is clicked.  We want to have a list of tasks that look kind of like
this.  I don't know how to do all that yet, so let's just start by putting them
in the model and rendering them.

ref:git:c3c9761e2c7ab7962337498adb42d15979b23346

Here is a static list of tasks.  Let's loop over them when rendering.

ASIDE: [Here's a good
tutorial](https://www.elm-tutorial.org/en/04-starting/cover.html) right in the
docs that shows how to start out.  :D  RTFM, eh?

ref:git:e8ecfd0

There we go.  We're mapping the models and spitting out items.


### We are now dynamically rendering the list of tasks.

At this point, let's figure out how to add to the list of tasks.  We'll make a
button and just push some junk on each click for now.

ref:git:aa026a1

Now we're adding to our list each time we click the button.  Remember, we can
push or alter the list.  Instead, we create a new list by
[appending](http://package.elm-lang.org/packages/elm-lang/core/latest/List#append)
the original with a new list of one item.

ref:git:10647da

Now we're starting with an empty list and populating it when we click the
button.  This is so exciting!


Sat Nov 25 18:53:35 CST 2017

We are back!  Now let's specify the text of the new item using a input.  First,
we'll make an input and add its value to the model.

ref:git:a479c6d

We're getting the value from the input and saving it in the model now.  The
event we need is `onInput`, not `onChange`.

ref:git:7729449

Now we're setting `model.text` by the input (and vice versa) and using it to set
the name for the next task.  `enter` doesn't do anything, though, since we don't
have a proper form.

ref:git:074fcd8

Handling onEnter turns out to be more difficult that expected.  For now, we're
just going to move the inputs around.

We need to show two different states for the items, todo and done.  For now,
let's just print it in text.

ref:git:95ac250

We're rendering the tasks with a line through them if they're done now, but none
of them are done.  We want to toggle the done state when we click on them.  How
do we do that?  I'm sure there's a click handler, but how do we tie that to the
task instance the html is being rendered for?

ref:git:907b60f

Now we're toggling states by clicking on tasks.

When clicking, we're emitting a message with a task and a boolean to set the
new value to.  That leads us to map the list of tasks and, if the task is the
one we clicked, change its "done" value.  However, we're not using anything
unique, so { name = "foo", done = False } could be in the list multiple times.
That would lead us to toggle both of them when clicked.  Instead of all this,
let's give each task a unique ID and use _that_ to update the value.

ref:git:951a860

If we use the length of tasks to set the ID, if we eventually add the ability to
remove a task, that will lead to bugs with duplicate IDs.  If we keep a count,
we can use that.  My instinct was to use a local varible in some function, but
we don't do things like that.  It's state, so it needs to be in the model.

ref:git:946726a

There we go.  Now let's key off the task ID when toggling the done state.

ref:git:82b7cb0

Now we can have duplicate task names, but they are still treated as unique
tasks.
