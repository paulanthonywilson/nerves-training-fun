// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})


socket.connect()

let timeElement = document.getElementById("server_time")
let lightLevelElement = document.getElementById("light_level")
let temperatureElement = document.getElementById("temperature")
let atmosphericPressureElement = document.getElementById("atmospheric_pressure")
let heightElement = document.getElementById("height")

console.log(timeElement)

let formatNumber = num => {
  return num.toLocaleString("en-GB", {minimumFractionDigits: 2, maximumFractionDigits: 2})
}

let displaySensorReading = sensor_reading => {
  timeElement.innerHTML                = sensor_reading.time
  lightLevelElement.innerHTML          = sensor_reading.light_level
  temperatureElement.innerHTML         = formatNumber(sensor_reading.temperature)
  atmosphericPressureElement.innerHTML = formatNumber(sensor_reading.pressure)
  heightElement.innerHTML              = formatNumber(sensor_reading.height)
}

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("sensor", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("device_io_sensor_event", displaySensorReading)


export default socket
