require 'gcm'
api_key = 'AIzaSyAEP2Sk1M2-aFax16by2LHozu1RWNoHE0c'
gcm = GCM.new(api_key)
registration_ids= ["APA91bEx_OaRh0c9wmQ9_5y9yKHGes-2S_-PyMBPxA1IlxGlFPpkMvBVyfrbHyc1nq2_cYcS6scuBaAFj4IiYiQYfMLZdJA1u0Aa1TimBPrhL7vG2P2a0mgEFClAZX1FfyZTr4UPGSDO_93wADa_9j7tDaxPEQrWUg"] # an array of reg ids of app clients
options = {"title"=>"test", "message"=>"hello"}
response = gcm.send_notification(registration_ids, options)