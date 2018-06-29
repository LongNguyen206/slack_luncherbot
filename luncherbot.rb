require 'slack-ruby-bot'
require 'giphy'
require 'httparty'

# SlackRubyBot::Client.logger.level = Logger::WARN

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

    match(/^vote\s(?<input>\w*)$/) do |client, data, match|
        if match['input'] =~ /^(0+)$/
            client.say(text: "There is noone here to vote :cry:\n", channel: data.channel, gif: "alone")
        elsif match['input'] =~ /^(\d+)$/ 
            vote_num = match['input'].to_i
            client.say(text: "<@#{data.user}> initiated a vote! There are #{vote_num} people voting. Please choose:\n1 - pizza\n2 - grilld\n3 - nandos", channel: data.channel)
            op1, op2, op3 = 0

        else
            client.say(text: "Cmooooon! '#{match['input']}' is not a number!!! :expressionless:\n", channel: data.channel, gif: "dumb")
        end     
    end

    # class << self
    #     def parse_input(_match)
    #       limit = _match[:expression] if limit.to_i.to_s == limit
    #       {
    #         limit: limit || DEFAULT_LIMIT
    #       }
    #     end
    # end
end

SlackRubyBot.configure do |config|
    config.aliases = ['lunch']
end

LuncherBot.run