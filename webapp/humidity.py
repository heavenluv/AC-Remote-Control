
import Adafruit_DHT
#import adafruit_dht
#from board import *

DHT_SENSOR = Adafruit_DHT.DHT11
DHT_PIN = 17

#SENSOR_PIN = D4

#dht22 = adafruit_dht.DHT22(SENSOR_PIN, use_pulseio=False)

def get_data():
    humidity, temperature = Adafruit_DHT.read_retry(DHT_SENSOR, DHT_PIN)
    #temperature = dht22.temperature
    #humidity = dht22.humidity
    if humidity is not None and temperature is not None:
        print("Temp={0:0.1f}*C  Humidity={1:0.1f}%".format(temperature, humidity))
    else:
        print("Failed to retrieve data from humidity sensor")
    return temperature, humidity

ans = get_data()