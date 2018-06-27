require 'slack-ruby-bot'
require 'giphy'

class LuncherBot < SlackRubyBot::Bot
    command 'vote' do |client, data, match|
        client.say(text: "<@#{data.user}> initiated a vote! Please choose:\n1 - pizza\n2 - grilld\n3 - nandos", channel: data.channel)
        op1, op2, op3 = 0
    end
    command '1' do |client, data, match|
        op1 += 1
        client.say(text: "#{op1} vote for pizza", channel: data.channel)
    end
end
SlackRubyBot.configure do |config|
    config.aliases = ['lunch', 'food']
  end
LuncherBot.run