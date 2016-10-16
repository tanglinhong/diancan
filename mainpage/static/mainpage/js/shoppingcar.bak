function getCookie(name) {
    var cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        var cookies = document.cookie.split(';');
        for (var i = 0; i < cookies.length; i++) {
            var cookie = jQuery.trim(cookies[i]);
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}
var csrftoken = getCookie('csrftoken');

function recalculateTotalPrice($table) {
    var totalPrice = 0;
    $table.children("tbody").children("tr").each(function () {
        var count = parseInt($(this).find("span.count").text());
        // alert(count);
        var singlePrice = parseInt($(this).find("span.dollar").text());

        //alert(singlePrice);
        totalPrice += count * singlePrice;


    });
    var deliverFee = parseInt($table.find("span.deliver-dollar").text());
    totalPrice += deliverFee;


    //alert(totalPrice);
    $table.find("span.total-price").text(totalPrice);
}


var total_price;

function initialTable() {
    //---从cache中加载数据，然后初始化所有表格；
    total_price = 0;

    // }
    $(".shoppingcar-container").empty();
    $.get("/mainpage/get_cart", function (data, status) {
        var obj = JSON.parse(data);
        var arrayObj = obj.shoppingcar_array;
        var shop_info = obj.shop_info;
        var arrayLen = arrayObj.length;
        console.log(arrayObj);
        console.log(shop_info);
        var itemsObj;
        var shopId;
        var shopName;
        var shopDeliverFee;
        for (var shop_id in arrayObj) {
            console.log("here");
            shopId = shop_id;
            itemsObj = arrayObj[shopId];
            console.log(shopId + ": " + arrayObj[shopId]);
            //console.log("shopId:" + shopId + " 商品列表：" + itemsObj);
            console.log("ShopId: " + shopId);
            shopName = shop_info[shopId].shopname;
            shopDeliverFee = shop_info[shopId].deliver_fee;
            console.log(shopName);
            $('<table id="customers" data-shop-id=' + shopId + '><thead><th colspan="3" class="shop-name=th">' + shopName + '</th></thead><tbody></tbody>').appendTo(".shoppingcar-container");
            var $tableBody = $(".shoppingcar-container #customers:last").find("tbody");
            console.log("itemsObj: " + itemsObj);
            for (var kk in itemsObj) {
                var merchId = kk;
                var merchanCount = itemsObj[kk].cnt;
                console.log("merchId: " + kk);
                console.log("数量：" + merchanCount);
                var foodPrice;
                var foodName;
                var foodImg;
                var aRow;
                foodPrice = itemsObj[kk].price;
                //console.log("测试" + foodPrice);
                foodName = itemsObj[kk].food_name;
                foodImg = itemsObj[kk].food_img;
                aRow = '<tr><td width="60%" colspan="2" class="description"><ul><li><img data-food-id=' + merchId + ' src=\"/media/' + foodImg + '\" height=150px width=200px class="food-img"></li><li><div class="shoppingcar-description"><p>' + foodName + '</p><p><span class="count">' + merchanCount + ' * </span><span class="multiply"x</span><span class="dollar">' +
                    foodPrice + '￥</span></p></div></li></ul></td><td width="40%" class="operation"><ul><li><button class="decrease">-</button><input class="good-count" type="text">' + merchanCount + '</input><button class="plus">+</button></li><li class="delete-li"><button class="btn btn-danger delete">删除</button></li></ul></td></tr>';
                $tableBody.append(aRow);
                //  });
                total_price += foodPrice * merchanCount;
            }
            total_price += shopDeliverFee;
            var aFooter = '<tfoot><tr><td colspan="3"><div><p><b>总价:' + total_price + '</b><span class="dollar total-price"></span></p></div><div class="clearfix"></div><p><b>+配送费</b><span class="deliver-dollar">' + shopDeliverFee + '</span>元</p></td></tr><tr><td colspan="3"><ul><li><button class="btn ttn-info" onclick=\"place_order(' + shop_id + ',' + total_price + ')\">确定下单</button></li><li><button class="btn btn-link cancel">取消</button></li></ul></td></tr>';
            $(".shoppingcar-container #customers:last").append(aFooter);
            total_price = 0;
        }
    });

    //计算每个table的价格
    $("table").each(function () {
        recalculateTotalPrice($(this));

    });
}

function checkTableEmpty($table) {
    //alert($table.find("tbody tr").length);
    if ($table.find("tbody tr").length == 1) {
        $table.remove();
        return true;
    }
    return false;
}

function ensureOrder($table) {
    var shopId = $table.attr("data-shop-id");
    var orderTotalPrice = parseInt($table.find("span.total-price").text());
    var address_id;
    $.get("#", function (data, status) {
        address_id = data;
    });
    //将订单信息传入

    //将订单具体信息传入
    var orderDetail = {};
    $table.find("tbody tr").each(function () {
        var foodId = $(this).find(".food-img").attr("data-food-id");
        var foodNum = $(this).find("span.count").text();
        orderDetail[foodId] = foodNum;
    });

    console.log("before stringify:" + orderDetail);
    var orderDetailStr = JSON.stringify(orderDetail);
    console.log("after stringify:" + orderDetailStr);
    $.post("#", {order_detail: orderDetailStr}, function (data, status) {

    });
}

function cancelOrder($table) {
    $table.remove();
    if ($(".shoppingcar-container").find("table").length == 0) {
        $(".content").append("<p>购物车已空</p>");

    }
}

function place_order(shop_id, totalprice) {
    $.post("place_order", {csrfmiddlewaretoken: csrftoken, shop_id: shop_id, total_price: totalprice},
        function (data, status) {
            if (data == 1) {
                location.reload();
            }
        });
}
