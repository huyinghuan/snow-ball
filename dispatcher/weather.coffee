_WeGo = require('wego')
_request = require 'request'
_weather_token = require('../config').weather
wego = new _WeGo()

#提取信息
dealMessage = (weather)->
  #console.log JSON.stringify(weather.daily_forecast[0], 4)
  msg = []
  msg.push "#{weather.basic.city} #{weather.basic.update.loc}"
  now = weather.now
  msg.push "  #{now.cond.txt} #{now.tmp}度 #{now.wind.dir} #{now.wind.sc}"
  aqi = weather.aqi
  msg.push "  空气质量: #{aqi.city.qlty} PM2.5: #{aqi.city.pm25}"

  daily_forecast = weather.daily_forecast

  for item, index in daily_forecast
    break if index > 2
    if index is 0
      msg.push "今天："
    else
      msg.push("#{item.date}:")

    msg.push(
      "  昼：#{item.cond.txt_d or ""} 夜：#{item.cond.txt_n or ""} #{item.tmp.min}~#{item.tmp.max}度"
    )
    msg.push(
      "  #{item.wind.dir} #{item.wind.sc} 降水:#{item.pop}%, #{item.pcpn}mm "
    )

  msg.join('\n')

getWeather = (city, cb)->
  url  = "http://apis.baidu.com/heweather/weather/free?city=#{encodeURI(city)}"
  _request({
    method: "GET",
    uri: url,
    headers: {
      apikey: _weather_token
    },
    json: true
  }, (error, response, body)->
    result = ""
    return if not cb
    if error or response.statusCode isnt 200
      cb("获取天气失败")
    else if not (result = body["HeWeather data service 3.0"])
      cb("获取天气失败, 协议过时")
    else if result[0].status isnt "ok"
      cb("城市不存在！")
    else
      cb(null, dealMessage(result[0]))
  )

module.exports = (req, resp, data)->
  serverName = data.ToUserName
  clientName = data.FromUserName
  data.ToUserName = clientName
  data.FromUserName = serverName
  userContent = data.Content
  arr = userContent.split('|')
  city = arr[1] or "changsha"
  getWeather(city, (err, result)->
    data.Content = err or result
    wego.sendMsg(req, resp, data)
  )
