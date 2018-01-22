#Tüm soap servis çağrılarında kullanılacak olan alanların tanımlandığı sınıfı temsil etmektedir.
class Soapinput

    attr_accessor :Content; 
    attr_accessor :Gsm;
    attr_accessor :RequestGsmOperator; 
    attr_accessor :RequestGsmType; 
    attr_accessor :MPAY; 
    attr_accessor :SendOrderResult; 
    attr_accessor :PaymentTypeId; 
    attr_accessor :ReceivedSMSObjectId; 
    attr_accessor :ProductList;
    attr_accessor :SendNotificationSMS; 
    attr_accessor :OnSuccessfulSMS;
    attr_accessor :OnErrorSMS; 
    attr_accessor :Url; 
    attr_accessor :SuccessfulPageUrl; 
    attr_accessor :ErrorPageUrl; 
    attr_accessor :Country; 
    attr_accessor :Currency; 
    attr_accessor :Extra;
    attr_accessor :TurkcellServiceId;
    attr_accessor :CustomerIpAddress;
    attr_accessor :BeginDate;
    attr_accessor :EndDate;
    attr_accessor :ProductId;
    attr_accessor :OrderChannelId;
    attr_accessor :Active;
    attr_accessor :SubscriberType;
    attr_accessor :StartDateMin;
    attr_accessor :StartDateMax;
    attr_accessor :LastSuccessfulPaymentDateMin;
    attr_accessor :LastSuccessfulPaymentDateMax;
    attr_accessor :SubscriberId;
end