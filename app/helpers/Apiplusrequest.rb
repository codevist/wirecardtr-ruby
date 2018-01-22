
#api plus soap servis çağrısının yapıldığı sınıfı temsil etmektedir.
# soap çağrısı sonucunda oluşan xml çıktısı sonuç olarak dönderilmektedir.
class Apiplusrequest
    def execute(input , token)

        client = Savon.client(wsdl: 'https://www.wirecard.com.tr/services/saleservice.asmx?wsdl',ssl_verify_mode: :none, ssl_version: :TLSv1) 
        input.ProductList= {'MSaleProduct' => model_to_hash(input.ProductList[0])} 
        response=  client.call(:sale_with_confirm, message: {
            'input' => model_to_hash(input),
            'token' =>  model_to_hash(token)
            })
        return response.to_xml
    end
    def model_to_hash(model_name)
        hash = model_name.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = model_name.instance_variable_get(var) }
    end
    end