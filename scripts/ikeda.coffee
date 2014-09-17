log_dumper = (user, data) ->
    message = ''
    for d in data
        message += d.date.toLocaleString('japanese')
        message += ' '
        message += d.record
        message += '\n'
    return "#{user} ﾉｻｷﾞｮｳﾛｸﾞ...\n#{message}"

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

        robot.brain.data[user].push({
            record: msg.match[1],
            date: new Date(),
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

        msg.send "#{user} ﾉﾛｸﾞ､ｾﾞﾝﾌﾞｹｼﾃﾔｯﾀ"
