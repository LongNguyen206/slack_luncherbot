require 'slack-ruby-bot'
require 'giphy'

class LuncherBot < SlackRubyBot::Bot
    help do
        title 'Luncherbot'
        desc 'Vote for your lunch option!'
    
        command 'vote' do
          desc 'Initiates a vote'
          long_desc "Accurate 10 Day Weather Forecasts for thousands of places around the World.\n" \
            'Bot provides detailed Weather Forecasts over a 10 day period updated four times a day.'
        end
    end

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