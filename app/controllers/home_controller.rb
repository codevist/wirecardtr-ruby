require "rexml/document"
require 'date'
 class HomeController < ApplicationController

    def index

    end

    #pro Api Action'ı  temsil eder.
    def proapi
      if request.post?

        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin 
    
        input= Soapinput.new
        input.MPAY = ""
        input.Content = "TLFN01-Telefon"
        input.SendOrderResult = true
        input.PaymentTypeId = 1
        input.ReceivedSMSObjectId = "00000000-0000-0000-0000-000000000000"

        input.ProductList = Array.new()
        p=Product.new
        p.ProductId=0
        p.ProductCategory=params[:productCategoryId]
        p.ProductDescription="Telefon"
        p.Price=0.01
        p.Unit=1
        input.ProductList << p

        input.SendNotificationSMS=true
        input.OnSuccessfulSMS="basarili odeme yaptiniz"
        input.OnErrorSMS="basarisiz odeme yaptiniz"
        input.RequestGsmOperator=0
        input.RequestGsmType=0
        input.Url="localhost:3000/home/proapi"
        input.SuccessfulPageUrl="localhost:3000/home/success"
        input.ErrorPageUrl="localhost:3000/home/fail"
        input.Country=""
        input.Currency=""
        input.Extra=""
        input.TurkcellServiceId=""
    
        req=Proapirequest.new
        proapi_result=req.execute(input,token) # soap servis çağrısının başladığı kısmı temsil etmektedir.
        doc = REXML::Document.new proapi_result[0]
        @xml_result = ""
        doc.write(@xml_result, 1) # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @redirectUrl = proapi_result[1]
      
      else
      end
    end

# api plus controller action'ı temsil etmektedir.
def apiplus
  if request.post?

    #region Token
    token= Token.new
    token.UserCode= @@settings.UserCode
    token.Pin=@@settings.Pin 
    #endregion

    #region input
    input= Soapinput.new
    input.MPAY = ""
    input.Gsm = params[:gsm]
    input.Content = "TLFN01-Telefon"
    input.SendOrderResult = true
    input.PaymentTypeId = params[:paymentTypeId]
    input.ReceivedSMSObjectId = "00000000-0000-0000-0000-000000000000"

    #region ProductList
    input.ProductList = Array.new()
    p=Product.new
    p.ProductId=0
    p.ProductCategory=params[:productCategoryId]
    p.ProductDescription="Telefon"
    p.Price=0.01
    p.Unit=1
    input.ProductList << p
    #endregion
    input.SendNotificationSMS=true
    input.OnSuccessfulSMS="basarili odeme"
    input.OnErrorSMS="basarisiz odeme"
    input.Url="localhost:3000/home/apiplus"
    input.RequestGsmOperator=0
    input.RequestGsmType=0
    input.Extra=""
    input.TurkcellServiceId=""
    input.CustomerIpAddress="127.0.0.1"
     #endregion 
    req=Apiplusrequest.new
    apiplus_result=req.execute(input,token) # soap servis çağrısının başladığı kısmı temsil etmektedir.
    doc = REXML::Document.new apiplus_result
    @xml_result = ""
    doc.write(@xml_result, 1)# servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.

  else
  end
end

