# Juniper filter
# filter define to process the structured syslog messages 
# splits the key value pairs in the syslog messages to store 
# each values. The unstructured data is dropped.
# This helps avoid the use of grok filters, which is slow in performance.
#
# @author ahzam
#

require "logstash/filters/base"
require "logstash/namespace"
require "set"
require "socket"
require "java"

java_import 'java.util.regex.Pattern'

class LogStash::Filters::SplitSyslog < LogStash::Filters::Base

  config_name "splitsyslog"
  plugin_status "stable"

  # The address to listen on.
  config :myIp, :validate => :string, :default => "127.0.0.1"

  public
  def initialize(config = {})
    super
    @threadsafe = true
  end # def initialize

  public
  def register
 #nothing to do here
  end # def register

  public
  def filter(event)
    return unless filter?(event)
    @logger.debug("SplitSyslog", :message => event["message"])
    if !event["message_mod"].nil?
# regex to extract a group of key=value pairs
        matchPattern = "(?:^|\\s*)(?:([^\\s=]+)=\"([^\"]+))\"(?:\\s*|$)"
        # Java pattern class
        pattern = Pattern.compile (matchPattern)
        matches = pattern.matcher(event["message_mod"])
        # find all matching key value pairs
        while matches.find() do 
	     key = matches.group(1)
             value = matches.group(2)
#    remove the following - to _ tranlation gain about 5% translation performance
	     if key == "message"
		key = "log_message"
	     else 
                key = key.tr("-","_")
	     end #if
	     event[key] = value
             @logger.debug("SlotSyslog", :message => event[key])
         end # end while loop
         event.remove("message_mod")
         # insert this log collector's IP 
         event["receiving_host"] = myIp
    end # message_mod is not null

    if !event.cancelled?
      filter_matched(event)
    end # if
  end # def filter
end # class LogStash::Filters::SplitSyslog

