/*
 * A simple game of pong
 */

import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window

    visible: true
    title: qsTr("Pong")
    minimumHeight: 500
    minimumWidth: 510
    color: "#191919"

    Component.onCompleted: showMaximized()

    readonly property int playerVelocity: 14

    function paddleCollisionCheck(paddle, ball) {
        return ball.x + ball.width > paddle.x && ball.x < paddle.x + paddle.width &&
               ball.y + ball.height > paddle.y && ball.y < paddle.y + paddle.height
    }

    function bounce(paddle, ball) {
        // Collide with left
        if (paddle.x > ball.x && paddle.x < ball.x + ball.width) {
            ball.xVelocity *= -1
            ball.x = paddle.x - ball.width
        }
        // Collide with right
        else if (paddle.x + paddle.width > ball.x && paddle.x + paddle.width < ball.x + ball.width) {
            ball.xVelocity *= -1
            ball.x = paddle.x + paddle.width
        }
        // Collide with top
        else if (paddle.y > ball.y && paddle.y < ball.y + ball.height) {
            ball.yVelocity *= -1
            ball.y = paddle.y - ball.height
        }
        // Collide with bottom
        else {
            ball.yVelocity *= -1
            ball.y = paddle.y + paddle.height
        }
    }

    function ballStartVelocity() {
        return (Math.random() * 2 + 9) * (Math.random() > 0.5 ? -1 : 1)
    }

    Item {
        id: keyCatcher

        focus: true

        Keys.onDigit1Pressed: player1.y = Math.max(0, player1.y - playerVelocity)
        Keys.onDigit2Pressed: player1.y = Math.min(window.height - player1.height, player1.y + playerVelocity)

        Keys.onUpPressed: player2.y = Math.max(0, player2.y - playerVelocity)
        Keys.onDownPressed: player2.y = Math.min(window.height - player2.height, player2.y + playerVelocity)
    }

    Rectangle {
        id: player1

        height: 200
        width: 35
        x: 50
        y: (window.height - height) / 2

        color: "gray"
    }

    Rectangle {
        id: ball

        property int xVelocity: ballStartVelocity()
        property int yVelocity: ballStartVelocity()

        height: 30
        width: height
        radius: height / 2

        x: (window.width - width) / 2
        y: (window.height - height) / 2
    }

    Rectangle {
        id: player2

        property real direction: 0.7
        property bool isComputerPlayer: false

        height: 200
        width: 35
        x: window.width - 50 - width
        y: (window.height - height) / 2
        color: "gray"
    }

    Text {
        id: gameOverText

        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 48
        color: "white"


    }

    Button {
        anchors {top: gameOverText.bottom; left: gameOverText.left; right: gameOverText.right; topMargin: 15}
        height: 60

        text: "Play Again"
        font.pointSize: 22
        visible: gameOverText !== ""

        onClicked: {
            ball.x = (window.width - ball.width) / 2
            ball.y = (window.height - ball.height) / 2
            ball.xVelocity = ballStartVelocity()
            ball.yVelocity = ballStartVelocity()

            player1.x = 50
            player1.y = (window.height - player1.height) / 2

            player2.x = window.width - 50 - player2.width
            player2.y = (window.height - player1.height) / 2
            player2.direction = 0.7

            gameCycle.running = true

            gameOverText.text = ""

            keyCatcher.forceActiveFocus()
        }
    }


    // The game cycle
    Timer {
        id: gameCycle

        running: true
        repeat: true
        interval: 16

        onTriggered: {
            if (player2.isComputerPlayer) {
                player2.y += playerVelocity * player2.direction
                if (player2.y < 0) {
                    player2.y = 0
                    if (player2.direction < 0) {
                        player2.direction *= -1
                    }
                }
                if (player2.y > window.height - player2.height) {
                    player2.y = window.height - player2.height
                    if (player2.direction > 0) {
                        player2.direction *= -1
                    }
                }
            }


            // Ball X movement
            ball.x += ball.xVelocity
            // Check for goal collisions
            if (ball.x < 0) {
                ball.x = 0
                gameCycle.running = false
                gameOverText.text = "Game Over!\nPlayer 2 won!"
                gameOverText.opacity = 1
            }
            else if (ball.x > window.width - ball.width) {
                ball.x = window.width - ball.width
                gameCycle.running = false
                gameOverText.text = "Game Over!\nPlayer 1 won!"
                gameOverText.opacity = 1
            }

            // Ball Y movement
            ball.y += ball.yVelocity
            // Check for collisions with top and bottom of screen
            if (ball.y < 0) {
                ball.y = 0
                if (ball.yVelocity < 0) {
                    ball.yVelocity *= -1
                }
            }
            else if (ball.y > window.height - ball.width) {
                ball.y = window.height - ball.width
                if (ball.yVelocity > 0) {
                    ball.yVelocity *= -1
                }
            }


            if (paddleCollisionCheck(player1, ball)) {
                bounce(player1, ball)
            }
            else if (paddleCollisionCheck(player2, ball)) {
                bounce(player2, ball)
            }
        }
    }
}
