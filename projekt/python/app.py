from flask import Flask, redirect, url_for, render_template, request
from connector import GetInfo, SwitchState, ActivateAll, ShutdownAll, GetServerInfo, reboot, refreshIPs
import os

app = Flask(__name__)

# Refresh tp-link IPs
refreshIPs()

# Refresh server stats
def refresh_stats():
	os.system('../bash-scripts/cpu-memory-swap.sh') # host
	os.system('ssh serverAlex "cat serverAlex.txt" >> data/server.txt') # external .201
	os.system('ssh serverArnie "cat serverArnie.txt" >> data/server.txt') # external .203

# Homepage
@app.route('/')
@app.route('/home')
def home():
	dict = GetInfo()
	print(dict)
	return render_template('index.html', content = dict)

@app.route('/server')
def server():
	refresh_stats()
	list = GetServerInfo()
	return render_template('server.html', content = list)

# Redirect
@app.route('/devices/<input>')
def devices(input):
	return render_template('devices.html', content = GetInfo(), alias = [input])

@app.route('/switchstate/<input>')
def switch(input):
	dict = GetInfo()
	SwitchState(input, dict)
	return redirect(url_for('home'))

@app.route('/about_us')
def about_us():
	return render_template('about_us.html')

@app.route('/activate')
def activate():
	dict = GetInfo()
	ActivateAll(dict)
	return redirect(url_for('home'))

@app.route('/shutdown')
def shutdown():
	dict = GetInfo()
	ShutdownAll(dict)
	return redirect(url_for('home'))

@app.route('/reboot')
def reboot_srv():
	reboot()

@app.route('/refresh')
def refresh():
	refreshIPs()
	return redirect(url_for('home'))

if __name__ == '__main__':
	app.run(host='0.0.0.0', port=8080, debug=True)
