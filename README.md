# simple-pong
A simple game of pong, written in PyQt and QML during a plane flight.

## Install
* Install Python 3, version 11 or greater
* Install poetry
```
pip install --user poetry
```
* Clone this repository
* Install dependencies
```
poetry sync
```

## Usage
```
poetry run python pong.py
```

Use the 1 and 2 keys to move player one up and down.

Use the up and down keys to move player two up and down.

## Customization
If you want to change the paddle velocity, adjust the `playerVelocity` property near the top of pong.qml.

To change the ball velocity, adjust the math in the `ballStartVelocity` function.

To switch to single-player mode, set the `isComputerPlayer` property of `player2` to `true`. To change its speed, change its `direction` multiplier.
