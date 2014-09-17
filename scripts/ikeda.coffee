log_dumper = (user, data) ->
    message = ''
    for d in data
        message += strftime(d.date)
        message += ', '
        message += d.record
        message += '\n'
    return "@#{user} ﾉｻｷﾞｮｳﾛｸﾞ...\n#{message}"

strftime = (date, format = 'YYYY-MM-DD hh:mm:ss') ->
  format = format.replace /YYYY/g, date.getFullYear()
  format = format.replace /MM/g, ('0' + (date.getMonth() + 1)).slice(-2)
  format = format.replace /DD/g, ('0' + date.getDate()).slice(-2)
  format = format.replace /hh/g, ('0' + date.getHours()).slice(-2)
  format = format.replace /mm/g, ('0' + date.getMinutes()).slice(-2)
  format = format.replace /ss/g, ('0' + date.getSeconds()).slice(-2)
  if format.match /S/g
    milliSeconds = ('00' + date.getMilliseconds()).slice(-3)
    length = format.match(/S/g).length
    format.replace /S/, milliSeconds.substring(i, i + 1) for i in [0...length]
  return format

module.exports = (robot) ->
    robot.hear /池田さん/, (msg) ->
        msg.send msg.random [
            "ｳｳｳ...ｩｳｩｩｳｩ...ｳｳ..ｩｩｩ",
            "ｱﾘｴﾈｰﾀﾞﾛ",
            "ｲﾔ､ｼｶｼﾀﾞﾅ...",
            "ｱﾘｴﾈｰｯｼｮ!",
            "ｿﾝﾅﾜｹﾈｰﾀﾞﾛ!",
            "ﾛﾝﾘﾃｷﾆｲｴﾊﾞﾀﾞﾅ...",
            "100ﾊﾟｰｾﾝﾄｱﾘｴﾈｰﾀﾞﾛ!!",
            "ﾌｻﾞｹﾝﾅﾖ!",
        ]

    robot.hear /^(.+)なう$/, (msg) ->
        user = msg.message.user.name

        if not robot.brain.data[user]
            robot.brain.data[user] = []

        d = new Date()
        d.setTime(d.getTime() + (540 * 60 * 1000))

        robot.brain.data[user].push({
            record: msg.match[1],
            date: d,
        })

        robot.brain.save()

        msg.send "ﾏ､ｶﾞﾝﾊﾞﾚ"

    robot.hear /^log$/, (msg) ->
        user = msg.message.user.name
        return if not robot.brain.data[user]
        msg.send log_dumper(user, robot.brain.data[user])

    robot.hear /^log ([^\s]+)$/, (msg) ->
        user = msg.match[1]
        return if not robot.brain.data[user]
        msg.send log_dumper(user, robot.brain.data[user])

    robot.hear /^clear log$/, (msg) ->
        user = msg.message.user.name

        robot.brain.data[user] = []
        robot.brain.save()

        msg.send "@#{user} ﾉﾛｸﾞ､ｾﾞﾝﾌﾞｹｼﾃﾔｯﾀ"
