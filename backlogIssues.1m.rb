#!/usr/bin/env ruby
# coding: utf-8

# <bitbar.title>Get Backlog Issues</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>hatsushika</bitbar.author>
# <bitbar.author.github>tetuo41</bitbar.author.github>
# <bitbar.desc>get backlog issues</bitbar.desc>
# <bitbar.dependencies>ruby</bitbar.dependencies>

BACKLOG_SPACE_ID = 'Your backlog space id'
BACKLOG_API_KEY  = 'Your backlog api key'
PROJECT_KEY      = 'You want to get issues project key'


class GetBacklogIssues
  require 'backlog_kit'
  def initialize
    @client = BacklogKit::Client.new(
      space_id: BACKLOG_SPACE_ID,
      api_key: BACKLOG_API_KEY
    )
  end

  def getIssues
    params = {
      projectId: get_project_id,
      statusId:  [1,2,3],
      assigneeId: get_assignee_id
    }
    print_issues(@client.get_issues(params))
  end

private

  def get_assignee_id
    myself = @client.get_myself
    return [myself.body.id]
  end

  def get_project_id
    project = @client.get_project(PROJECT_KEY)
    return [project.body.id]
  end

  def print_issues(issues)
    puts "#{issues.body.length} " + ((issues.body.length > 1 ) ? "Issues" : "Issue")
    puts "---"
    issues.body.each do |issue| 
      puts "#{issue.issueKey} : #{issue.summary} | href=https://#{BACKLOG_SPACE_ID}.backlog.jp/view/#{issue.issueKey}"
    end
    puts "---"
    puts "Refresh | refresh="
  end
end

gbi = GetBacklogIssues.new
gbi.getIssues



