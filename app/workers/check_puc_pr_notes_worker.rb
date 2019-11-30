class CheckPucPrNotesWorker
  include Sidekiq::Worker
  require 'digest/md5'

  def perform(*args)
    users = User.all
    pucservice = PucprService.new
    users.each do | user |
      if !user.cookies.blank?
        notes = pucservice.get_notes(user)
        if (notes[:result])
          notes_md5 = Digest::MD5.hexdigest(notes[:body])
          if (user.notes_encrypted == nil)
            user.update(notes_encrypted: notes_md5)
          else
            if (user.notes_encrypted != notes_md5 )
              user.update(notes_encrypted: notes_md5)
              # Notifica o user que foi atualizado
              puts('Notas atualizadas')
              UserMailer.notes_updated(user).deliver_now!
            end
          end
        end
      end
    end 
  end
end
