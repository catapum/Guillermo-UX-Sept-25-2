import { LightningElement , api } from 'lwc';
import getProductLoanAa from '@salesforce/apex/GetRecordId.getProductLoanAa'

export default class FscDigitalLending extends LightningElement {
    @api app_welcome_text = "Welcome to the Digital Lending App";
    @api app_description = "What category of capabilities are you interested in?";
    @api no_record_product_loan_aa = false;

    productLoanAaId;

    connectedCallback() {

        getProductLoanAa()
        .then(result => {
            if (result.length) {
                this.no_record_product_loan_aa = false;
                this.productLoanAaId = result[0].Id;
            } else {
                this.no_record_product_loan_aa = true;
                this.productLoanAaId = ""
            }
        })
    }

    get pass_false() {
        return false;
    }

    get pass_true() {
        return true;
    }

}