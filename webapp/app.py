from flask import Flask, request, session, g, redirect, url_for,\
    abort, render_template, flash, jsonify
#import rpi_control
import os
import subprocess


try:
    import humidity
    print("import get_data successfully!")
except:
    print("can not import get_data moudle")


app = Flask(__name__)

state = 0
degree = 18
on = 'irsend SEND_ONCE aircond 18on'
off = 'irsend SEND_ONCE aircond 30off'
signal = ['irsend SEND_ONCE aircond 18', 'irsend SEND_ONCE aircond 19',
          'irsend SEND_ONCE aircond 20', 'irsend SEND_ONCE aircond 21',
          'irsend SEND_ONCE aircond 22', 'irsend SEND_ONCE aircond 24',
          'irsend SEND_ONCE aircond 24', 'irsend SEND_ONCE aircond 25',
          'irsend SEND_ONCE aircond 26', 'irsend SEND_ONCE aircond 27',
          'irsend SEND_ONCE aircond 28', 'irsend SEND_ONCE aircond 29',
          'irsend SEND_ONCE aircond 30']


def main():
    global state
    try:
        temp, wet = humidity.get_data()
    except:
        temp = 26.6
        wet = 12.2
    if state != 0:
        return render_template('index.html', methods=['POST'],
                               Temperature=temp, Wet=wet, Degree=degree)
    else:
        return render_template('index.html', methods=['POST'],
                               Temperature=temp, Wet=wet, Degree=0)


@app.route("/api/get_json/")
def get_all():
    global state
    global degree
    try:
        temp, wet = humidity.get_data()
    except:
        temp = 26.6
        wet = 12.2
    if state != 0:
        return jsonify(temp=temp, humidity=wet, degree=degree)
    else:
        return jsonify(temp=temp, humidity=wet, degree=degree)

@app.route('/api/aircond_on/')
def turn_on_ac():
    global degree
    global state
    print('ir_on')
    for _ in range(2):
        os.system(on)
    state = 1
    degree = 18
    return jsonify(message="Successfully turn on the air conditioner!", code=88, degree=18)


@app.route('/api/aircond_off/')
def turn_off_ac():
    global state
    print('ir_off')
    for _ in range(3):
        os.system(off)
    state = 0
    return jsonify(message="Successfully turn off the air conditioner!", code=77, degree=0)


@app.route("/api/aircond/up/")
def inc_temp():
    global degree
    global state
    if state != 0 and 17 < degree < 30:
        for _ in range(2):
            os.system(signal[degree-18])
        degree += 1
    else:
        pass
    if degree >= 30:
        degree = 30
    return jsonify(message="Successfully increase the temperature of the air conditioner!", code=90, degree=degree)


@app.route("/api/aircond/down/")
def dec_temp():
    global degree
    global state
    if state != 0 and 30 >= degree > 18:
        print("ir_down",signal[degree-19])
        degree -= 1
        for _ in range(3):
            os.system(signal[degree-18])
        
    else:
        pass
    if degree < 18:
        degree = 18
    return jsonify(message="Successfully lower the temperature of the air conditioner!", code=91, degree=degree)



@app.route('/')
def hello_world():
    return main()


@app.route('/index/')
def index():
    return main()


@app.route('/IR_ON/')
def ir_on():
    global degree
    global state
    print('ir_on')
    for _ in range(3):
        os.system(signal[0])
    state = 1
    return main()


@app.route('/IR_OFF/')
def ir_off():
    global state
    print('ir_off')
    for _ in range(3):
        os.system(signal[-1])
    state = 0
    return main()


@app.route("/IR_UP/")
def ir_up():
    global degree
    global state
    if state != 0 and 17 < degree < 30:
        for _ in range(3):
            os.system(signal[degree-17])
        degree += 1
    else:
        pass
    if degree > 30:
        degree = 30
    return main()


@app.route("/IR_DOWN/")
def ir_down():
    global degree
    global state
    if state != 0 and 30 >= degree >= 18:
        print("ir_down")
        for _ in range(3):
            os.system(signal[degree-17])
        degree -= 1
    else:
        pass
    if degree < 18:
        degree = 18
    return main()


if __name__ == '__main__':
    os.system('sudo /etc/init.d/lircd restart')
    app.run(host='0.0.0.0', port=80)
