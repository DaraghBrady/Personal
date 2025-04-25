from flask import Flask, render_template
import csv

app = Flask(__name__)

def get_data_from_csv():
    with open('test.csv', mode='r') as file:
        reader = csv.DictReader(file)
        data = list(reader)
    return data

def get_aggregated_data():
    data = get_data_from_csv()

    time_data = {}
    for row in data:
        time = row['time']
        max_price = float(row['maxprice'])
        min_price = float(row['minprice'])
        average_price = float(row['averageprice'])
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

@app.route('/')
def display_price_chart():
    aggregated_data = get_aggregated_data()
    last_price = aggregated_data[-1]['average_price']
    last_volume = aggregated_data[-1]['volume']
    highest_price = max([item['max_price'] for item in aggregated_data])
    lowest_price = min([item['min_price'] for item in aggregated_data])

    return render_template('graph1.html', aggregated_data=aggregated_data, last_price=last_price, 
                           last_volume=last_volume, highest_price=highest_price, lowest_price=lowest_price)


if __name__ == '__main__':
    app.run(debug=True, port=5000)