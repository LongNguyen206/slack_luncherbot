require 'slack-ruby-bot'
require 'giphy'

# SlackRubyBot::Client.logger.level = Logger::WARN

class LuncherBot < SlackRubyBot::Bot

    help do
        title 'Luncherbot'
        desc 'Vote for your lunch option!'
    
        command 'vote <number_of_voters>' do
          desc 'Initiates a vote'
          long_desc "Initiates a vote from a predetermined list of restaurants.\n" \
            'The bot will keep registering votes equal to the number of voters.'
        end
    end
    @vote_initiated = false
    # use hashes for options and vote count
    match(/^lunch vote\s(?<input>\w*)$/) do |client, data, match|
        if match['input'] =~ /^(0+)$/
            client.say(text: "There is noone here to vote :cry:\n", channel: data.channel, gif: "alone")
            @vote_initiated = false
        elsif match['input'] =~ /^(\d+)$/ 
            @vote_initiated = true
            @vote_num = match['input'].to_i
            client.say(text: "<@#{data.user}> initiated a vote! There are #{@vote_num} people voting. Please choose:\n1 - pizza\n2 - Grill'd\n3 - Nandos", channel: data.channel)
            @op1 = 0
            @op2 = 0
            @op3 = 0
            @votes = 0
            # @options = { pizza: 0, Grilld: 0, Nandos: 0 }
        else
            client.say(text: "Cmooooon! '#{match['input']}' is not a number!!! :expressionless:\n", channel: data.channel, gif: "idiot")
            @vote_initiated = false
        end     
    end

    
        match(/^(?<choice>\w)$/) do |client, data, match|
            # if @votes <= @vote_num
                if @vote_initiated == true
                    if @votes < @vote_num
                        if match['choice'].to_i == 1
                            @op1 += 1
                            @votes += 1
                            if @op1 == 1
                                client.say(text: "#{@op1} vote for pizza!\n", channel: data.channel)
                            else
                                client.say(text: "#{@op1} votes for pizza!\n", channel: data.channel)
                            end
                        elsif match['choice'].to_i == 2
                            @op2 += 1
                            @votes += 1
                            if @op2 == 1
                                client.say(text: "#{@op2} vote for Grill'd!\n", channel: data.channel)
                            else
                                client.say(text: "#{@op2} votes for Grill'd!\n", channel: data.channel)
                            end
                        elsif match['choice'].to_i == 3
                            @op3 += 1
                            @votes += 1
                            if @op3 == 1
                                client.say(text: "#{@op3} vote for Nandos!\n", channel: data.channel)
                            else
                                client.say(text: "#{@op3} votes for Nandos!\n", channel: data.channel)
                            end
                        else
                            client.say(text: "No such option!\n", channel: data.channel, gif: 'idiot')
                        end
                    else
                        client.say(text: "All votes counted!\n", channel: data.channel)
                        @vote_initiated = false
                    end
                else
                    client.say(text: "Please initiate a vote!\n", channel: data.channel)
                end
            # end
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