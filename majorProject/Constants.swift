//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Caleb Stultz on 7/27/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "42a1771a0b787bf12e734ada0cfc80cb"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?q=Chennai,in&appid=10d83272107b3579bbec3790805f50f1"
let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Chennai&mode=json&units=metric&cnt=7&appid=10d83272107b3579bbec3790805f50f1"
