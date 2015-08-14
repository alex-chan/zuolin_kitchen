express = require 'express'

appointment = require '../lib/model'

router = express.Router()

router.delete "/appointments/:id", (req, res, next) ->

    apt_id =  req.params.id


    res.set 'Content-Type', 'application/json'

    if not req.session.user
        res.statusCode = 401
        res.send
            errno: 401
            message: "Unauthorized."
        return



    appointment.appointmentsByUser req.session.user.user_id, (err, rows, fields) ->
        if err
            res.statusCode = 500
            res.send
                errno: 500
                message:  "Query appointment error " + err.code

            return

        num = (item for item in rows when item.id == parseInt(apt_id) )

        if num.length > 0
            appointment.deleteAppointment apt_id, (err, result) ->
                if err
                    res.statusCode = 500
                    res.send
                        errno: 500
                        message:  "取消预约失败: " + err.code

                    return

                res.statusCode = 200 #204 ?
                res.send
                    errno: 0
                    message: "成功取消预约"
                return


            return


        res.statusCode = 200 # or 404
        res.send
            errno: 404
            message: "取消错误，找到不该预约记录"



router.get "/appointments",  (req, res, next) ->

    res.set 'Content-Type', 'application/json'

    if not req.session.user
        res.statusCode = 401
        res.send
            code: 401
            error: "Unauthorized."
        return


    appointment.appointmentsByUser req.session.user.user_id, (err, rows, fields) ->
        if err
            console.log err
            res.statusCode = 500

            res.send
                errno: 500
                message:  "Database error " + err.code

            return


        res.send
            errno: 0
            data: rows



router.post "/appointments",  (req, res, next) ->

    res.set 'Content-Type', 'application/json'

    if not req.session.user
        res.statusCode = 401
        res.send
            errno: 401
            message: "Unauthorized."
        return


    user = req.session.user


    data =
        name : user.name
        phonenum: req.body["phonenum"]
        appointment_date: req.body["appointment_date"]
        appointment_time: req.body["appointment_time"]
        kitchen_type: req.body["kitchen_type"]




    appointment.addAppointmentByUser req.session.user.user_id, data, (err, out) ->
        if err
            console.log err
            res.statusCode = 500
            res.send
                errno: 500
                message: "Database error " + err.code

            return

        res.statusCode = 201
        res.send
            errno: 0
            data: "Created"

    return


router.get "/user/info", (req, res, next) ->

    apt_id =  req.params.id


    res.set 'Content-Type', 'application/json'

    if not req.session.user
        res.statusCode = 401
        res.send
            errno: 401
            error: "Unauthorized."
        return

    user = req.session.user

    res.send
        errno: 0
        data:
            user_id: user.user_id
            name: user.name
            phonenum: user.phonenum



#
#
#router.get '/user/:id/appointments',  (req, res, next) ->
#
#    user_id =  req.params.id
#
#    appointment = new Appointments()
#
#
#    res.send "appointments"
#    return
#
#router.post '/user/:id/appointments', (req, res, next) ->
#
#    console.log res.params
#    return
#


module.exports = router
