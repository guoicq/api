<%@ Control Language="C#" Inherits="Duplium.Shop.Frontend.BaseViewUserControl" %>
        
<script type="text/javascript">
    /*!
        * postalcode validator and multilingual of message
        * Date: 20 Nov 2014
        * Usage: 
        *       $('form').tipValidate();
        *       $('form').tipValidate({
        *            position:{
        *                my:'top center',
        *                at:'bottom center'
        *            },
        *            style: {
        *                tip: {
        *                    corner: 'top center'
        *                },
        *                classes: 'qtip-rounded field-bubble'
        *            }
        *        });
        */
    (function ($) {

        jQuery.validator.addMethod("naPostal", function (postal, element) {
            if (this.optional(element)) return true;
            var ctyField = $(element).attr("countryField");
            if (ctyField && $(ctyField).val() == "CA") return postal.match(/[a-zA-Z][0-9][a-zA-Z](-| |)[0-9][a-zA-Z][0-9]/);
            if (ctyField && $(ctyField).val() == "US") return postal.match(/^\d{5}(?:[\s-]\d{4})?$/);
            return postal.match(/^\d{5}-\d{4}$|^\d{5}$|^[a-zA-Z][0-9][a-zA-Z](| )?[0-9][a-zA-Z][0-9]$/gm);
        }, "<%=Resources.Resources.MsgInvalid%>");

        jQuery.validator.addMethod("cdnPostal", function (postal, element) {
            return this.optional(element) ||
            postal.match(/[a-zA-Z][0-9][a-zA-Z](-| |)[0-9][a-zA-Z][0-9]/);
        }, "<%=Resources.Resources.MsgInvalid%>");

        jQuery.validator.addMethod("cdnPostal", function (postal, element) {
            return this.optional(element) ||
            postal.match(/^\d{5}(?:[\s-]\d{4})?$/);
        }, "<%=Resources.Resources.MsgInvalid%>");

        jQuery.extend(jQuery.validator.messages, {
            required: "<%= Resources.Resources.MsgThisFieldIsRequired %>",
            email: "<%= Resources.Resources.MsgInvalid %>",
            naPostal: "<%= Resources.Resources.MsgInvalid %>",
            number: "<%= Resources.Resources.MsgInvalid %>",
            //digits: "Please enter only digits.",
            creditcard: "<%=Resources.Resources.MsgInvalid%>",
            equalTo: "<%= Resources.Resources.MsgPleaseEnterSameValue %>"
        });


        /*!
            * Display validation message in qTip
            * Date: 20 Nov 2014
            */

        jQuery.fn.tipValidate = function (options) {
            // Run this function for all validation error messages
            // $('.field-validation-error').each
            var self = this;

            self.attr('data-tip-validate', 'yes');
            self.validate();


            var settings = {
                position: {
                    my: 'left center',
                    at: 'right center'
                },
                style: {
                    tip: {
                        corner: 'left center'
                    },
                    classes: 'qtip-rounded qtip-yellow validation-bubble'
                }
            };

            $.extend(settings, options);

            $('.field-validation-error').each(function (index, value) {
                // Get the name of the element the error message is intended for
                // Note: ASP.NET MVC replaces the '[', ']', and '.' characters with an
                // underscore but the data-valmsg-for value will have the original characters
                var inputElem = '#' + $(this).attr('data-valmsg-for').replace('.', '_').replace('[', '_').replace(']', '_');

                var corners = ['left center', 'right center'];
                var flipIt = $(inputElem).parents('span.right').length > 0;

                // Hide the default validation error
                $(this).attr("data-message", $(this).text());
                $(this).text("*");

                // Show the validation error using qTip
                $(inputElem).addClass("error");

                if (index == 0) {
                    //$(inputElem).focus();
                }
            });

            $('form input,form select').change(function () {
                var validator = $.data(this.form, "validator");
                validator.element(this);
            });

            $('form input,form select').blur(function () {
                var validator = $.data(this.form, "validator");
                validator.element(this);
            });

            $('label').live('hover', function () {

                if ($(this).hasClass('error')) {

                    var msg = $(this).find('div').attr('data-message');
                    $(this).qtip({
                        overwrite: false,
                        content: {
                            text: msg
                        },
                        show: {
                            event: event.type,
                            ready: true
                        },
                        style: {
                            tip: {
                                corner: 'right center'
                            },
                            classes: 'qtip-rounded qtip-red validation-bubble'
                        }
                    });
                }
            });

            $('form input, form select').blur(function () {
                $(this).qtip('destroy');
            });

            $('form input, form select').bind('focus change', function () {

                if ($(this).hasClass('error')) {

                    var label = $("label[for='" + $(this).attr('id') + "']");
                    var msg
                    if (typeof label !== "undefined") {
                        msg = label.attr('data-message');
                    }
                    else {
                        label = $("span[data-valmsg-for='" + $(this).attr('id').replace('.', '_').replace('[', '_').replace(']', '_') + "']");
                        if (typeof label !== "undefined")
                            msg = label.attr('data-message');
                    }
                    if (typeof msg === "undefined") {
                        msg = "<%=Resources.Resources.MsgInvalid%>";
                        if ($(this).attr('type') == "checkbox")
                            msg = "<%=Resources.Resources.MsgRequired%>";
                    }

                    //msg = "rer";
                    $(this).qtip({
                        overwrite: false,
                        content: {
                            text: msg
                        },
                        show: {
                            event: 'focus',
                            ready: true
                        },
                        hide: {
                            event: 'blur'
                        },
                        position: settings.position,
                        style: settings.style
                    });
                }
                else {

                    $(this).qtip('destroy');
                }
            });

        }

    })(jQuery);

</script>
