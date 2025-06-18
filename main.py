import sys
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType
from calculator_backend import Calculator

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # 注册 Calculator 类型到 QML
    qmlRegisterType(Calculator, "Calculator", 1, 0, "Calculator")
    
    engine = QQmlApplicationEngine()
    calculator = Calculator()
    engine.rootContext().setContextProperty("calculator", calculator)  # 注意小写
    engine.load("calculator.qml")
    
    if not engine.rootObjects():
        sys.exit(-1)
    
    sys.exit(app.exec_())