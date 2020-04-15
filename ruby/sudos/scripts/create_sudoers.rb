require_relative '../../texts/one_time_script'

module Sudos
  module Scripts
    class CreateSudoers < Texts::OneTimeScript
      def body
        [          
          write(:runtime),
          write(:install)
        ].join("\n")
      end

      def write(sym)
        context.send(sym).map do |c|
          %Q(
           echo $ContUser 'ALL=(ALL)' NOPASSWD: #{c} >> /etc/sudoers.d/#{sym}
           echo >> /etc/sudoers.d/#{sym}
          )
        end.join("\n")
      end

    end
  end
end
