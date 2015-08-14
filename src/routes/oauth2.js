/**
 * Created by sunset on 15/8/12.
 */


var TokenManager = require("../lib/dictionary");
var express = require('express');
var util = require('util');
var request = require('request');

var config = require('../config');

var tokenManager = new TokenManager();


router = express.Router();



router.get('/', function(req, res, next) {
    //var state = "DemoUser";
    //console.log(req.session);
    //console.log(req.sessionID);
    var state = req.sessionID;

    //console.log( "state:" + state ) ;

    if(null == tokenManager.fetch(state)) {
        var url = util.format('%s?response_type=code&client_id=%s&redirect_uri=%s&scope=basic&state=%s#oauth2_redirect'
            , config.API_AUTHORIZE_SERVICE_URI, config.API_KEY, encodeURIComponent(config.CLIENT_REDIRECT_URI), state)
        res.redirect(url);
    } else {
        //res.redirect('/result');
        next();
    }

});

router.get('/redirect', function(req, res, next) {
    var code = req.param("code");
    var state = req.param("state");
    var credential_buf = new Buffer(util.format("%s:%s", config.API_KEY, config.API_SECRET));

    var body = {
        "grant_type":"authorization_code",
        "code": code,
        "redirect_uri": config.CLIENT_REDIRECT_URI,
        "client_id": config.API_KEY
    }
    //var body = util.format("grant_type=authorization_code&code=%s&redirect_uri=%s&client_id=%s"
    //    , code, encodeURIComponent(CLIENT_REDIRECT_URI), API_KEY);

    var options = {
        url: config.API_TOKEN_SERVICE_URI,
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": util.format("Basic %s", credential_buf.toString('base64'))
        },
        form:body
    }

    request.post(options, function (error, response, data){
        if (!error && response.statusCode == 200) {
            var authResp = JSON.parse(data);
            //console.log("auth ok:" + authResp.access_token);
            tokenManager.store(state, authResp.access_token);
            //res.redirect('/result');
            saveUserInfo(req, res, next);



        } else {
            //console.log(response);
            res.send("error:" + error);
        }
    });
});

var saveUserInfo = function(req, res, next){


    var state = req.sessionID;
    var token = tokenManager.fetch(state);
    var url = util.format("%s/getUserInfo", config.API_OAUTH2API_URI);
    if(token == null) {
        res.send("get token error");
        return;
    }

    //console.log(req.sessionID);

    var token_buf = new Buffer(token);

    var options = {
        uri: url,
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": util.format("Bearer %s", token_buf.toString('base64'))
        }
    }

    request.post(options, function (error, response, data){
        if (!error && response.statusCode == 200) {

            data = JSON.parse(data);

            req.session['user'] = {
                user_id: data.response.id,
                name: data.response.nickName,
                phonenum: data.response.phones[0] || "用户未填"
            }

            res.redirect("/")

        } else {
            //console.log("get token error");
            //console.log(response);
            tokenManager.remove(token);
            res.send("get token error")
        }
    }).end();


}

//router.get('/result', function(req, res, next) {
//    //var state = "DemoUser";
//    var state = req.sessionID;
//    var token = tokenManager.fetch(state);
//    var url = util.format("%s/getUserInfo", API_OAUTH2API_URI);
//    if(token == null) {
//        res.send("get token error");
//        return;
//    }
//
//    //console.log(req.sessionID);
//
//    var token_buf = new Buffer(token);
//
//    var options = {
//        uri: url,
//        headers: {
//            "Content-Type": "application/x-www-form-urlencoded",
//            "Authorization": util.format("Bearer %s", token_buf.toString('base64'))
//        }
//    }
//
//    request.post(options, function (error, response, data){
//        if (!error && response.statusCode == 200) {
//            //console.log("ok:" + JSON.stringify(data));
//            res.send(data);
//        } else {
//            //console.log("get token error");
//            //console.log(response);
//            tokenManager.remove(token);
//            res.send("get token error")
//        }
//    }).end();
//
//});


module.exports = router
