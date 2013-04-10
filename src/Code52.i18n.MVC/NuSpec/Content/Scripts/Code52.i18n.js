(function (window) {
    var i18n = function () {
        var base = this;
        base.init = function () {
            base.lang.init();
        };
        base.lang = {
            settings: {
                placeholderregionsID: '#placeholder-regions',
                langOptionsContainerID: '#i18n-options-container',
                langOptionsRegionsID: '#i18n-regions',
                currentLanguage_Link: '#currentlanguage_link',
                currentLanguage_Text: '#currentlanguage_text'
            },
            init: function () {
                var languagesDisplayed = false;
                $(base.lang.settings.currentLanguage_Link).attr('title', Globalize.culture().nativeName);
                $(base.lang.settings.currentLanguage_Text).html(Globalize.culture().nativeName);
                $(base.lang.settings.langOptionsContainerID).hover(function () {
                    $(this).stop().animate({ backgroundColor: '#E4EBF4' });
                }, function () {
                    $(this).stop().animate({ backgroundColor: 'white' });
                });

                $("#expandSign").html('[+]');
                $(base.lang.settings.langOptionsContainerID).click(function () {
                    if (languagesDisplayed) {
                        $(base.lang.settings.langOptionsRegionsID).slideToggle('swing');
                        $("#expandSign").html('[+]');
                        languagesDisplayed = false;
                    } else {
                        $(base.lang.settings.langOptionsRegionsID)
                        .remove()
                        .prependTo(base.lang.settings.placeholderregionsID).slideToggle('swing');
                        $('.language a').click(function () {
                            if ($(this).hasClass(Globalize.culture().name.toLowerCase()))
                                return false;
                            $.cookie("_culture", $(this).attr("class"), { expires: 365, path: '/' /*, domain: 'example.com' */ });
                            window.location.reload(); // reload 
                            return false;
                        });
                        $("#expandSign").html('[&minus;]');
                        languagesDisplayed = true;
                    }
                });
            }
        };
        base.init();
    };
    window.Code52 = {};
    window.Code52.Language = {
        instance: null,
        defaults: {
        },
        Init: function (culture) {
            Globalize.culture(culture);
            window.Code52.Language.instance = new i18n();
        }
    };
})(window);