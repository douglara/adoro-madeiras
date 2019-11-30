class SmsService
  def initialize()
    @sns = Aws::SNS::Resource.new(region: 'us-east-1')
  end

  def create_topic(phone)
    @sns.create_topic(name: phone)
  end

  def send_notification(phone, message)
    if topic = create_topic(phone)
      topic.subscribe(
        protocol: 'sms',
        endpoint: "+55#{phone}"
      )
      @message_id = topic.publish(
        message: message
      )
    end
    @message_id
  end
end
