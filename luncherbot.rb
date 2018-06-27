require 'slack-ruby-bot'
require 'giphy'

class LuncherBot < SlackRubyBot::Bot
    command 'vote' do |client, data, match|
        client.say(text: "<@#{data.user}> initiated a vote! Please choose:", channel: data.channel)
        client.say(text: '1 - pizza', channel: data.channel)
        client.say(text: '2 - grilld', channel: data.channel)
        client.say(text: '3 - nandos', channel: data.channel)
    end
end
LuncherBot.run