#Bilgi smsi gönderim Action'ı temsil eder.
  def informationsmsservice
    if request.post?
        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin 
        #endregion

        #region Input
        input= Soapinput.new
        input.Gsm = params[:gsm]
        input.Content = params[:content]
        input.RequestGsmOperator = 0
        input.RequestGsmType = 0
        #endregion

        req=Sendinformationsmsrequest.new
        subscriberdetail_result= req.execute(input,token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new subscriberdetail_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)

    else
    end
  end

    # subscriberselect Action'ı temsil etmektedir.
    def subscriberselect
      if request.post?

        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin 
        #endregion

        #region Input
        input= Soapinput.new
        input.ProductId=0
        input.Gsm = params[:gsm]
        input.OrderChannelId = params[:orderChannelId]
        input.Active= params[:activeTypeId]
        input.SubscriberType=params[:subscriberTypeId]
        input.StartDateMin= DateTime.parse(params[:startDateMin])
        input.StartDateMax= DateTime.parse(params[:startDateMax])
        input.LastSuccessfulPaymentDateMin=DateTime.parse(params[:lastSuccessfulPaymentDateMin])
        input.LastSuccessfulPaymentDateMax= DateTime.parse(params[:lastSuccessfulPaymentDateMax])
        #endregion

        req=Selectsubscriber.new
        subscriberlist_result= req.execute(input,token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new subscriberlist_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)


      else
      end

    end


    # selectsubscriberdetail Action'ı temsil etmektedir.
    def selectsubscriberdetail
      if request.post?
        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin 
        #endregion
        req=Selectsubscriberdetail.new
        subscriberdetail_result= req.execute(params[:subscriberId],token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new subscriberdetail_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)
      else
      end
    end


    def transactionrequestorder
      if request.post?

        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin
        #endregion
        req=Transactionrequestorder.new
        transactionrequestorder_result= req.execute(params[:orderId],token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new transactionrequestorder_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)
      else
      end
    end


    def transactionrequestbympay
      if request.post?

        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin
        #endregion
        req=Transactionrequestbympay.new
        transactionrequestbympay_result= req.execute(params[:mpay],token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new transactionrequestbympay_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)
      else
      end
    end



    # selectsubscriberdetail Action'ı temsil etmektedir.
    def deactivatesubscriber
      if request.post?

        #region Token
        token= Token.new
        token.UserCode= @@settings.UserCode
        token.Pin=@@settings.Pin
        #endregion
        req=Deactivesubscriber.new
        subscriberdeactive_result= req.execute(params[:subscriberId],token) # soap servis çağrısının başladığı kısmı temsil etmektedir.

        doc = REXML::Document.new subscriberdeactive_result # servis sonucunda oluşan cevabın ekranda gösterilmek üzere değişkene eklendiği kısımdır.
        @xml_result = ""
        doc.write(@xml_result, 1)
      else
      end
    end


     # ccproxysale3dform Action'ı temsil etmektedir.
     def ccproxysale3dform
      if request.post?
        req= Ccproxysale3dequest.new
        req.ServiceType = "CCProxy"
        req.OperationType = "Sale3DSEC"
        req.MPAY = ""
        req.IPAddress = "127.0.0.1";
        req.PaymentContent = "BLGSYR01"
        req.InstallmentCount =params[:installmentCount] 
        req.Description = "Bilgisayar"
        req.ExtraParam = ""
        req.Port = "123"
        req.ErrorURL = "http://localhost:3000/home/fail"
        req.SuccessURL = "http://localhost:3000/home/success"
        #region Token
        req.Token = Token.new
        req.Token.UserCode = @@settings.UserCode
        req.Token.Pin = @@settings.Pin 
        #endregion
        #region CreditCardInfo
        req.Creditcardinfo = Creditcardinfo.new
        req.Creditcardinfo.CreditCardNo = params[:creditCardNo]
        req.Creditcardinfo.OwnerName =params[:ownerName] 
        req.Creditcardinfo.ExpireYear =params[:expireYear] 
        req.Creditcardinfo.ExpireMonth =params[:expireMonth] 
        req.Creditcardinfo.Cvv =params[:cvv] 
        req.Creditcardinfo.Price = "1";#0,01 TL
        #endregion
         #region CardTokenization
         req.Cardtokenization = Cardtokenization.new
         req.Cardtokenization.RequestType ="0"
         req.Cardtokenization.CustomerId ="01"
         req.Cardtokenization.ValidityPeriod ="0"
         req.Cardtokenization.CCTokenId =SecureRandom.uuid
         
         #endregion 
        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
      
      else
      end
    end


     # ccproxysaleform Action'ı temsil etmektedir.
    def ccproxysaleform
      if request.post?
        req= Ccproxysalerequest.new
        req.ServiceType = "CCProxy"
        req.OperationType = "Sale"
        req.MPAY = ""
        req.IPAddress = "127.0.0.1";
        req.PaymentContent = "BLGSYR01"
        req.InstallmentCount =params[:installmentCount] 
        req.Description = "Bilgisayar"
        req.ExtraParam = ""
        req.Port = "123"
        #region Token
        req.Token = Token.new
        req.Token.UserCode = @@settings.UserCode
        req.Token.Pin = @@settings.Pin 
        #endregion
        #region CreditCardInfo
        req.Creditcardinfo = Creditcardinfo.new
        req.Creditcardinfo.CreditCardNo = params[:creditCardNo]
        req.Creditcardinfo.OwnerName =params[:ownerName] 
        req.Creditcardinfo.ExpireYear =params[:expireYear] 
        req.Creditcardinfo.ExpireMonth =params[:expireMonth] 
        req.Creditcardinfo.Cvv =params[:cvv] 
        req.Creditcardinfo.Price = "1";#0,01 TL
        #endregion
         #region CardTokenization
         req.Cardtokenization = Cardtokenization.new
         req.Cardtokenization.RequestType ="0"
         req.Cardtokenization.CustomerId ="01"
         req.Cardtokenization.ValidityPeriod ="0"
         req.Cardtokenization.CCTokenId =SecureRandom.uuid
         
         #endregion 
        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
      
      else
      end
    end
 # wdticketsale3durlproxy Action'ı temsil etmektedir.
    def wdticketsale3durlproxy
      if request.post?
        req= Wdticketsale3durlproxy.new
        req.ServiceType = "WDTicket";
        req.OperationType = "Sale3DSURLProxy";
        req.Price = "1"; #0,01 TL
        req.MPAY = "";
        req.ErrorURL = "http://localhost:3000/home/Fail";
        req.SuccessURL = "http://localhost:3000/home/Success";
        req.ExtraParam = "";
        req.PaymentContent = "Bilgisayar";
        req.Description = "BLGSYR01";
         #region Token
         req.Token = Token.new
         req.Token.UserCode = @@settings.UserCode
         req.Token.Pin = @@settings.Pin 
         #endregion
         @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
         #p @returnData
         @url= OpenStruct.new(OpenStruct.new(Hash.from_xml(@returnData) ).Result).Item[3]["Value"]


      else
      end
    end
    # wdticketsaleurlproxy Action'ı temsil etmektedir.
    def wdticketsaleurlproxy
      if request.post?
        req= Wdticketsale3durlproxy.new
        req.ServiceType = "WDTicket";
        req.OperationType = "SaleURLProxy";
        req.Price = "1"; #0,01 TL
        req.MPAY = "";
        req.ErrorURL = "http://localhost:3000/home/Fail";
        req.SuccessURL = "http://localhost:3000/home/Success";
        req.ExtraParam = "";
        req.PaymentContent = "Bilgisayar";
        req.Description = "BLGSYR01";
         #region Token
         req.Token = Token.new
         req.Token.UserCode = @@settings.UserCode
         req.Token.Pin = @@settings.Pin 
         #endregion
         @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
         @url= OpenStruct.new(OpenStruct.new(Hash.from_xml(@returnData) ).Result).Item[3]["Value"]

      else
      end
    end

    #MarketPlaceAddSubPartner Action'ı temsil etmektedir.
    def marketplaceaddsubpartner
        if request.post?
          req= Marketplaceaddorupdaterequest.new   
          req.ServiceType = "CCMarketPlace"
          req.OperationType = "AddSubPartner"
          req.SubPartnerType=params[:subPartnerType]  
          req.UniqueId = SecureRandom.uuid
          req.Name = params[:name];
          #region Token
          req.Token = Token.new
          req.Token.UserCode=@@settings.UserCode
          req.Token.Pin=@@settings.Pin 
          #end Region
          #region Contactinfo Bilgileri
          req.Contactinfo= Contactinfo.new
          req.Contactinfo.Country = "TR"
          req.Contactinfo.City = "34"
          req.Contactinfo.Address = "Gayrettepe Mh. Yıldız Posta Cd. D Plaza No:52 K:6 34349 Beşiktaş / İstanbul"
          req.Contactinfo.MobilePhone =params[:mobilePhoneNumber] 
          req.Contactinfo.BusinessPhone = "2121111111"
          #endregion
          #region Financialinfo Bilgileri
          req.Financialinfo = Financialinfo.new
          req.Financialinfo.IdentityNumber =params[:identityNumber]  
          req.Financialinfo.TaxOffice = "İstanbul"
          req.Financialinfo.TaxNumber = "11111111111"
          req.Financialinfo.BankName = "0012"
          req.Financialinfo.IBAN = "TR330006100519786457841326"
          req.Financialinfo.AccountName = "Ahmet Yılmaz"
          @returnData= req.executeAddSubPartner(req,@@settings) # xml servis çağrısının başladığı kısım
        else
      end
    end

    #MarketPlaceUpdateSubPartner Action'ı temsil etmektedir.
    def marketplaceupdatesubpartner
      if request.post?
        req= Marketplaceaddorupdaterequest.new   
        req.ServiceType = "CCMarketPlace"
        req.OperationType = "UpdateSubPartner"
        req.UniqueId = SecureRandom.uuid
        req.Name = params[:name];
        req.SubPartnerType=params[:subPartnerType]  
        req.SubPartnerId = params[:subPartnerId];
        #region Token
        req.Token = Token.new
        req.Token.UserCode=@@settings.UserCode
        req.Token.Pin=@@settings.Pin 
        #end Region
        #region Contactinfo Bilgileri
        req.Contactinfo= Contactinfo.new
        req.Contactinfo.Country = "TR"
        req.Contactinfo.City = "34"
        req.Contactinfo.Address = "Gayrettepe Mh. Yıldız Posta Cd. D Plaza No:52 K:6 34349 Beşiktaş / İstanbul"
        req.Contactinfo.MobilePhone =params[:mobilePhoneNumber] 
        req.Contactinfo.BusinessPhone = "2121111111"
        #endregion
        #region Financialinfo Bilgileri
        req.Financialinfo = Financialinfo.new
        req.Financialinfo.IdentityNumber =params[:identityNumber]  
        req.Financialinfo.TaxOffice = "İstanbul"
        req.Financialinfo.TaxNumber = "11111111111"
        req.Financialinfo.BankName = "0012"
        req.Financialinfo.IBAN = "TR330006100519786457841326"
        req.Financialinfo.AccountName = "Ahmet Yılmaz"
        @returnData= req.executeUpdateSubPartner(req,@@settings) # xml servis çağrısının başladığı kısım
      else
    end
    end

    #market place deactive Action'ı temsil etmektedir.
    def marketplacedeactivesubpartner
      if request.post?

        req= Marketplacedeactivesubpartnerrequest.new
        req.ServiceType="CCMarketPlace"
        req.OperationType="DeactivateSubPartner"
        #region Token
        req.Token = Token.new
        req.Token.UserCode=@@settings.UserCode
        req.Token.Pin=@@settings.Pin 
        #end Region

        req.UniqueId=params[:uniqueId]
        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
      else
      end
    end

    #marketPlace 3D Secure Action'ı temsil etmektedir.
    def marketplacesale3dsec
      if request.post?

        req= Marketplacesale3dsecurerequest.new
        req.ServiceType = "CCMarketPlace"
        req.OperationType = "Sale3DSEC"
        req.MPAY = ""
        req.IPAddress = "127.0.0.1";
        req.Port = "123"
        req.Description = "Bilgisayar"
        req.InstallmentCount =params[:installmentCount] 
        req.CommissionRate = "100"; #komisyon oranı 1. 100 ile çarpılıp gönderiliyor
        req.ExtraParam = ""
        req.PaymentContent = "BLGSYR01"
        req.SubPartnerId = params[:subPartnerId]
        req.ErrorURL = "http://localhost:3000/home/MarketPlaceError"
        req.SuccessURL = "http://localhost:3000/home/MarketPlaceSuccess"
        #region Token
        req.Token = Token.new
        req.Token.UserCode = @@settings.UserCode
        req.Token.Pin = @@settings.Pin 
        #endregion
        #region CreditCardInfo
        req.Creditcardinfo = Creditcardinfo.new
        req.Creditcardinfo.CreditCardNo = params[:creditCardNo]
        req.Creditcardinfo.OwnerName =params[:ownerName] 
        req.Creditcardinfo.ExpireYear =params[:expireYear] 
        req.Creditcardinfo.ExpireMonth =params[:expireMonth] 
        req.Creditcardinfo.Cvv =params[:cvv] 
        req.Creditcardinfo.Price = "1";#0,01 TL
        #endregion
         #region CardTokenization
         req.Cardtokenization = Cardtokenization.new
         req.Cardtokenization.RequestType ="0"
         req.Cardtokenization.CustomerId ="01"
         req.Cardtokenization.ValidityPeriod ="0"
         req.Cardtokenization.CCTokenId =SecureRandom.uuid
         
         #endregion
        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
      else
      end
    end
    #marketplacempsale Action'ı temsil etmektedir.
    def marketplacempsale
      if request.post?
        req= Marketplacempsalerequest.new
        req.ServiceType = "CCMarketPlace"
        req.OperationType = "MPSale"
        req.Price = "1";#0,01 TL
        req.MPAY = "01"
        req.IPAddress = "127.0.0.1";
        req.Port = "123"
        req.Description = "Bilgisayar"
        req.InstallmentCount =params[:installmentCount] 
        req.CommissionRate = "100"; #komisyon oranı 1. 100 ile çarpılıp gönderiliyor
        req.ExtraParam = ""
        req.PaymentContent = "BLGSYR01"
        req.SubPartnerId = params[:subPartnerId]
        req.ErrorURL = "http://localhost:3000/home/fail"
        req.SuccessURL = "http://localhost:3000/home/success"
        #region Token
        req.Token = Token.new
        req.Token.UserCode = @@settings.UserCode
        req.Token.Pin = @@settings.Pin 
        #endregion
        #region CreditCardInfo
        req.Creditcardinfo = Creditcardinfo.new
        req.Creditcardinfo.CreditCardNo = params[:creditCardNo]
        req.Creditcardinfo.OwnerName =params[:ownerName] 
        req.Creditcardinfo.ExpireYear =params[:expireYear] 
        req.Creditcardinfo.ExpireMonth =params[:expireMonth] 
        req.Creditcardinfo.Cvv =params[:cvv] 
        #endregion

        #region CardTokenization
        req.Cardtokenization = Cardtokenization.new
        req.Cardtokenization.RequestType ="0"
        req.Cardtokenization.CustomerId ="01"
        req.Cardtokenization.ValidityPeriod ="0"
        req.Cardtokenization.CCTokenId =SecureRandom.uuid
        
        #endregion 

        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
        p @returnData
      else
      end
    end



    
    #marketplacereleasepayment Action'ı temsil etmektedir.
    def marketplacereleasepayment
      if request.post?
        req= Marketplacereleasepaymentrequest.new
        req.ServiceType = "CCMarketPlace"
        req.OperationType = "ReleasePayment"
        req.SubPartnerId =params[:subPartnerId]  
        req.CommissionRate = "100"; #%1
        req.MPAY = ""
        req.OrderId=SecureRandom.uuid
        req.Description = "Bilgisayar ödemesi"
        #region Token
        req.Token = Token.new
        req.Token.UserCode = @@settings.UserCode
        req.Token.Pin = @@settings.Pin 
        #endregion
      
        @returnData= req.execute(req,@@settings) # xml servis çağrısının başladığı kısım
        p @returnData
      else
      end
    end

    def success
    end
    def fail
    end

   


end