conn = require "./dbconn"

class Appointment

    constructor: ->
        conn.connect()


    appointmentsByUser: (user_id, cb) ->
        conn.query "SELECT * FROM appointment WHERE user_id='"+user_id+"'", cb




    addAppointmentByUser:(user_id, data, cb) ->
        name = data.name
        phonenum = data.phonenum
        appointment_date = data.appointment_date
        appointment_time = data.appointment_time
        kitchen_type = data.kitchen_type


        SQL = "INSERT INTO appointment(user_id, kitchen_type, name,phonenum,appointment_date,appointment_time)
            VALUES("+user_id+","+kitchen_type + ",'"+ name+"','"+phonenum+"','"+appointment_date+"','"+appointment_time+"') "

#        console.log SQL

        conn.query  SQL, cb

    deleteAppointment: (appointment_id, cb) ->

        SQL = "DELETE FROM appointment WHERE id="+ appointment_id
        conn.query SQL, cb


    destroy: ->
        conn.end()

appointment = new Appointment()

module.exports = appointment
