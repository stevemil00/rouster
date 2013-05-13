require sprintf('%s/../../%s', File.dirname(File.expand_path(__FILE__)), 'path_helper')

require 'json'
reqiore 'socket'

class Rouster

  # TODO we should be able to run this without upping the box in question --
  # just need to be able to talk to the same puppetmaster, which means we should 'require puppet'
  # instead of shelling out
  def get_catalog(hostname)
    certname = hostname.nil? ? Socket.gethostname() : hostname

    json = nil
    res  = self.run(sprintf('puppet catalog find %s', certname))

    begin
      json = res.to_json
    rescue
      raise InternalError.new(sprintf('unable to parse[%s] as JSON', res))
    end

    json
  end

  def run_puppet
    # TODO should we make this more flexible?
    self.run('/sbin/service puppet once -t')
  end

  def get_puppet_errors(input = nil)
    str    = input.nil? ? self.get_output() : input
    errors = str.scan(/35merr:.*/)

    errors.empty? ? nil : errors
  end

  def get_puppet_notices(input = nil)
    str     = input.nil? ? self.get_output() : input
    notices = str.scan(/36mnotice:.*/)

    notices.empty? ? nil : notices
  end

end