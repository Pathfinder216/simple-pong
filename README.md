# simple-pong
A simple game of pong, written in PyQt and QML during a plane flight.

## Install
* Install Python 3.6
* Install pipenv
```
pip install --user pipenv
```
* Clone this repository
* Inside a pipenv for the project, install a version of pip that works with pipenv
```
pipenv run pip install --upgrade pip==18.0
```
* Install dependencies
```
pipenv sync
```

## Usage
```
pipenv run python pong.py
```

Use the 1 and 2 keys to move player one up and down.

Use the up and down keys to move player two up and down.

## Customization
If you want to change the paddle velocity, adjust the `playerVelocity` property near the top of pong.qml.

To change the ball velocity, adjust the math in the `ballStartVelocity` function.

To switch to single-player mode, set the `isComputerPlayer` property of `player2` to `true`. To change its speed, change its `direction` multiplier.
