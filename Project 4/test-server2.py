import asyncio
import websockets
import pandas as pd
from flask import Flask, jsonify, render_template
from io import StringIO

app = Flask(__name__)

data_store = []  # Global list to store data

@app.route('/')
def display_price_chart():
    aggregated_data = get_aggregated_data()
    if aggregated_data:
        last_price = aggregated_data[-1]['average_price']
        last_volume = aggregated_data[-1]['volume']
        highest_price = max([item['max_price'] for item in aggregated_data])
        lowest_price = min([item['min_price'] for item in aggregated_data])
    else:
        last_price = last_volume = highest_price = lowest_price = 0

    return render_template('tests.html', aggregated_data=aggregated_data, last_price=last_price, 
                           last_volume=last_volume, highest_price=highest_price, lowest_price=lowest_price)

def get_aggregated_data():
    time_data = {}
    for row in data_store:
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
                processed_data = calculate(received_data)
                data_store.extend(processed_data)
                print("Received and processed data:\n", processed_data)

            except Exception as e:
                print(f"Error: {e}")
                continue

def calculate(data):
    """Perform all the calculations on the data."""
    new_data = []  # Create an empty list to store the new data
    for (hour, minute), data_by_minute in data.groupby([data["DateTime"].dt.hour, data['DateTime'].dt.minute]):
        time = data_by_minute['DateTime'].iloc[0].strftime("%H:%M")
        max_price = data_by_minute['Price'].max()
        min_price = data_by_minute['Price'].min()
        average_price = round(data_by_minute['Price'].mean(), 2)
        volume = data_by_minute['Quantity'].sum()
        
        new_data.append({
            "time": time,
            "max_price": max_price,
            "min_price": min_price,
            "average_price": average_price,
            "volume": volume
        })
    return new_data

if __name__ == '__main__':
    asyncio.get_event_loop().run_until_complete(receive_data())  # Start receiving data task
    app.run(debug=True, port=5000)
