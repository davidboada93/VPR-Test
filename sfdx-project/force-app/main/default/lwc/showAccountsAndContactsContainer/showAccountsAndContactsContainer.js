import { LightningElement } from 'lwc';

export default class ShowAccountsAndContactsContainer extends LightningElement {
    selectedAccountId;

    handleAccountSelected(event) {
        this.selectedAccountId = event.detail;
    }
}
