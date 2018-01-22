#Pazaryeri silmexml servis çağrısının yapıldığı sınıfı temsil etmektedir.
#Marketplaceaddorupdaterequest sınıfına ait değişkenler bu sınıf içerisinde toplanmıştır.
#Xml formatı oluşturularak settings sınıfı içerisinde bulunan baseurl adresine post edilmektedir.
#xml  çağrısı sonucunda oluşan xml çıktısı sonuç olarak dönderilmektedir.

class Marketplacedeactivesubpartnerrequest

    attr_accessor :ServiceType
    attr_accessor :OperationType
    attr_accessor :Token
    attr_accessor :UniqueId

    def execute(req,settings)
        result= Core::HttpClient::post(settings.BaseUrl,self.to_xml(req));
       if result != nil
         return result
       else
         return "Result is NIL"
       end
     end

     def to_xml(req)
        xml_string= "<?xml version='1.0' encoding='UTF-8' ?>
        <WIRECARD>
        <ServiceType>"+req.ServiceType+"</ServiceType>
        <OperationType>"+req.OperationType+"</OperationType>
        <Token>
            <UserCode>" +req.Token.UserCode+"</UserCode>
            <Pin>" +req.Token.Pin+"</Pin>
        </Token>
        <UniqueId>"+req.UniqueId+"</UniqueId>
        </WIRECARD>"
        return xml_string
     end
end