# Import the necessary modules
import asyncio
from fastapi import FastAPI, WebSocket
from fastapi.responses import HTMLResponse,JSONResponse
from datetime import datetime, timedelta
import pandas as pd
import json

app = FastAPI() # Create an instance of the FastAPI class

start_time="2020-07-01 12:00:00" # Define start date and time
step = 1 # Define step size in seconds
data = pd.read_csv("AAPL.csv", encoding="ANSI") # Read the csv file
data = data.drop('venue', axis=1) # Drop the 'venue' column
#whole=[["DateTime", "Price", "Quantity"]] # Create an empty list to store the whole data
whole=pd.DataFrame()
connection=None # Define a variable to store the connection

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """Websocket endpoint"""
    global connection,step # Define global variables
    await websocket.accept() # Accept the connection
    print("simulator successfully connected to server",flush=True) # Print a message confirming the connection
    connection=websocket # Store the connection
    while True:
        await asyncio.sleep(step) # Wait for the specified step size

data['datetime'] = pd.to_datetime(data['datetime'], format='%Y-%m-%d %H:%M:%S:%f') # Convert the 'datetime' column to datetime format
start_datetime = datetime.strptime(start_time, "%Y-%m-%d %H:%M:%S") # Convert the start date and time to datetime format
end_datetime = data['datetime'].max() # Get the maximum datetime from the 'datetime' column

async def main():
    """Main function to run the simulation"""
    global start_datetime, end_datetime, step, connection, whole # Define global variables
    current_time = start_datetime # Initialize current time
    while current_time <= end_datetime:
        end_time = current_time + timedelta(seconds=step) # Calculate end time for current interval
        
        current_data = data[(data['datetime'] >= current_time) & (data['datetime'] < end_time)] # Filter data for current interval
        
        whole=pd.concat([whole, current_data], ignore_index=True) # Add current data to the whole dataframe

        # Print or process current data for testing purposes
#        print(f"Data for interval {current_time.strftime('%H:%M:%S')} - {end_time.strftime('%H:%M:%S')}:")
#        print(current_data)
#        print("Whole data:")
#        print(whole "\n\n\n")

        if connection is not None: # Check if there is a connection
            current_json = current_data.map(lambda x: str(x) if isinstance(x, pd.Timestamp) else x) # Convert timestamps to strings

#            test_json=[{"datetime":"2020-07-01 04:01:17.597000","price":364.31,"quantity":1},{"datetime":"2020-07-01 04:01:17.597000","price":364.58,"quantity":3}]
#            print(test_json)
#            await connection.send_json(test_json)

            if not current_json.empty:
                print("Sending: \n",current_json.to_json(orient='records'))
                await connection.send_json(current_json.to_json(orient='records')) # Send current data to the server
        
        current_time = end_time # Move to next interval
        await asyncio.sleep(step) # Wait for next interval

asyncio.create_task(main()) # Start the main task

@app.get("/whole")
async def send_whole():
    """Send the whole data to the server"""
    whole_json = whole.map(lambda x: str(x) if isinstance(x, pd.Timestamp) else x) # Convert timestamps to strings
    #print (whole_json)
    return whole_json.to_json(orient='records') # Send the whole dataframe as json

