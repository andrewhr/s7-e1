require 'rubygems'

module ProcessStatus

  ##
  # Display Growl notifications. Extracted from autotest-growl
  class Growl
    GEM_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

    ##
    # Display a message through Growl.
    def self.growl(title, message, priority=0, sticky=false)
      growl = File.join(GEM_PATH, 'growl', 'growlnotify')
      sender = 'psgraph'
      case Config::CONFIG['host_os']
      when /mac os|darwin/i
        options = %(-n "#{sender}" -p #{priority} -m "#{message}" "#{title}" #{'-s' if sticky})
        system %(#{growl} #{options} &)
      when /linux|bsd/i
        options = %("#{title}" "#{message}" -t 5000)
        system %(notify-send #{options})
      when /windows|mswin|mingw|cygwin/i
        growl += '.com'
        options = %(/a:"#{sender}" /p:#{priority} /t:"#{title}" /s:#{sticky} /silent:true)
        options << %( /r:"#{sender}-failed","#{sender}-passed","#{sender}-pending","#{sender}-error")
        system %(#{growl} #{message.inspect} #{options})
      else
        raise "#{Config::CONFIG['host_os']} is not supported by psgraph-growl (feel free to submit a patch)" 
      end
    end

  end

end
