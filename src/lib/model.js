// Generated by CoffeeScript 1.9.3
(function() {
  var Appointment, appointment, conn;

  conn = require("./dbconn");

  Appointment = (function() {
    function Appointment() {
      conn.connect();
    }

    Appointment.prototype.appointmentsByUser = function(user_id, cb) {
      return conn.query("SELECT * FROM appointment WHERE user_id='" + user_id + "'", cb);
    };

    Appointment.prototype.addAppointmentByUser = function(user_id, data, cb) {
      var SQL, appointment_date, appointment_time, kitchen_type, name, phonenum;
      name = data.name;
      phonenum = data.phonenum;
      appointment_date = data.appointment_date;
      appointment_time = data.appointment_time;
      kitchen_type = data.kitchen_type;
      SQL = "INSERT INTO appointment(user_id, kitchen_type, name,phonenum,appointment_date,appointment_time) VALUES(" + user_id + "," + kitchen_type + ",'" + name + "','" + phonenum + "','" + appointment_date + "','" + appointment_time + "') ";
      return conn.query(SQL, cb);
    };

    Appointment.prototype.deleteAppointment = function(appointment_id, cb) {
      var SQL;
      SQL = "DELETE FROM appointment WHERE id=" + appointment_id;
      return conn.query(SQL, cb);
    };

    Appointment.prototype.destroy = function() {
      return conn.end();
    };

    return Appointment;

  })();

  appointment = new Appointment();

  module.exports = appointment;

}).call(this);
