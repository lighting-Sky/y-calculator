# y-calculator

一个基于 PyQt5 + QML 的现代风格桌面计算器。

## 功能特色
- 极简黑色主题，按钮灰色，字体白色，=号为蓝色
- 标准计算器布局，支持加减乘除、小数点、正负号、百分比、清零等常用功能
- 响应式大显示区，界面美观

## 运行方法
1. 安装依赖：
   ```bash
   pip install PyQt5
   ```
2. 运行主程序：
   ```bash
   python main.py
   ```

## 文件说明
- `main.py`：程序入口，加载 QML 界面
- `calculator_backend.py`：计算器核心逻辑（Python）
- `calculator.qml`：主界面布局（QML）
- `CalculatorButton.qml`：自定义按钮组件

## 截图
![界面截图](image.png)

---
如需自定义或扩展功能，请修改对应 QML 或 Python 文件。
