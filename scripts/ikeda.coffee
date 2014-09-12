module.exports = (robot) ->
    robot.hear /池田さん/, (msg) ->
        msg.send msg.random [
            "ｳｳｳ...ｩｳｩｩｳｩ...ｳｳ..ｩｩｩ",
            "ｱﾘｴﾈｰﾀﾞﾛ",
            "ｲﾔ､ｼｶｼﾀﾞﾅ...",
            "ｱﾘｴﾈｰｯｼｮ!",
            "ｿﾝﾅﾜｹﾈｰﾀﾞﾛ!",
        ]
