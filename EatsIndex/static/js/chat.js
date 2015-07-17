$(document).ready(function(){
    var tabs = $('#tabs');
    var say  = $("button.say");
    var opener_CreateGroup = $( "#opener-CreateGroup" );
    var opener_JoinGroup = $( "#opener-JoinGroup" );
    var GroupCreater = $('#GroupCreater');
    var GroupFactory = $('#GroupFactory');
    var JoinGroup = $('#JoinGroup');
    var JoinGroupHelper = $('#JoinGroupForm');
    var createGroupTips = $('#createGroupTips');
    var joinGroupTips = $('#joinGroupTips');
    // $("button").click(function(){
    //     $.post("/api/sendmsg/",
    //         {
    //             name: "Ycc"
    //         },
    //         function(data, status){
    //           alert("Data: " + data + "\nStatus: " + status);
    //     });
    // });
     // make sure AJAX-requests send the CSRF cookie, or the requests will be rejected.
    var csrftoken = $('input[type=hidden][name=csrfmiddlewaretoken]').val();

    $.ajaxSetup({
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRFToken', csrftoken);
        }
    });

    say.click(function(){
        var button = this;
        var userName = $(".user_login>a").html();
        var talkto =  $(this).closest('div[id^=tabs-]').attr("talkto");
        console.log(userName);
        if ($(button).prev().val() == "") {
            return ;
        }
        
        $.ajax({
            type: "POST",
            url: "/api/sendmsg/",
            data: {
                when : new Date().getTime(),
                who  : talkto,
                what : $(button).prev().val()
            },
            dataType: "json",
            beforeSend: function() {
                var newWord = '<li class="words">'
                            +      '<span class="when"></span> '
                            +      '<strong class="who"></strong>'
                            +      '<div class="what"></div>'
                            + '</li>';
                var ret = $(newWord);
                ret.addClass("uploading");
                var dst = $(button).closest('.dialog').find(".dialog-ul");
                dst.append(ret);
                $("li.words>span.when", dst).last().html("["+ new Date().toLocaleString() +"]");
                $("li.words>strong.who", dst).last().html(userName);
                $("li.words>div.what", dst).last().html($(button).prev().val());
                $(button).prev().val("");
            },
            success: function(data) {
                $("li.words").removeClass("uploading");
            },
            error: function(){
                alert(arguments[1]);
            }
        });
    });
    
    function recvMsg() {
        var newWord = '<li class="words">'
                    +      '<span class="when"></span> '
                    +      '<strong class="who"></strong>'
                    +      '<div class="what"></div>'
                    + '</li>';
        $.ajax({
            type : "GET",
            url  : "/api/recvmsg",
            dataType : "json",
            success : function(data) {
                if (data["MsgCount"] == 0) {
                    return ;
                } else {
                    $("div[id^=tabs-]").each(function() {
                        for (var i = 0; i < data["Messages"].length; i++) {
                            if (data["Messages"][i]["uid"] == $(this).attr("talkto")) {
                                var dst = $(this).find(".dialog-ul");
                                var newList = $(newWord);
                                dst.append(newList);
                                $("li.words>span.when", dst).last().html("["+ new Date(parseFloat(data["Messages"][i]["when"])).toLocaleString() +"]");
                                $("li.words>strong.who", dst).last().html(data["Messages"][i]["who"]);
                                $("li.words>div.what", dst).last().html(data["Messages"][i]["what"]);
                            }
                            
                        }; 
                    });
                }
                console.log(data)
            }
        });
    }
    setInterval(recvMsg, 4000);

    function CreateGroup() {
        GroupFactory.submit();
    }

    function JoinAGroup() {
        JoinGroupHelper.submit();
    }

    $(function() {
        tabs.tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
        tabs.find("li").removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
    });

    GroupCreater.dialog({
        autoOpen: false,
        buttons : {
            "Create new group" : CreateGroup,
        },
        close : function() {
            $("#choosefriends").empty();
        }
    });

    JoinGroup.dialog({
        autoOpen : false,
        buttons  : {
            "Join a group" : JoinAGroup,
        },
    });

    opener_CreateGroup.click(function() {
        var UserCheckboxTemplate = '' + 
            '<div>' +
                '<label for="UserId" class="checkboxLabel">UserName</label>' +
                '<input type="checkbox" name="choices" value="UserId" id="UserId">' +
            '</div>';
        $.ajax({
            type : "GET",
            url  : "api/qfriends",
            dataType : "json",
            success : function(data) {
                if (data["MsgCount"] == 0) {
                    return ;
                } else {
                    for (var i = 0; i < data["friends"].length; i++) {
                        var UserCheckbox = UserCheckboxTemplate;
                        UserCheckbox = UserCheckbox.replace(/UserId/g, data["friends"][i]["uid"]);
                        UserCheckbox = UserCheckbox.replace(/UserName/g, data["friends"][i]["name"]);
                        var newUserCheckBox = $(UserCheckbox);
                        $("#choosefriends").append(newUserCheckBox);
                    };
                }
                console.log(data)
            }
        });
        GroupCreater.dialog( "open" );
    });

    opener_JoinGroup.click(function() {
        JoinGroup.dialog("open");
    })

    function updateTips(widgets, tips) {
        widgets.text(tips).show();
    }

    function addGroupTab(data) {
        var tabCounter = $('#tabs>ul>li').size()+1;
        var TabNavTemplates = '<li><a href="#tabs-{Id}" >{GroupName}</a></li>';
        var TabItemTemplates = '<div id="tabs-{Id}" talkto="{GroupId}" >'
        +    '<div class="dialog">'
        +        '<div class="headerInfo">'
        +            '<strong>Chatting with {GroupName}</strong>'
        +        '</div>'
        +        '<div class="dialog-content" >'
        +            '<ul class="dialog-ul">'
        +            '</ul>'
        +        '</div>'
        +        '<div class="dialog-text">'
        +            '<div class="dialog-text-wrapper">'
        +                '<textarea name="text" class="textarea"></textarea>'
        +                '<button type="button" class="say">Say</button>'
        +            '</div>'
        +        '</div>'
        +    '</div>'
        +'</div>';
        var TabNav = TabNavTemplates.replace(/\{Id\}/g, tabCounter);
        TabNav = TabNav.replace(/\{GroupName\}/g, data['GroupName']);
        var TabItem = TabItemTemplates.replace(/\{Id\}/g, tabCounter);
        TabItem = TabItem.replace(/\{GroupId\}/g, data['GroupId']);
        TabItem = TabItem.replace(/\{GroupName\}/g, data['GroupName']);
        var newTabNav = $(TabNav);
        $('#tabs>ul').append(newTabNav);
        var newTabItem = $(TabItem);
        tabs.append(newTabItem);
        tabs.tabs("refresh");
        GroupCreater.dialog("close");
        console.log(data);
    }

    // var options = { 
    //         target:        '#output1',   // target element(s) to be updated with server response 
    //         beforeSubmit:  showRequest,  // pre-submit callback 
    //         success:       showResponse  // post-submit callback 
     
    //         // other available options: 
    //         //url:       url         // override for form's 'action' attribute 
    //         //type:      type        // 'get' or 'post', override for form's 'method' attribute 
    //         //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
    //         //clearForm: true        // clear all form fields after successful submit 
    //         //resetForm: true        // reset the form after successful submit 
     
    //         // $.ajax options can be used here too, for example: 
    //         //timeout:   3000 
    // }; 
    
    // bind form using 'ajaxForm' 
    GroupFactory.ajaxForm({
        type : 'POST',
        url  : '/api/group/create',
        dataType : 'json',
        resetForm: true,
        beforeSubmit : function(formData, jqForm, options) {
            console.log(formData);
            if (formData[0].value == null || formData[0].value == '') {
                updateTips(createGroupTips, "The name field is null!");
                $("#12create").addClass( "ui-state-error" );
                return false;
            };
        },
        success: function(data) {
            if (data.success) {
                addGroupTab(data);
                GroupCreater.dialog("close");
            } else {
                updateTips(createGroupTips, data['reason']);
            }
        },
    });

    JoinGroupHelper.ajaxForm({
        type : "POST",
        url  : '/api/group/join',
        dataType : 'json',
        resetForm: true,
        beforeSubmit : function(formData, jqForm, options) {
            var nameCheck = formData[0].value.replace(/ /g, '');
            if (formData[0].value == null || formData[0].value == '') {
                $("#12join").addClass( "ui-state-error" );
                updateTips(joinGroupTips, "The name field is null!");
                return false;
            }
        },
        success : function(data) {
            if (data.success) {
                addGroupTab(data);
                JoinGroup.dialog("close");
            } else {
                updateTips(joinGroupTips, data['reason']);
            }
        },
    });
    createGroupTips.hide();
    joinGroupTips.hide();
});