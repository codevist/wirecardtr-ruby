
#pro api soap servis çağrısının yapıldığı sınıfı temsil etmektedir.
# soap çağrısı sonucunda oluşan xml çıktısı sonuç olarak dönderilmektedir.

class Proapirequest
    def execute(input , token)
        client = Savon.client(wsdl: 'https://www.wirecard.com.tr/services/saleservice.asmx?wsdl',ssl_verify_mode: :none, ssl_version: :TLSv1)   

      
        input.ProductList= {'MSaleProduct' => model_to_hash(input.ProductList[0])}
      
      
        response=  client.call(:sale_with_ticket, message: {
            'input' => model_to_hash(input),
            'token' =>  model_to_hash(token)
            })

            response_to_hash = response.to_hash
            return_redirect_url = response_to_hash[:sale_with_ticket_response ][:sale_with_ticket_result][:redirect_url]

            result_strings = Array[]
            result_strings.push(response.to_xml)
            result_strings.push(return_redirect_url)
           
        return result_strings
    end
    def model_to_hash(model_name)
        hash = model_name.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = model_name.instance_variable_get(var) }
       
    end
    end