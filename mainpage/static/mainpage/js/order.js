function initialOrdersTables{


    //从数据库加载订单数据
    $.post("/mainpage/get_my_threemonth_order",{},function(data,status){
        var obj=JOSN.parse(data);
        var objArray=obj.order_array;
        var array_len=objArray.length;
        for(int i=0;i<array_len;i++){//处理每一个订单
            var orderNum=objArray[i].order_num;
            var orderTime=objArray[i].order_time;
            var orderStatus=objArray[i].status;
            var orderTotalPrice=objArray[i].total_price;
            var shopName=objArray[i].shop_name;
            var foodsArray=objArray[i].mechandise_array;
            var foodsLen=foodsArray.length;
            $('<table id="customers"></table>').appendTo("orders-list");
            var aTableHead='<thead><th colspan="6" class="shop-name-th"><div><ul><li><span class="date">'+
                        orderTime+'</span>&nbsp;&nbsp;&nbsp;订单号<span class="order-num">'+orderNum+'</span></li><li><span class="shop-name">'+
                        shopName+'</span></li><li><button class="btn-link">删除</button></li></ul></div></th></thead>';
            var $lastTable= $(".orders-list").children("#customers:last");
            $lastTable.append(aTableHead);
            $lastTable.append('<tbody><tr><td colspan="3" class="description"></td></tr><tbody>');
            var firstColum='<table class="inner-customers"><tbody></tbody></table>';
            var $description=$lastTable.find(".description");
            $description.append(firstColum);
            $firstTdBody=$lastTable.children(".inner-customers tbody");


            for(int j=0;j<foodsLen;j++){//处理每一个订单中的每一个商品；
                var imgPath=foodsArray[j].image;
                var foodName=foodsArray[j].title;
                var count=foodsArray[j].merchan_num;
                var price=foodsArray[j].price;

                var aInnerRow='<tr><ul><li><img src='+imgPath+' class="food-img"></li><li><div><p>'+foodName+
                                '</p><p><span class="count">'+count+'</span><span class="multiply">x</span><span class="dollar">'+
                                price+'</span></p></div></li></ul><div class="clearfix"></div></tr>';
                $.firstTdBody.append(aInnerRow);
            }
            var otherTds=''



        }

    })



}