"""
A simple game of pong
"""

import sys

from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtWidgets import QApplication

app = QApplication(sys.argv)
engine = QQmlApplicationEngine()
engine.load("pong.qml")

engine.quit.connect(app.quit)

sys.exit(app.exec_())
