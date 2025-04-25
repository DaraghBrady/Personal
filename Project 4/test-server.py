import asyncio
import websockets
import pandas as pd
from flask import Flask, jsonify, render_template
from io import StringIO

app = Flask(__name__)

data_store = []

@app.route('/')
def index():
    return display_price_chart()

def display_price_chart():
    aggregated_data = get_aggregated_data()
    if aggregated_data:
        last_price = aggregated_data[-1]['average_price']
        last_volume = aggregated_data[-1]['volume']
        highest_price = max([item['max_price'] for item in aggregated_data])
        lowest_price = min([item['min_price'] for item in aggregated_data])
    else:
        last_price = last_volume = highest_price = lowest_price = 0

    return render_template('graph1.html', aggregated_data=aggregated_data, last_price=last_price, 
                           last_volume=last_volume, highest_price=highest_price, lowest_price=lowest_price)

def get_aggregated_data():
    data = data_store
    time_data = {}
    for row in data:
        time = row['time']
        max_price = float(row['max_price'])
        min_price = float(row['min_price'])
        average_price = float(row['average_price'])
        volume = float(row['volume'])

        if time in time_data:
            if max_price > time_data[time]['max_price']:
                time_data[time]['max_price'] = max_price
            if min_price < time_data[time]['min_price']:
                time_data[time]['min_price'] = min_price
            time_data[time]['average_price'] = average_price
            time_data[time]['volume'] += volume
        else:
            time_data[time] = {
                'max_price': max_price,
                'min_price': min_price,
                'average_price': average_price,
                'volume': volume
            }

    formatted_data = []
    for time, values in time_data.items():
        formatted_data.append({
            'time': time,
            'max_price': values['max_price'],
            'min_price': values['min_price'],
            'average_price': values['average_price'],
            'volume': values['volume']
        })

    return formatted_data

async def receive_data():
    """Receive data from the simulator."""
    global data_store
    url = "ws://localhost:8000/ws"

    async with websockets.connect(url) as websocket:
        while True:
            try:
                received_data = await websocket.recv()
                received_data = pd.read_json(StringIO(received_data))
                received_data.rename(columns={
                    "datetime": "DateTime",
                    "price": "Price",
                    "quantity": "Quantity"
                }, inplace=True)
                data_store.append(received_data.to_dict('records'))
                print("Received data:\n", received_data)

            except Exception as e:
                print(f"Error: {e}")
                continue

if __name__ == '__main__':
    asyncio.get_event_loop().run_until_complete(receive_data())
    app.run(debug=True, port=8000)