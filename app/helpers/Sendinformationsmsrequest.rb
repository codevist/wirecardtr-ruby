#bilgi sms gönderme soap servis çağrısının yapıldığı sınıfı temsil etmektedir.
# soap çağrısı sonucunda oluşan xml çıktısı sonuç olarak dönderilmektedir.
class Sendinformationsmsrequest
    
    def execute(input , token)

        client = Savon.client(wsdl: 'http://vas.mikro-odeme.com/services/msendsmsservice.asmx?wsdl')   
        response=  client.call(:send_sms, message: {
            'input' => model_to_hash(input),
            'token' =>  model_to_hash(token)
            })
            
        return response.to_xml
    end
    def model_to_hash(model_name)
        hash = model_name.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = model_name.instance_variable_get(var) }
    end
    end