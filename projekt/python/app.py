from flask import Flask, redirect, url_for, render_template, request
from connector import getPlugInfo, switchState, activateAll, shutdownAll, getServerInfo, reboot, refreshIPs, refreshStats
import os

app = Flask(__name__)

# Homepage
@app.route('/')
@app.route('/home')
def home():
	dict = getPlugInfo()
	return render_template('index.html', content = dict)

# Server
@app.route('/server')
def server():
	refreshStats()
	list = getServerInfo()
	return render_template('server.html', content = list)

# Plug information
@app.route('/devices/<input>')
def devices(input):
	return render_template('devices.html', content = getPlugInfo(), alias = [input])

# Shutdown / Activate plug
@app.route('/switchstate/<input>')
def switch(input):
	dict = getPlugInfo()
	switchState(input, dict)
	return redirect(url_for('home'))

# About us page
@app.route('/about_us')
def about_us():
	return render_template('about_us.html')

# Activate all plugs function
@app.route('/activate')
def activate():
	dict = getPlugInfo()
	activateAll(dict)
	return redirect(url_for('home'))

# Shutdown all plugs function
@app.route('/shutdown')
def shutdown():
	dict = getPlugInfo()
	shutdownAll(dict)
	return redirect(url_for('home'))

# Reboot server function
@app.route('/reboot')
def reboot_srv():
	reboot()

# Refresh plug IPs / scan network
@app.route('/refresh')
def refresh():
	refreshIPs()
	return redirect(url_for('home'))

# Set HTTP port 
if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8080, debug=True)
