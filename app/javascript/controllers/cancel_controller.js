import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
    static targets = [ 
      "code",
      "mobile_phone",
      "order_info",
      "verify_form",
      "verifymsg_code",
      "current_order",
      "errors"
    ]

    connect(){
      console.log('hi there')
    }

    findOrder(){
      Rails.ajax({
        type: "GET",
        url: "/cancel_order/order_found",
        data: "code=" + this.codeTarget.value + "&mobile_phone=" + this.mobile_phoneTarget.value,
        success: (data) => {
          this.order_infoTarget.innerHTML = data.body.innerHTML;
        },
      });
    }

    acceptButton(){
      this.verify_formTarget.hidden = false;
      Rails.ajax({
        type: "POST",
        url: "/cancel_order/send_verification",
        data: "current_order_id=" + this.current_orderTarget.innerHTML,
      });
    }

    verifyMessage(){
      Rails.ajax({
        type: "POST",
        url: "/cancel_order/verify_code",
        data: "current_order_id=" + this.current_orderTarget.innerHTML + "&code_input=" + this.verifymsg_codeTarget.value,
        success: (data) => {
          if(data){
            this.errorsTarget.innerHTML = data.body.innerHTML
          }
        },
      if(data = null){
          gotoUrl();
      }
      });
    }
}