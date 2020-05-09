# Memory Puzzle

Card memory game made with ruby!

```ruby
ruby game.rb
```

The default values for the game is an AI player.

The default size of the grid is 4x4

The cards are letters of the alphabet, 'A' to 'Z.'

Match all the cards to win!

---

The grid is dynamic and can be set to a certain size. Simply enter the value after creating the player.

You can either set the player to yourself or an AI

_AI version needs the size of the grid to be entered_

```ruby
player = Game.new(Player.new, 6)
player.play
```

```ruby
computer = Game.new(ComputerPlayer.new(9), 9).play

```

Leave out the grid size if you wish to keep it 4x4

```ruby
player = Game.new(Player.new).play
```

---

```ruby
  0 1 2 3
0 I
1
2
3
Select a position (e.g., 0 0)
> 0 0
```

```ruby
  0 1 2 3
0 I U S X
1 G O K G
2 Z I O S
3 X U Z K
I guess your memory is pretty good :D
```
