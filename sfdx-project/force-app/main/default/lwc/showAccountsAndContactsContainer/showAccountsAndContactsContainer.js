import { LightningElement } from 'lwc';

export default class ShowAccountsAndContactsContainer extends LightningElement {
    selectedAccountId;

    handleAccountSelected(event) {
        this.selectedAccountId = event.detail; // Capture the account ID
        console.log('Selected Account ID:', this.selectedAccountId); // Debugging log
    }
}
