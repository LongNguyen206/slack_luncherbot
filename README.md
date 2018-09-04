> *this is work in progress. The idea is to make this a universal voting bot for Slack. Expect updates*
# slack_luncherbot

A Slack bot that allows your team to vote for lunch options! Built with [slack-ruby-bot](https://github.com/slack-ruby/slack-ruby-bot)

## Instructions:
1. Clone the repo: `git clone https://github.com/LongNguyen206/slack_luncherbot.git`
2. Create a new Bot Integration ![here](http://slack.com/services/new/bot)
3. Use the 'luncherbot' Username to avoid conflicts
4. Take note of the SLACK_API_TOKEN on the next page
5. Run with `SLACK_API_TOKEN=... bundle exec ruby luncherbot.rb`, where '...' is your generated API
6. Invite the bot to one of your Slack channels (just like any other user)
7. Type `vote <number of people voting>` in the channel to initiate a vote