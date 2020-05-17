require 'httparty'
require 'rspec'

Given("Send API to CreateBooking successfully and send API to deleteBooking") do
    #create booking endpoint
    optionsCreateBooking = {
        header: {
            "Content-Type" => 'application/json'
        },
        body: {
            "firstname" => "Fajar",
            "lastname" => "Anshari",
            "totalprice" => 2000,
            "depositpaid" => true,
            "bookingdates" => {
            "checkin" => "2020-01-01",
            "checkout" => "2021-01-01"
            },
            "additionalneeds" => "Double Pillow"
        }
    }
    responseCreateBooking = HTTParty.post('https://restful-booker.herokuapp.com/booking', optionsCreateBooking)
    expect(responseCreateBooking.code).to eq(200)
    bookingId =  responseCreateBooking.parsed_response["bookingid"]
    #auth endpoint
    optionsAuth = {
        header: {
            'Content-Type' => 'application/json'
        },
        body: {
            "username" => "admin",
            "password" => "password123"
        }
    }
    responseAuth = HTTParty.post('https://restful-booker.herokuapp.com/auth', optionsAuth)
    tokenAuth = responseAuth.parsed_response["token"]
    auth = 'token='+tokenAuth
    #delete endpoint
    optionsDeleteBooking = {
        headers: {
            "Content-Type" => 'application/json',
            "Cookie" => auth
        }
    }
    uri = 'https://restful-booker.herokuapp.com/booking/'+bookingId.to_s
    responseDeleteBooking = HTTParty.delete(uri, optionsDeleteBooking)
    expect(responseDeleteBooking.code).to eq(201)
  end
