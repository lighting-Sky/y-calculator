from PyQt5.QtCore import QObject, pyqtSignal, pyqtProperty, pyqtSlot

class Calculator(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._display = "0"
        self._current_input = ""
        self._operation = ""
        self._stored_value = 0.0
        self._waiting_for_operand = True

    displayChanged = pyqtSignal()
    
    @pyqtProperty(str, notify=displayChanged)
    def display(self):
        return self._display
    
    @pyqtSlot(str)
    def input_digit(self, digit):
        if self._waiting_for_operand:
            self._current_input = digit
            self._waiting_for_operand = False
        else:
            if digit == '.' and '.' in self._current_input:
                return
            self._current_input += digit
        
        self._display = self._current_input
        self.displayChanged.emit()
    
    @pyqtSlot(str)
    def input_operation(self, op):
        if not self._waiting_for_operand:
            self.calculate()
        
        self._operation = op
        self._stored_value = float(self._display)
        self._waiting_for_operand = True
    
    @pyqtSlot()
    def calculate(self):
        if self._operation and not self._waiting_for_operand:
            current_value = float(self._display)
            
            try:
                if self._operation == "+":
                    result = self._stored_value + current_value
                elif self._operation == "-":
                    result = self._stored_value - current_value
                elif self._operation == "×":
                    result = self._stored_value * current_value
                elif self._operation == "÷":
                    result = self._stored_value / current_value
                else:
                    return
                
                self._display = str(result)
                if self._display.endswith('.0'):
                    self._display = self._display[:-2]
                self._stored_value = result
            except ZeroDivisionError:
                self._display = "Error"
            
            self.displayChanged.emit()
        
        self._waiting_for_operand = True
    
    @pyqtSlot()
    def clear(self):
        self._display = "0"
        self._current_input = ""
        self._operation = ""
        self._stored_value = 0.0
        self._waiting_for_operand = True
        self.displayChanged.emit()
    
    @pyqtSlot()
    def clear_entry(self):
        self._current_input = ""
        self._display = "0"
        self._waiting_for_operand = True
        self.displayChanged.emit()
    
    @pyqtSlot()
    def toggle_sign(self):
        if self._display != "0":
            if self._display[0] == '-':
                self._display = self._display[1:]
            else:
                self._display = '-' + self._display
            self._current_input = self._display
            self.displayChanged.emit()
    
    @pyqtSlot()
    def percentage(self):
        value = float(self._display) / 100
        self._display = str(value)
        if self._display.endswith('.0'):
            self._display = self._display[:-2]
        self._current_input = self._display
        self.displayChanged.emit()