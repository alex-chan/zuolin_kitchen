dateObj = new Date()
milSec = dateObj.getTime()

getDay = (daysSinceToday) ->

    newMilSec = milSec + 24 * 60 * 60 * 1000 * daysSinceToday
    newDate = new Date(newMilSec)
    return newDate


$.fn.dateAppointment = ->


    d1 = getDay(1)
    d2 = getDay(2)
    d3 = getDay(3)
    d4 = getDay(4)



    tayText1 =   dateObj.getMonth()+1 + "/" + dateObj.getDate()
    tayText2 =  (d1.getMonth()+1) + "/" + d1.getDate()
    tayText3 =  (d2.getMonth()+1) + "/" + d2.getDate()
    tayText4 =  (d3.getMonth()+1) + "/" + d3.getDate()
    tayText5 =  (d4.getMonth()+1) + "/" + d4.getDate()

    d0Val = dateObj.getFullYear() + "-" + ("0" + (dateObj.getMonth()+1) ).slice(-2) + "-" +   ("0" + dateObj.getDate()).slice(-2)
    d1Val = d1.getFullYear() + "-" + ("0" + (d1.getMonth()+1) ).slice(-2) + "-" +   ("0" + d1.getDate()).slice(-2)
    d2Val = d2.getFullYear() + "-" + ("0" + (d2.getMonth()+1) ).slice(-2) + "-" +   ("0" + d2.getDate()).slice(-2)
    d3Val = d3.getFullYear() + "-" + ("0" + (d3.getMonth()+1) ).slice(-2) + "-" +   ("0" + d3.getDate()).slice(-2)
    d4Val = d4.getFullYear() + "-" + ("0" + (d4.getMonth()+1) ).slice(-2) + "-" +   ("0" + d4.getDate()).slice(-2)




    dayList = ["日","一","二","三","四","五","六"]

    day3 = "星期" + dayList[getDay(3).getDay()]
    day4 = "星期" + dayList[getDay(4).getDay()]

    this.children(":nth-child(1)").text("今天"+ tayText1).val d0Val
    this.children(":nth-child(2)").text("明天"+ tayText2).val d1Val
    this.children(":nth-child(3)").text("后天"+ tayText3).val d2Val
    this.children(":nth-child(4)").text(day3 + tayText4).val d3Val
    this.children(":nth-child(5)").text(day4 + tayText5).val d4Val


    return







