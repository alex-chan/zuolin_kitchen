config =
    DB_HOST: "localhost"
    DB_NAME: "zuolin_kitchen"
    DB_USER: "kitchen"
    DB_PASSWORD: "kitchen123"
    DB_PORT:   3306

    API_KEY : "d80e06ca-3766-11e5-b18f-b083fe4e159f"
    API_SECRET : "g1JOZUM3BYzWpZD5Q7p3z+i/z0nj2TcokTFx2ic53FCMRIKbMhSUCi7fSu9ZklFCZ9tlj68unxur9qmOji4tNg=="

#    API_AUTHORIZE_SERVICE_URI : "http://everhomes.asuscomm.com:16666/oauth2/authorize"
#    API_TOKEN_SERVICE_URI : "http://everhomes.asuscomm.com:16666/oauth2/token"
#    API_OAUTH2API_URI : "http://everhomes.asuscomm.com:16666/oauth2api"
#    CLIENT_REDIRECT_URI : "http://192.168.100.217:3001/redirect"


    API_AUTHORIZE_SERVICE_URI: "http://jyjy.zuolin.com/oauth2/authorize"
    API_TOKEN_SERVICE_URI: "http://jyjy.zuolin.com/oauth2/token"
    API_OAUTH2API_URI: "http://jyjy.zuolin.com/oauth2api"

    CLIENT_REDIRECT_URI: "http://zuolin.v-find.com:3001/redirect"


module.exports = config
