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

    match(/^(v|V)ote\s(?<input>\w*)$/) do |client, data, match|
        if match['input'] =~ /^(0+)$/
            client.say(text: "There is noone here to vote :cry:\n", channel: data.channel, gif: "alone")
            @vote_initiated = false
        elsif match['input'] =~ /^(\d+)$/
            @users_voted = Array.new
            @vote_initiated = true
            @options = [{ name: "Nandos", votes: 0 }, { name: "Grill'd", votes: 0 }, { name: "Ramen", votes: 0 }, { name: "Turkish", votes: 0 }]
            @vote_num = match['input'].to_i
            client.say(text: "<@#{data.user}> initiated a vote! There are #{@vote_num} people voting. Please choose:\n1 - #{@options[0][:name]}\n2 - #{@options[1][:name]}\n3 - #{@options[2][:name]}\n4 - #{@options[3][:name]}", channel: data.channel)
            @votes_current = 0
        else
            client.say(text: "Cmooooon! '#{match['input']}' is not a number!!! :expressionless:\n", channel: data.channel, gif: "idiot")
            @vote_initiated = false
        end     
    end

    match(/^(?<choice>\w*)$/) do |client, data, match|
        if @vote_initiated == true
            if @votes_current < @vote_num
                if match['choice'] =~ /1|#{@options[0][:name]}/
                    if @users_voted.include? "#{data.user}"
                        client.say(text: "<@#{data.user}> has already voted\n", channel: data.channel, gif: "greedy")
                    else
                        @users_voted.push("#{data.user}")
                        @votes_current += 1
                        @options[0][:votes] += 1
                        client.say(text: "#{@options[0][:votes]} #{@options[0][:votes] == 1 ? "vote" : "votes"} for #{@options[0][:name]}!\n", channel: data.channel)
                    end
                elsif match['choice'] =~ /2|#{@options[1][:name]}/
                    if @users_voted.include? "#{data.user}"
                        client.say(text: "<@#{data.user}> has already voted\n", channel: data.channel, gif: "greedy")
                    else
                        @users_voted.push(data.user)
                        @votes_current += 1
                        @options[1][:votes] += 1
                        client.say(text: "#{@options[1][:votes]} #{@options[1][:votes] == 1 ? "vote" : "votes"} for #{@options[1][:name]}!\n", channel: data.channel)
                    end
                elsif match['choice'] =~ /3|#{@options[2][:name]}/
                    if @users_voted.include? "#{data.user}"
                        client.say(text: "<@#{data.user}> has already voted\n", channel: data.channel, gif: "greedy")
                    else
                        @users_voted.push(data.user)
                        @votes_current += 1
                        @options[2][:votes] += 1
                        client.say(text: "#{@options[2][:votes]} #{@options[2][:votes] == 1 ? "vote" : "votes"} for #{@options[2][:name]}!\n", channel: data.channel)
                    end
                elsif match['choice'] =~ /4|#{@options[3][:name]}/
                    if @users_voted.include? "#{data.user}"
                        client.say(text: "<@#{data.user}> has already voted\n", channel: data.channel, gif: "greedy")
                    else
                        @users_voted.push(data.user)
                        @votes_current += 1
                        @options[3][:votes] += 1
                        client.say(text: "#{@options[3][:votes]} #{@options[3][:votes] == 1 ? "vote" : "votes"} for #{@options[3][:name]}!\n", channel: data.channel)
                    end
                else
                    client.say(text: "No such option!\n", channel: data.channel, gif: 'idiot')
                end
                client.say(text: "#{users_voted}\n", channel: data.channel)
            else
                @vote_initiated = false
            end

            array = Array.new
            winner = String.new
            winners_array = Array.new
            @options.each do |hash|
                array.push(hash[:votes])
            end
            max_votes = array.max
            @options.each do |hash|
                if hash[:votes] == max_votes
                    winners_array.push(hash)
                end 
            end
            winner = winners_array.sample[:name]

            if @votes_current == @vote_num
                client.say(text: "*Voting is over*\n", channel: data.channel)
                @options.each do |hash|
                    client.say(text: "Option *#{hash[:name]}* got #{hash[:votes]} #{hash[:votes] == 1 ? "vote" : "votes"}\n", channel: data.channel)
                end
                client.say(text: "The winner is #{winner} (randomized in case of equal votes)", channel: data.channel)
            end
        else
            client.say(text: "Please initiate a vote!\n", channel: data.channel)
        end
    end
end

SlackRubyBot.configure do |config|
    config.aliases = ['lunch']
end

LuncherBot.run